[org 0x0100]

mov bx,0xB189
mov ax,0xABA5
mov cx,16
mov dx,0
mov [Num1],bx
mov [Num2],ax

l1:	shr bx,1
	jc increm
	dec cx
	jns l1
	inc cx
	cmp cx,0
	je mid

increm:	inc dx
	dec cx
	jmp l1

mid:	mov bx,[Num1]
	mov ax,[Num2]
	mov si,0
	mov cx,0x0001

l2:	xor ax,cx
	shl cx,1
	inc si
	cmp si,dx
	jnz l2

mov ax, 0x4c00
int 21h

Num1: dw 0
Num2: dw 0