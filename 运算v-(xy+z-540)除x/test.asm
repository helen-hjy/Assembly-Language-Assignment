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
        MUL EBX                  ;x����y
        ADD AX,z             
        ADC DX,0000H        ;��z�������ߵ�λ�ֱ����ӷ�
        SUB AX,021CH        
        SBB DX,0000H         ;��540(ʮ����)  �ߵ�λ������
PUSH AX                       
PUSH DX                     ;�ֱ𽫼������ĸߵ�λ��ջ����ʱ����ջ��
        MOV AX,v
        CWD                      ;��չv��32λ ����DX:AX
   POP CX
   POP BX                       ;��֮ǰ��Ľ����ջ����ע���ջ�ߵ�λ˳��
        SUB AX,BX
        SBB DX,CX             ; v��ȥʣ�µļ����� �ߵ�λ������
        DIV x                     ;������x �õ������DX:AX��
    
        
       MOV AH,4CH
       INT 21H                       ;����DOS
CODE ENDS
     END START