;��LEA����ֱ������ַ���

DATA  SEGMENT               ;DATA�ζ��忪ʼ
             STRING1 DB '  * * *  ',0DH,0AH,'$'
             STRING2 DB '* * * * *',0DH,0AH,'$'
  
DATA  ENDS                         ;DATA�ζ������
CODE  SEGMENT                ;CODE�ζ��忪ʼ
            ASSUME CS:CODE
            ASSUME DS:DATA ;�����ʹ涨
START: 
        MOV AX,DATA 
        MOV DS,AX

        LEA DX,STRING1
        MOV AH,09H
        INT 21H                 ;�����һ���ַ���

        LEA DX,STRING2
        MOV AH,09H
        INT 21H                 ;����ڶ����ַ���

        LEA DX,STRING1
        MOV AH,9
        INT 21H                 ;���������һ����ͬ

MOV AH,4CH                  
INT 21H                    ;����DOS
CODE  ENDS                         ;CODE�ζ������
             END START              ;Դ�������