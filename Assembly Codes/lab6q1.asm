[org 0x100]

;clearing screen
mov ax,0xb800
mov es,ax
mov di,0
l1:mov word[es:di],0x0720
add di,2
cmp di,4000
jne l1

jmp start

PrintRectangle:push bp 
mov bp,sp 
push ax 
push bx 
push si
push di 
push dx 
push cx 

mov si,[bp+12] 

;top left point calculation
mov ax,[bp+10] 
push ax 
mov ax,[bp+8] 
push ax 
call calculate
pop ax 
pop ax 
mov di,cx 

;top right point calculation
mov ax,[bp+10] 
push ax 
mov ax,[bp+4] 
push ax 
call calculate
pop ax 
pop ax

;print top
mov ax,0xb800 
mov es,ax   

l2:mov word[es:di],si  
add di,2 
cmp di,cx
jne l2 

mov di,cx  

;bottom right point calculation
mov ax,[bp+6] 
push ax 
mov ax,[bp+4] 
push ax 
call calculate
pop ax 
pop ax

;right side print
mov ax,0xb800 
mov es,ax 
l3:mov word[es:di],si 
add di,160 
cmp di,cx
jne l3  

;bottom left point calculation
mov ax,[bp+6] 
push ax 
mov ax,[bp+8] 
push ax 
call calculate
pop ax 
pop ax

;bottom print
mov ax,0xb800 
mov es,ax 
l4:mov word[es:di],si
sub di,2
cmp di,cx
jne l4

;top right point calculation
mov ax,[bp+10] 
push ax 
mov ax,[bp+8] 
push ax 
call calculate
pop ax 
pop ax

;left side print
mov ax,0xb800
mov es,ax
l5:mov word[es:di],si
sub di,160
cmp di,cx
jne l5

pop cx
pop dx
pop di
pop si
pop bx
pop ax
pop bp
ret 10

calculate:push bp
mov bp,sp
push bx
push ax

mov ax,[bp+6]
mov bl,80
mul bl
add ax,[bp+4]
mov bl,2
mul bx
mov cx,ax

pop ax
pop bx
pop bp
ret 4

delay: push cx
mov cx, 3 ; change the values to increase delay time
delay_loop1: push cx 
mov cx, 0xFFFF 
delay_loop2:
loop delay_loop2
pop cx 
loop delay_loop1 
pop cx
ret

start:
;calling function
mov ax,1143h
push ax
mov ax,4	;top 
push ax
mov ax,20	;left
push ax
mov ax,10	;bottom
push ax
mov ax,30	;right
push ax
call PrintRectangle

;calling function
mov ax,8883h
push ax
mov ax,2	;top
push ax
mov ax,25	;left
push ax
mov ax,10	;bottom
push ax
mov ax,15	;right
push ax
call PrintRectangle

mov ax,0x4c00 
int 21h