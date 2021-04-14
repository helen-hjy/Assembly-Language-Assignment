;用LEA命令直接输出字符串

DATA  SEGMENT               ;DATA段定义开始
             STRING1 DB '  * * *  ',0DH,0AH,'$'
             STRING2 DB '* * * * *',0DH,0AH,'$'
  
DATA  ENDS                         ;DATA段定义结束
CODE  SEGMENT                ;CODE段定义开始
            ASSUME CS:CODE
            ASSUME DS:DATA ;段性质规定
START: 
        MOV AX,DATA 
        MOV DS,AX

        LEA DX,STRING1
        MOV AH,09H
        INT 21H                 ;输出第一行字符串

        LEA DX,STRING2
        MOV AH,09H
        INT 21H                 ;输出第二行字符串

        LEA DX,STRING1
        MOV AH,9
        INT 21H                 ;第三行与第一行相同

MOV AH,4CH                  
INT 21H                    ;返回DOS
CODE  ENDS                         ;CODE段定义结束
             END START              ;源程序结束