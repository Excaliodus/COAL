[org 0x0100]

;sorts original array

start:	mov bx, 0
	mov byte [swap], 0

loop1:	mov al, [myArray+bx]
	cmp al, [myArray+bx+1]
	jbe noswap

	mov cl, [myArray+bx+1]
	mov [myArray+bx+1], al
	mov [myArray+bx], cl
	mov byte [swap], 1

noswap:	add bx, 1
	cmp bx, 6
	jne loop1

cmp byte [swap], 1
je start

mov bx,0
mov cl,7
mov ch,7
mov si,0
jmp outer

;makes an array storing frequency of elements in array in coresponding indexs

freqinc:	add byte [Freq+bx],1
		jmp innerinc

innerinc:	dec cl
		inc si
		cmp cl,0
		je outerinc
		jmp inner

outerinc:	mov si,0
		dec ch
		inc bx
		mov cl,7
		cmp ch,0
		je largest
		jmp outer

outer:	mov al,[myArray+bx]
	inner:	cmp al,[myArray+si]
		je freqinc
		cmp cl,0
		je outerinc
		cmp cl,0
		jne innerinc
	cmp ch,0
	jne outerinc

;find largest number within array

largest:

mov bx,0
mov cl,7
mov al,[Freq+bx]
inc bx
jmp l1

max:	mov al,[Freq+bx]
	mov di, bx
	inc bx
	cmp bl,cl
	je end

l1:	cmp [Freq+bx],al
	jge max
	inc bx
	cmp bl,cl
	jne l1

;as original array is sorted largest frequency number is also largest number
end:

mov al,[myArray+di]
mov byte [MOD],al

mov ax, 0x4c00
int 0x21

MOD: db 2
myArray: db 1,3,2,3,1,3,2
Freq: db 0,0,0,0,0,0,0
swap: db 0