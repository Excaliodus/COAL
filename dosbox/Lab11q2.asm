[org 0x100]
jmp start
kbisr:		push ax 
			push es
			push bx
			push cx
			push dx
			push bp
			mov ax,0xb800
			mov es,ax
			xor ax,ax
			
			in al,0x60
			shl al,1
			jc release
			mov ah,0x13
			mov al,1
			mov bh,0
			mov bl,7
			mov dx,0x0A03
			mov cx,14
			push cs
			pop es
			mov bp,str1
			int 0x10
			jmp skip
			
release:	mov ah,0x13
			mov al,1
			mov bh,0
			mov bl,7
			mov dx,0x0A03
			mov cx,17
			push cs
			pop es
			mov bp,str2
			int 0x10

skip:		xor ax,ax
			mov al,0x20
			out 0x20,al
			pop bp
			pop dx
			pop cx
			pop bx
			pop es
			pop ax
			iret

mov ax,0x4c00
int 21h

str1:db 'a key is press'
str2:db 'a key is released'

start:		xor ax,ax
			mov es,ax
			cli
			mov word[es:9*4], kbisr
			mov [es:9*4+2],cs
			sti
			
l1:			jmp l1