[org 0x0100]

mov al,[Number]
mov bl,[Number+1]
mov cx,0

loop1:	shl al,1
	rcr ah,1
	inc cl
	cmp cx,8
	jne loop1
	xor ah,bl
	jz pali
	mov dx,0
	jmp skip

pali:	mov dx,1

skip:	mov ax,0x4c00
	int 21h

Number dw 0xA425