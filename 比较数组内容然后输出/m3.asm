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
;----子程序----
;利用出入栈输出10进制数字 
OUTPUT PROC NEAR
PUSH AX
PUSH BX
PUSH CX
PUSH DX
;先存之前运算后的数据
MOV BX,10
MOV COUNT,0      ;计数为0

 ;除以10后将余数每次都放入堆栈并且计数器加1以便后面出栈显示
CALCULATE:
INC COUNT
CWD
DIV BX
PUSH DX
CMP AX,0       ;比较商数是否为0
LOOPNZ CALCULATE   
 ;为0则结束计算出栈显示，否则继续计算

MOV CX,COUNT      ;循环次数为计算次数
SHOW:
POP DX     ;出栈显示DL
ADD DL,30H
MOV AH,2
INT 21H
LOOP SHOW        

POP DX
POP CX
POP BX
POP AX
;将最开始预存的数据出栈
    RET
OUTPUT ENDP
;------程序开始------
START:
   MOV AX,DATA
   MOV DS,AX           
   LEA SI,MARKS
   MOV CX,NUM
;取首地址并将循环次数放在cx中

;-----计算-----
;计算大于90个数
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

;计算小于60个数
     
;注意CX在上一个循环已经减为0所以需重传一次cx
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

;----显示结果----
LEA DX,STRING1
MOV AH,9
INT 21H
;显示提示语句

MOV AX,GREAT
CALL OUTPUT         ;使用子程序显示数据

   MOV DL,0AH
   MOV AH,2
   INT 21H 
;输出回车符

LEA DX,STRING2
MOV AH,9
INT 21H
;显示提示语句
MOV AX,FAIL
CALL OUTPUT      ;显示数据

 ;---返回DOS---
MOV AH,4CH
INT 21H                    
CODE ENDS
       END START
