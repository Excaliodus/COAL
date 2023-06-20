[org 0x0100]
jmp start

clrscr:	push es
		push ax
		push di
		mov ax, 0xb800
		mov es, ax
		mov di, 0

nextloc:	mov word [es:di], 0x0720
			add di, 2
			cmp di, 4000
			jne nextloc
			pop di
			pop ax
			pop es
			ret

bucket:	push es
		push ax 
		push bx
		push cx
		push di
		mov bx,20
		mov ax,0xb800
		mov es,ax
		mov ax,0
		mov al,80
		mul bx
		add ax,35 ;x pos
		shl ax,1

		mov di,ax
		mov cx, 3
		
l1:		mov word[es:di], 0x1020
		add di, 12
		mov word[es:di], 0x1020
		add di, 148
		dec cx
		cmp cx, 1
		jne l1
		
		mov bx,7
		loop1:	mov word[es:di], 0x1020
				add di,2
				dec bx
				jnz loop1

		pop di
		pop cx
		pop bx
		pop ax
		pop es
		ret

start:	call clrscr
		call bucket

mov ax,0x4c00
int 0x21