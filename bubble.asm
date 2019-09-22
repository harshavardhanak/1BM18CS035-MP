.model small
.data
n db 5
a dw 17,16,18,14,20
.CODE
         MOV AX,@DATA
         MOV DS,AX
         MOV CL,N
         DEC CL
OUTLOOP: MOV CH,CL
         MOV SI,0
INLOOP:  MOV AX,A[SI]
         ADD SI,002H
         CMP AX,A[SI]
         JB NOXG
         XCHG AX,A[SI]
         MOV A[SI-1],AX
NOXG: DEC CH    
      JNZ INLOOP
      DEC CL
      JNZ OUTLOOP
      MOV BH,4CH
      INT 21H
      END
