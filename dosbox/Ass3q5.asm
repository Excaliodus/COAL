[org 0x0100]

;Concept from number printing applied to seperate digits from number. Each digit is squared and added into var 'num'. If num becomes 1 'true' becomes 1 else zero

jmp start

clrscr:	push es
		push ax
		push cx
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		mov ax, 0x0720
		mov cx, 2000
		
		cld
		rep stosw
		
		pop di
		pop cx
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
			
			push ds
			pop es
			mov di, [bp+4]
			mov cx, 0xffff
			xor al, al
			repne scasb
			mov ax, 0xffff
			sub ax, cx
			dec ax
			jz exit
			
			mov cx, ax
			mov ax, 0xb800
			mov es, ax
			mov al, 80
			mul byte [bp+8]
			add ax, [bp+10]
			shl ax, 1
			mov di,ax
			mov si, [bp+4]
			mov ah, [bp+6]
			
			cld

nextchar:	lodsb
			stosw
			loop nextchar
			
exit:	pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
		ret 8

isHappy:	push bp
			mov bp,sp
			push ax
			push bx
			push cx
			push dx
			push si
			push di
			mov ax, [bp+4]
			mov si, 0

back:	mov bx, 10
		mov cx, 0
			
nextdigit:	mov dx, 0
			div bx
			mov di, ax
			mov ax, dx
			mul dx
			mov dx, [num]
			add ax, dx
			mov [num], ax
			mov ax, di
			inc cx
			cmp ax, 0
			jnz nextdigit
			cmp si, 255
			je ncheck
			inc si
			mov ax, [num] 
			cmp ax, 1
			je check
			mov word [num], 0
			jmp back
			
check:	mov word [true], 1
		jmp end

ncheck:	mov word [true], 0
		jmp end
		
end:	pop di
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2

printHappy:	call clrscr
			mov ax, 0
			push ax
			mov ax, 0
			push ax
			mov ax, 1
			push ax
			mov ax, str1
			push ax
			call printstr
			jmp exit1

printUnhappy:	call clrscr
				mov ax, 0
				push ax
				mov ax, 0
				push ax
				mov ax, 1
				push ax
				mov ax, str2
				push ax
				call printstr
				jmp exit1

start:	mov bx, 0
		
		mov ah,0
		int 0x16
		mov ah,0
		sub al, 48
		mov dx, 1000
		mul dx
		add bx,ax
		
		mov ah,0
		int 0x16
		mov ah,0
		sub al, 48
		mov dx, 100
		mul dx
		add bx,ax
		
		mov ah,0
		int 0x16
		mov ah,0
		sub al, 48
		mov dx, 10
		mul dx
		add bx,ax
		
		mov ah,0
		int 0x16
		mov ah, 0
		sub al, 48
		add bx,ax
		
		mov ax, bx
		push ax
		call isHappy
		mov ax, [true]
		cmp ax, 1
		je printHappy
		jmp printUnhappy

exit1:	mov ax, 0x4c00
		int 0x21

true:	dw 0
num:	dw 0
str1:	db 'Happy', 0
str2:	db 'Unhappy', 0