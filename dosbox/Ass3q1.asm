[org 0x0100]
jmp start

;Masking used. Mask 00000111 is created for the first octal number. Mask is shl, 3 for next number....
;Other than first octal number rest numbers are shr, 3 to bring in first 3 bits i.e 00000'010' from 00'010'000

splitOctal:	push bp
			mov bp, sp
			mov al, 00000111b
			mov bx, [bp+4]
			mov si, 0

l1:	mov cx, [bp+6]
	and cl, al
	mov dx, 0
	cmp si, 0
	jne l3

back1:	sub bx,si
		add cl, 48
		mov [bx+5], cl
		add bx, si
		inc si
		shl al, 3
		cmp si, 3
		jne l1
		
		mov al, 00000111b

l2:			mov cx, [bp+6]
			and ch, al
			mov dx, 3
			cmp si, 3
			jne l4

back2:		sub bx, si
			add ch, 48
			mov [bx+5], ch
			add bx, si
			inc si
			shl al, 3
			cmp si, 6
			jne l2
			ret 4

l3: 		shr cl, 3
			inc dx
			cmp dx, si
			jne l3
			jmp back1
			
l4: 		shr ch, 3
			inc dx
			cmp dx, si
			jne l4
			jmp back2
			
start:	mov ax, 1111011011010111b
		push ax
		mov ax, oct
		push oct
		call splitOctal

mov ax, 0x4c00
int 0x21

oct: db '000000'