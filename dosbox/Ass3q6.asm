[org 0x0100]

jmp start

swapscr:	push ax
			push cx
			push bx
			mov ax, 0xb800
			mov es, ax
			mov cx, 0
			mov si, 0
			mov di, 2000

l1:		mov ax, [es:si]
		mov bx, [es:di]
		mov [es:di], ax
		mov [es:si], bx
		add si, 2
		add di, 2
		add cx, 2
		cmp si, 2000
		jge end
		cmp cx, 80
		jne l1
		add si, 80
		add di, 80
		mov cx, 0
		jmp l1
		
		
end:	pop bx
		pop cx
		pop	ax
		ret
		
start:	mov ah,0
		int 0x16
		call swapscr
		jmp start

mov ax, 0x4c00
int 0x21