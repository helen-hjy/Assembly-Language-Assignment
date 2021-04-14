;---------------------------------------------
DATA SEGMENT
   MARKS db 93,92,93,98,99,20,96,45,49,98,99,100,38,79,82,91,66,92,68
   NUM equ $-MARKS
   STRING1 db 'The number of students with marks greater than 90:','$'
   STRING2 db 'The number of students who failed:','$'
   COUNT DW ?
   GREAT DW ?
   FAIL DW ?
DATA ENDS       
;----------------------------------------------   
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
;----�ӳ���----
;���ó���ջ���10�������� 
OUTPUT PROC NEAR
PUSH AX
PUSH BX
PUSH CX
PUSH DX
;�ȴ�֮ǰ����������
MOV BX,10
MOV COUNT,0      ;����Ϊ0

 ;����10������ÿ�ζ������ջ���Ҽ�������1�Ա�����ջ��ʾ
CALCULATE:
INC COUNT
CWD
DIV BX
PUSH DX
CMP AX,0       ;�Ƚ������Ƿ�Ϊ0
LOOPNZ CALCULATE   
 ;Ϊ0����������ջ��ʾ�������������

MOV CX,COUNT      ;ѭ������Ϊ�������
SHOW:
POP DX     ;��ջ��ʾDL
ADD DL,30H
MOV AH,2
INT 21H
LOOP SHOW        

POP DX
POP CX
POP BX
POP AX
;���ʼԤ������ݳ�ջ
    RET
OUTPUT ENDP
;------����ʼ------
START:
   MOV AX,DATA
   MOV DS,AX           
   LEA SI,MARKS
   MOV CX,NUM
;ȡ�׵�ַ����ѭ����������cx��

;-----����-----
;�������90����
NEXT1:                     
    MOV AL,[SI]
    CMP AL,60
    JB bad
    JMP continue
bad:
    INC FAIL
continue:
    INC SI
    LOOP NEXT1

;����С��60����
     
;ע��CX����һ��ѭ���Ѿ���Ϊ0�������ش�һ��cx
    MOV CX,NUM 
    LEA SI,MARKS
NEXT2:
    MOV AL,[SI]
    CMP AL,90
    JA good
    JMP go
good: 
    INC GREAT 
go:
    INC SI
    LOOP NEXT2

;----��ʾ���----
LEA DX,STRING1
MOV AH,9
INT 21H
;��ʾ��ʾ���

MOV AX,GREAT
CALL OUTPUT         ;ʹ���ӳ�����ʾ����

   MOV DL,0AH
   MOV AH,2
   INT 21H 
;����س���

LEA DX,STRING2
MOV AH,9
INT 21H
;��ʾ��ʾ���
MOV AX,FAIL
CALL OUTPUT      ;��ʾ����

 ;---����DOS---
MOV AH,4CH
INT 21H                    
CODE ENDS
       END START
