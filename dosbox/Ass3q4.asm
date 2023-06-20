[org 0x0100]

jmp start

clrscr:	push es
		push ax
		push cx
		push di
		
		mov ax, 0xb800
		mov es, ax
		xor di, di
		mov ax, 0x0720
		mov cx, 2000
		
		cld
		rep stosw
		
		pop di
		pop cx
		pop ax
		pop es
		ret
		
printstr:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di
			
			push ds
			pop es
			mov di, [bp+4]
			mov cx, 0xffff
			xor al, al
			repne scasb
			mov ax, 0xffff
			sub ax, cx
			dec ax
			jz exit
			
			mov cx, ax
			mov ax, 0xb800
			mov es, ax
			mov al, 80
			mul byte [bp+8]
			add ax, [bp+10]
			shl ax, 1
			mov di,ax
			mov si, [bp+4]
			mov ah, [bp+6]
			
			cld

nextchar:	lodsb
			stosw
			loop nextchar
			
exit:	pop di
		pop si
		pop cx
		pop ax
		pop es
		pop bp
		ret 8

trimmer:	push bp
			mov bp, sp
			push es
			push ax
			push cx
			push si
			push di
			
			;Location of printing
			mov bx, [bp+4]
			mov ax, 0xb800
			mov es, ax
			mov al, 80
			mul byte [bp+6]
			add ax, [bp+8]
			shl ax, 1
			
			mov di, ax
			
			
			mov ax, [es:di]
			cmp ax, [bx]
			je check

back:	mov 

skip:	

check:	mov cx, di
		mov si,0

l1:		add si, 2
		add di, 2
		mov dx, [bx+si]
		cmp dx, 0
		je skip
		mov ax, [es:di]
		cmp ax, dx
		je l1
		mov di, cx
		mov ax, [es:di]
		jmp back

start:	call clrscr

		mov ax, 0
		push ax
		mov ax, 0
		push ax
		mov ax, 1
		push ax
		mov ax, str1
		push ax
		call printstr
		mov ax, 0
		push ax
		mov ax, 0
		push ax
		mov ax, str2
		push ax
		

mov ax, 0x4c00
int 0x21

str3: db '                                                                                                                 ', 0
str2: d 'align', 0
str1: db 'The alignment check can also be used by interpreters to flag some pointers as special by misaligning the pointer.', 0