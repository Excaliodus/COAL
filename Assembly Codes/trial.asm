[org 0x0100]

mov ax,0
mov bx,0

l1:	add ax,[myArray+bx]
	inc bx
	cmp bx,size
	jne l1
mov bx,0
l2:	inc bx
	sub ax,size
	jns l2
sub bx,1
mov [Mean],bx

mov ax, 0x4c00
int 21h

myArray: db 1,2,2,3,1,3,2,3
size: 	db 8
Mean: 	db 2