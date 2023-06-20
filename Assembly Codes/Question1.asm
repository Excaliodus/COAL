[org 0x0100]

jmp start

rotation:	push bp
		mov bp, sp
		mov bx, [bp+10]
		mov ax, [bp+6]
		mov cx, [bp+4]
		cmp ax,1
		je right
		cmp ax,0
		je left
		rol bx,cl
		jmp end

right:	mov si,0
	mov dx,1
	mov ax, [bx+si]

l1:	mov cx,[bx+si+2]
	mov [bx+si],cx
	add si,2
	inc dx
	cmp dx,4
	jne l1
	mov [bx+si],ax
	ret 4

left:	mov si,6
	mov dx,1
	mov ax, [bx+si]

l2:	mov cx,[bx+si-2]
	mov [bx],cx
	sub si,2
	inc dx
	cmp dx,4
	jne l2
	mov [bx],ax
	ret 4

start:	push myArray
	push word[length]
	push word[direc]
	push word[NoRotations]
	call rotation

end:	mov ax, 0x4c00
	int 0x21

myArray: dw 1,2,3,4
length: dw 4
direc: dw 1
NoRotations: dw 1