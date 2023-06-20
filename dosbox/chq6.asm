[org 0x0100]
jmp start

swapp: push ax
push bx
push cx
push si
push di

mov ax,0xb800
mov es,ax
mov si,0
mov di,2000
mov cx,0
l1:
mov ax,[es:si]
mov bx,[es:di]
mov [es:si],bx
mov [es:di],ax
add si,2
add di,2
add cx,2
cmp di,4000
jge end
cmp cx,80
je add1
jne l1

add1:
mov cx,0
add si,80
add di,80
jmp l1

end:
pop di
pop si
pop cx
pop bx
pop ax
ret

start:
mov ah,0
int 0x16
call swapp
jmp start
mov ax,0x4c00
int 21h