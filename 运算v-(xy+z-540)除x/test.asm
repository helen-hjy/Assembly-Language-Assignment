DATA SEGMENT
    x dd  100d
    y dd 10d
    z dd  40d
    v dd 1000d
        
DATA ENDS
 ASSUME CS:CODE, DS:DATA
CODE SEGMENT
START: 
        MOV AX,DATA
        MOV DS,AX
        MOV EAX,x
        MOV EBX,y
        MUL EBX                  ;x乘以y
        ADD AX,z             
        ADC DX,0000H        ;加z操作，高低位分别做加法
        SUB AX,021CH        
        SBB DX,0000H         ;减540(十进制)  高低位做减法
PUSH AX                       
PUSH DX                     ;分别将计算结果的高低位入栈，暂时放入栈顶
        MOV AX,v
        CWD                      ;扩展v至32位 存在DX:AX
   POP CX
   POP BX                       ;将之前算的结果出栈，需注意出栈高低位顺序
        SUB AX,BX
        SBB DX,CX             ; v减去剩下的计算数 高低位做减法
        DIV x                     ;最后除以x 得到结果在DX:AX中
    
        
       MOV AH,4CH
       INT 21H                       ;返回DOS
CODE ENDS
     END START