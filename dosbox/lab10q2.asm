[org 0x0100]
jmp start

prtastr:	push bp 
			mov bp,sp
			push es
			push bx
			push cx
			push di
			mov bh, ah
			mov bx,20
			mov ax,0xb800
			mov es,ax
			mov ax, 2000
			cmp bh, 1
			je right
			cmp bh, 2
			je left
			cmp bh, 3
			je up
			cmp bh, 4
			je down

back:		mov di, ax
			mov dh,0x07
			mov dl,'*'
			mov word [es:di], dx
			pop di
			pop cx
			pop bx
			pop es
			pop bp
			iret

up:	sub ax, 640
	jmp back

down:	add ax, 640
		jmp back
	
left:	sub ax, 10
		jmp back
	
right:	add ax, 10
		jmp back
	
	
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
		
start:	call clrscr
		xor ax, ax
		mov es, ax
		mov word [es:80h*4], prtastr
		mov [es:80h*4+2], cs
		
		mov ah,0
		int 0x16
		mov ah,0
		call clrscr
		int 80h
		
		mov ah,0
		int 0x16
		mov ah,4
		call clrscr
		int 80h
		
		mov ah,0
		int 0x16
		mov ah,1
		call clrscr
		int 80h
		
		mov ah,0
		int 0x16
		mov ah,3
		call clrscr
		int 80h
		
		mov ah,0
		int 0x16
		mov ah,2
		call clrscr
		int 80h

mov ax, 0x4c00
int 0x21