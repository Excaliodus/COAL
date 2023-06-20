[org 0x0100]

mov bl, 0
mov al, 0
mov cl, [size]

l1:	add al, [myArray+bx]
	add bl, 1
	cmp bl, cl
	jne l1

mov cl,al
mov bl, 0
mov ch, [size]

l2:	sub cl,[size]
	inc bl
	cmp cl, ch
	jae l2

mov [MEAN],bl

mov ax, 0x4c00 
int 0x21

myArray: db 1,2,2,3,1,3,2,3
size: 	db 8
MEAN: 	db 0