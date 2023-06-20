[org 0x0100]

;Numbers are pushed. Last number is amount of numbers pushed. Algo to find min applied for that many number by add 2 to bp

jmp start

minOfMany:	push bp
			mov bp,sp
			push bx
			push cx
			mov cx, 0
			mov bx, [bp+4]
			add bp, 6
			mov ax, [bp]
			add bp, 2
			inc cx
			jmp l1

smallest:	mov ax, [bp]
			add bp, 2
			inc cx
			cmp cx, bx
			je end

l1:		cmp ax, [bp]
		ja smallest
		add bp, 2
		inc cx
		cmp cx, bx
		jne l1
			
end:	pop cx
		pop bx
		pop bp
		ret 10
		
start:	push 5
		push 10
		push 6
		push 8
		push 4
		call minOfMany

mov ax, 0x4c00
int 0x21