[org 0x0100]

;One pointer starts reading from index 0 on screen. Second starts printing bacwards from index 4000

jmp start

flip:	mov ax, 0xb800
		mov es, ax
		mov si, 0
		mov di, 3996

l1:		mov ax, [es:si]
		mov [es:di], ax
		inc si
		dec di
		cmp si, 1918
		jne l1
		ret
		
start:	call flip

mov ax, 0x4c00
int 0x21