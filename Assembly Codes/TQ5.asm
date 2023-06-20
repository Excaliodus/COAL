[org 0x0100]
mov bx,0
mov cl,20
mov ch,20
mov si,0
mov dx,0
jmp outer

addition:	add dx,[myArray+bx]
		cmp ch,0
		je end
		jmp outerinc

innerinc:	sub cl,2
		add si,2
		jmp inner

outerinc:	mov si,0
		sub ch,2
		add bx,2
		mov cl,20
		jmp outer

outer:	mov ax,[myArray+bx]
	inner:	cmp si,bx
		je innerinc
		cmp ax,[myArray+si]
		je outerinc
		cmp cl,0
		je addition
		cmp cl,0
		jne innerinc
	cmp ch,0
	jne outerinc

end:	mov [sum],dx

mov ax, 0x4c00
int 0x21

sum: dw 0
myArray: dw 10,7,4,9,5,3,4,8,2,0