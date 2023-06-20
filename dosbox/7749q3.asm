[org 0x0100] 
jmp start 

revprint:
push bx
push si
push di
push es
mov bx,0xb800
mov es, bx
mov si,0
mov di,3998
l1: mov bx,[es:si]
mov [es:di],bx
add si,2
sub di,2
cmp si,1920
jne l1
pop es
pop di
pop si
pop bx
ret 




start: 
call revprint
 
end: mov ax, 0x4c00 
int 0x21 
