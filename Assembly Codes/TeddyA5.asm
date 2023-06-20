[org 0x0100]
mov ax,0877
;mov [f],ax
;shl dword [f],16

mov cx,ax
not cx
mov bx,cx
add [f],bx

mov [multiplicand],ax
mov [multiplier],bx

mov cl,16
mov dx, [multiplier] 

checkbit: 

shr dx, 1
jnc skip 

mov ax, [multiplicand] 
add [f], ax 
mov ax, [multiplicand+2] 
adc [f+2], ax  

skip:

shl word [multiplicand], 1 
rcl word [multiplicand+2], 1  
dec cl  
jnz checkbit 

mov ax,0x4c00
int 0x21

f: dd 0
multiplicand: dd 0 
multiplier: dw 0

;361402A=>Multiply result
;6CF3CBC=>Final result

BC3CCF0600006D03