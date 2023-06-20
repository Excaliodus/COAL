[org 0x0100]

mov bx,0
mov cl,6
mov ch,14
mov si,0
mov dx,0
jmp outer

diff:	mov dx,[set1+bx]
	mov [difference+di],dx
	add di,2
	cmp ch,0
	je end
	jmp outerinc

innerinc:	sub cl,2
		add si,2
		jmp inner

outerinc:	mov si,0
		sub ch,2
		add bx,2
		mov cl,6
		jmp outer

outer:	mov ax,[set1+bx]
	inner:	cmp ax,[set1+si]
		je outerinc
		cmp cl,0
		je diff
		cmp cl,0
		jne innerinc
	cmp ch,0
	jne outerinc

end:	mov ax, 0x4c00
	int 0x21

difference: dw 0,0,0,0,0,0,0
set1: dw -3,-1,2,5,6,8,9
set2: dw 1,3,7