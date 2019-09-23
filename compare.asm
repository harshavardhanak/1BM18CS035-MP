.model small
    display macro msg
    lea dx,msg
    mov ah,09h
   int 21h
   endm

.data
    msg1 db 0dh,0ah,"enter first string$" 
    msg2 db 0dh,0ah,"enter second string$"
    msg3 db 0dh,0ah,"strings are equal$"
    msg4 db 0dh,0ah,"strings are not equal$"
    str1 db 10h dup(0)
    str2 db 10h dup(0)
    len dw 0

.code

    mov ax,@data
    mov ds,ax
    display msg1
    mov si,00h

loop1:mov ah,01h
      int 21h
      cmp al,0dh
      jz mseg
      mov str1[si],al
      inc si
      inc len
      jmp loop1

mseg:display msg2
      mov di,00h
      mov cx,len
      jmp loop2

loop2:mov ah,01h
      int 21h
      cmp al,0dh
      jz comp 
      mov str2[di],al
      inc di
      dec cx
      cmp cx,00h
      jnz loop2
      mov cx,len
      mov si,00h
      mov di,00h
comp: mov al,str1[si]
      mov bl,str2[di]
      cmp al,bl
      jnz noteq
      inc si
      inc di
      loop comp
      display msg3
      jmp final
noteq:display msg4
    
      
final: mov ah,4ch
      int 21h
      end
