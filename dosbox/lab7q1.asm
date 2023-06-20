[org 0x0100]

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

replace:	mov bl, [repw]
		mov [si],bl
		mov bh, [inst]
		inc bh
		mov [inst], bh
		jmp print

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
		mov bl,[repc]
		cmp [si],bl
		je replace
print:		stosw
		loop nextchar

exit:	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 8

start:	call clrscr
	mov ax, 30
	push ax
	mov ax, 20
	push ax
	mov ax, 1
	push ax
	mov ax, message
	push ax
	call printstr

mov ax, 0x4c00
int 0x21

message: db 'Hello this is a string', 0
repc:	 db 'i'
repw:	 db 't'
inst:	 db 0