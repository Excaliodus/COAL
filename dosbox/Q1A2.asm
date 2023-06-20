[org 0x0100]
jmp start

value:dw 1101011011010110b
mask:db 00000111b
string:db '000000'

start: 	mov ax, [value]
		push ax
		mov ax,string
		push ax
		call splitoctal
		mov ax,0x4c00
		int 21h

splitoctal:	push bp
			mov bp,sp
			push ax
			push bx
			push cx
			push dx
			push si
			push di
			mov dx,0
			mov cx,0
			mov si,0
			mov di,[bp+4] ;des
			mov bl,[mask] ;mask

l1:	mov ax,[bp+6] ;val
	mov bl, 7
	shl bl,cl
	and al,bl
	shr al,cl
	add al,48
	mov [di+5],al
	sub di,1
	inc dx
	add cl,3
	cmp dx,3
	jne l1

			mov dx,0
			mov cx,0
			mov si,0
			mov di,[bp+4] ;des
			mov bl,[mask] ;mask

l2:	mov ax,[bp+6] ;val
	mov bl, 7
	shl bl,cl
	and ah,bl
	shr ah,cl
	add ah,48
	mov [di+2],ah
	sub di,1
	add cl,3
	inc dx
	cmp dx,3
	jne l2

	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret 4