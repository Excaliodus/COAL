[org 0x0100]

mov bx, 0
mov ax, 0

l1:	add ax, [myArray+bx]
	add bx, 2
	cmp bx, [size]
	jne l1

mov ax, 0x4c00 
int 0x21

myArray:	db 1,2,2,3,1,3,2,3
size: 	db 8
MEAN: 	db 2