[org 0x0100]

jmp start

change:	mov dx,0
	jmp end

start:	mov dx,1
	mov ax,[Num1]
	mov bx,[Num2]
	mov cx,bx
	and cx,ax
	cmp cx,bx
	jne change

end:	mov ax, 0x4c00
	int 21h

Num1: 	dw 8
Num2: 	dw 2