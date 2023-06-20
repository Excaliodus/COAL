[org 0x0100]

jmp start

series:		mov bp,sp
		mov 
		

multiply:	mov bp,sp
		mov al, [bp+2]
		mov dl, [bp+4]
		mov bx, [bp+6]
		mov cl, 8

checkbit:	shr dl, 1
		jnc skip
		add [bx], al

skip:	shl al, 1
	dec cl
	jnz checkbit
	ret 4

start:	push result
	push word [num1]
	push word [num2]
	call multiply

	push arr1
	push arr2
	push resultArr
	push word [size]
	call series

end:	mov dx, 0x4c00
	int 0x21

num1: dw 5
num2: dw 6
result: dw 0
arr1: dw 1,2,3,4,5,6
arr2: dw 2,2,2,2,2,2
resultArr: dw 0,0,0,0,0,0
size: dw 6