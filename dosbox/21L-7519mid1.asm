[org 0x0100]
jmp start

clrscr:	push es
	push ax
	push di
	mov ax, 0xb800
	mov es, ax
	mov di, 0
	nextloc: mov word [es:di], 0x0720
	add di, 2
	cmp di, 4000
	jne nextloc
	pop di
	pop ax
	pop es
	ret

printstr:	push bp 
		mov bp, sp 
		push es 
		push ax 
		push cx 
		push si 
		push di 
		mov ax, 0xb800 
		mov es, ax
		mov di, 0
		mov si, [bp+6]
		mov cx, [bp+4]
		mov ah, 0x07

nextchar:	mov al, [si]
		mov [es:di], ax
		add di, 2
		add si, 1
		loop nextchar
		pop di 
		pop si 
		pop cx 
		pop ax 
		pop es 
		pop bp 
		ret 4

printnum:	push bp 
		mov bp, sp 
		push es 
		push ax 
		push bx 
		push cx 
		push dx 
		push di 
		mov ax, 0xb800 
		mov es, ax
		mov ax, [bp+4]
		mov bx, 10
		mov cx, 0

nextdigit:	mov dx, 0
		div bx
		add dl, 0x30
		push dx
		inc cx
		cmp ax, 0
		jnz nextdigit
		mov di, 0 

nextpos:	pop dx
		mov dh, 0x07
		mov [es:di], dx
		add di, 2
		loop nextpos
		pop di 
		pop dx 
		pop cx 
		pop bx 
		pop ax 
		pop es 
		pop bp 
		ret 2

swtcheck:	push bp
		mov bp, sp
		mov si, [bp+8]	;Array location
		mov cx, [bp+6]	;Length of array
		mov dx, [bp+4]	;Sweetness measure
		add cx, cx
		
		mov ax, [si]
		cmp ax, dx
		jge skip

		mov bx,[si+2]
		add bx, bx
		mov ax, [si]
		add ax, bx
		mov [new],ax
		mov [si],0
		mov [si+2],0
		mov bx,0
		inc bh

l1:
	l2:	mov ax,[si+4+bx]
		mov [si+bx], ax
		add bl,2
		mov ax, bx
		add ax, 4
		cmp cx, ax
		jne l2
	mov [si+cx-2],0
	mov [si+cx-4],0
	mov bl,0
	l3:	mov ax,[new]
		cmp [si+bl],ax
		
	sub cx,2
	inc bh
	cmp [si],dx
	jge possible
	cmp cx, 2
	je notp

skip:	mov ax, 0
	mov [val],ax
	ret 0

notp:	cmp [si],dx
	jge possible
	jmp notpossible

possible:	mov ax, bx
		mov [val], ax
		pop bp
		ret 1
		
notpossible:	mov ax, -1
		mov [val], ax
		pop bp
		ret -1

start:	mov ax, Arr
	push ax
	mov ax, N
	push ax
	mov ax, K
	push ax
	call swtcheck
	mov ax, [val]
	cmp ax, -1
	jne possib

notpossib:	call clrscr
		mov ax, message 
		push ax
		push word [length]
		call printstr
		jmp end

possib:	call clrscr
	mov ax, message1
	push ax
	push word [len1]
	call printstr
	mov ax, [val]
	push ax
	call printnum

end:	mov ax, 0x4c00
	int 0x21

N: dw 6
K: dw 7
Arr: dw 1,2,3,9,10,12
new: dw 0
val: dw 0	;stores -1 if not possi and no of operations if possi
message: db '-1 Not possible'
length: dw 15
message1: db 'Possible'
len1: dw 8