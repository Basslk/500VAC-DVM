;CodeVisionAVR C Compiler V1.23.8d Professional
;(C) Copyright 1998-2003 HP InfoTech s.r.l.
;http://www.hpinfotech.ro
;e-mail:office@hpinfotech.ro

;Chip type           : ATmega8L
;Program type        : Application
;Clock frequency     : 8.000000 MHz
;Memory model        : Small
;Optimize for        : Size
;(s)printf features  : int, width
;(s)scanf features   : long, width
;External SRAM size  : 0
;Data Stack size     : 256
;Promote char to int : No
;char is unsigned    : Yes
;8 bit enums         : Yes
;Enhanced core instructions    : On
;Automatic register allocation : On
;Use AVR Studio Terminal I/O   : No

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	CLR  R30
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@2,@0+@1
	.ENDM

	.MACRO __GETWRMN
	LDS  R@2,@0+@1
	LDS  R@3,@0+@1+1
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "DVM.vec"
	.INCLUDE "DVM.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	LDI  R31,0x10
	OUT  WDTCR,R31

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,0x60
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
	SBIW R30,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R24,Z+
	LPM  R25,Z+
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x160)
	LDI  R29,HIGH(0x160)

	RJMP _main

	.ESEG
	.ORG 0
	.DB  0 ; FIRST EEPROM LOCATION NOT USED, SEE ATMEL ERRATA SHEETS

	.DSEG
	.ORG 0x160
;       1 #include <mega8.h>      
;       2 #include <stdlib.h>                            
;       3 #include <string.h>               
;       4 #include <DELAY.h>               
;       5 
;       6 //methods prototype
;       7 
;       8 void PrintToSevenSegment(int number);
;       9 void delay(int n);
;      10 
;      11 //global varibles
;      12                  
;      13 int vOUT=0;
;      14 unsigned int states=0;
;      15 
;      16 //Interrupts ISRs
;      17 interrupt [ADC_INT] void adc_isr(void)
;      18 {

	.CSEG
_adc_isr:
	RCALL __SAVEISR
;      19 	unsigned int adc_data = 0;
;      20 	adc_data=ADCW;           
	RCALL __SAVELOCR2
;	adc_data -> R16,R17
	LDI  R16,0
	LDI  R17,0
	__INWR 16,17,4
;      21 
;      22 	if(adc_data>0)
	CLR  R0
	CP   R0,R16
	CPC  R0,R17
	BRSH _0x34
;      23 	{
;      24         vOUT  = ((adc_data*5.00)/1023)*100;
	__GETW1R 16,17
	MOVW R26,R30
	MOVW R24,R22
	CLR  R24
	CLR  R25
	RCALL __CDF2
	__GETD1N 0x40A00000
	RCALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x447FC000
	RCALL __DIVF21
	__GETD2N 0x42C80000
	RCALL __MULF12
	RCALL __CFD1
	__PUTW1R 4,5
;      25         PrintToSevenSegment(vOUT);
	ST   -Y,R5
	ST   -Y,R4
	RJMP _0x92
;      26         //delay_ms(2);
;      27 	}
;      28 	else
_0x34:
;      29 		PrintToSevenSegment(0);
	CLR  R30
	CLR  R31
	ST   -Y,R31
	ST   -Y,R30
_0x92:
	RCALL _PrintToSevenSegment
;      30 	ADMUX=0x00;
	RCALL SUBOPT_0x0
;      31 	//Start Next Conversion
;      32 	ADCSRA =ADCSRA | 0x40;  
	SBI  0x6,6
;      33 }
	RCALL __LOADLOCR2P
	RCALL __LOADISR
	RETI
;      34 
;      35 
;      36 void main(void)
;      37 {                                           
_main:
;      38 	//make pord D as output.
;      39 	//Port D is used for 7 Segment Display
;      40 	DDRD=0xFF;
	LDI  R30,LOW(255)
	OUT  0x11,R30
;      41 	//make pord b as output.
;      42 	//port B is used for relays control
;      43 	DDRB =0xFF;  
	OUT  0x17,R30
;      44 	//ADC Input is channel 0               
;      45 	ADMUX = 0x00;           
	RCALL SUBOPT_0x0
;      46  	ADCSRA =0xCE;
	LDI  R30,LOW(206)
	OUT  0x6,R30
;      47   	//Enbale interrupts
;      48         #asm("sei")
	sei
;      49 	while(1)
_0x37:
;      50 	{
;      51 		if (vOUT>=248 & states==0)
	__GETW2R 4,5
	LDI  R30,LOW(248)
	LDI  R31,HIGH(248)
	RCALL __GEW12
	PUSH R30
	__GETW2R 6,7
	CLR  R30
	CLR  R31
	RCALL __EQW12
	POP  R26
	AND  R30,R26
	BREQ _0x3A
;      52 		{
;      53 		       	//PORTB.6=0x0;
;      54                 }
;      55        	        else
	RJMP _0x3B
_0x3A:
;      56               	{
;      57 		  	if(vOUT<=207)
	LDI  R30,LOW(207)
	LDI  R31,HIGH(207)
	CP   R30,R4
	CPC  R31,R5
	BRLT _0x3C
;      58 		  	{
;      59 	       			states+=1;
	__GETW1R 6,7
	ADIW R30,1
	RCALL SUBOPT_0x1
;      60 	       			switch(states){
;      61 	       			case 1:
	BRNE _0x40
;      62 	       			{                        
;      63 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;      64 	       			        PORTB=0b00000001;
	LDI  R30,LOW(1)
	RJMP _0x93
;      65 	       				break;
;      66 	       			}
;      67 	       			case 2:
_0x40:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x41
;      68 	       			{
;      69 	       				delay_ms(100);     
	RCALL SUBOPT_0x2
;      70 	       			        PORTB=0b00000010;
	LDI  R30,LOW(2)
	RJMP _0x93
;      71 	       				break;
;      72 	       			}
;      73 	       			case 3:
_0x41:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x42
;      74 	       			{     
;      75 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;      76 	       			        PORTB=0b00000011;
	LDI  R30,LOW(3)
	RJMP _0x93
;      77 	       				break;
;      78 	       			}
;      79 	       			case 4:
_0x42:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x43
;      80 	       			{     
;      81 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;      82 	       			        PORTB=0b00000100;
	LDI  R30,LOW(4)
	RJMP _0x93
;      83 	       				break;
;      84 	       			}
;      85 	       			case 5:
_0x43:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x44
;      86 	       			{     
;      87 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;      88 	       			        PORTB=0b00000101;
	LDI  R30,LOW(5)
	RJMP _0x93
;      89 	       				break;
;      90 	       			}
;      91 	       			case 6:
_0x44:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x45
;      92 	       			{
;      93 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;      94 	       				PORTB=0b00000110;
	LDI  R30,LOW(6)
	RJMP _0x93
;      95 	       				break;
;      96 	       			}
;      97 	       			case 7:
_0x45:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x47
;      98 	       			{
;      99 	       				delay_ms(100);
;     100 		       			PORTB=0b00000111;
;     101 		       			break;
;     102 	       			}	
;     103 	       			default:
_0x47:
;     104 	       			{
;     105 	       				delay_ms(100);
_0x94:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL SUBOPT_0x3
;     106 	       				PORTB = 0b00000111;
	LDI  R30,LOW(7)
_0x93:
	OUT  0x18,R30
;     107 	       			}
;     108 	       			}
;     109 				
;     110 			}
;     111   			if(vOUT>=233)
_0x3C:
	LDI  R30,LOW(233)
	LDI  R31,HIGH(233)
	CP   R4,R30
	CPC  R5,R31
	BRLT _0x48
;     112 		  	{
;     113   			  states-=1;  	
	__GETW1R 6,7
	SBIW R30,1
	RCALL SUBOPT_0x1
;     114   			  switch(states){
;     115 	       			case 1:
	BRNE _0x4C
;     116 	       			{     
;     117 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;     118 	       			        PORTB=0b00000001;
	LDI  R30,LOW(1)
	RJMP _0x95
;     119 	       				break;
;     120 	       			}
;     121 	       			case 2:
_0x4C:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x4D
;     122 	       			{     
;     123 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;     124 	       			        PORTB=0b00000010;
	LDI  R30,LOW(2)
	RJMP _0x95
;     125 	       				break;
;     126 	       			}
;     127 	       			case 3:
_0x4D:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x4E
;     128 	       			{     
;     129 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;     130 	       			        PORTB=0b00000011;
	LDI  R30,LOW(3)
	RJMP _0x95
;     131 	       				break;
;     132 	       			}
;     133 	       			case 4:
_0x4E:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x4F
;     134 	       			{     
;     135 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;     136 	       			        PORTB=0b00000100;
	LDI  R30,LOW(4)
	RJMP _0x95
;     137 	       				break;
;     138 	       			}
;     139 	       			case 5:
_0x4F:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x50
;     140 	       			{     
;     141 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;     142 	       			        PORTB=0b00000101;
	LDI  R30,LOW(5)
	RJMP _0x95
;     143 	       				break;
;     144 	       			}
;     145 	       			case 6:
_0x50:
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x51
;     146 	       			{
;     147 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;     148 	       				PORTB=0b00000110;
	LDI  R30,LOW(6)
	RJMP _0x95
;     149 	       				break;
;     150 	       			}
;     151 	       			case 7:
_0x51:
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x53
;     152 	       			{
;     153 	       				delay_ms(100);
	RCALL SUBOPT_0x2
;     154 		       			PORTB=0b00000111;
	LDI  R30,LOW(7)
	RJMP _0x95
;     155 		       			break;
;     156 	       			}	
;     157 	       			default:
_0x53:
;     158 	       			{
;     159 	       				PORTB = 0b00000000;
	CLR  R30
_0x95:
	OUT  0x18,R30
;     160 	       			}
;     161 	       			}
;     162 	  		}
;     163 	  			
;     164   		       	//PORTC.6=0x1;
;     165   		     }
_0x48:
_0x3B:
;     166 	};
	RJMP _0x37
;     167 }
_0x54:
	RJMP _0x54
;     168 
;     169 //Methods definations
;     170 int q=0;
;     171 void PrintToSevenSegment(int number)
;     172 {       for(q=0;q<5;q++){
_PrintToSevenSegment:
	CLR  R8
	CLR  R9
_0x57:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R8,R30
	CPC  R9,R31
	BRLT PC+2
	RJMP _0x58
;     173 	//Extract the digits from the int number
;     174 	int hund, rem, ten, one;                   
;     175         hund = number/100;
	SBIW R28,8
;	number -> Y+8
;	hund -> Y+6
;	rem -> Y+4
;	ten -> Y+2
;	one -> Y+0
	RCALL SUBOPT_0x4
	RCALL __DIVW21
	STD  Y+6,R30
	STD  Y+6+1,R31
;     176         rem=number%100;
	RCALL SUBOPT_0x4
	RCALL __MODW21
	STD  Y+4,R30
	STD  Y+4+1,R31
;     177         ten = rem/10;
	RCALL SUBOPT_0x5
	RCALL __DIVW21
	STD  Y+2,R30
	STD  Y+2+1,R31
;     178         one = rem%10;                                                      
	RCALL SUBOPT_0x5
	RCALL __MODW21
	ST   Y,R30
	STD  Y+1,R31
;     179         
;     180         //Display the hundreds digit on Port D
;     181 	if(hund ==1)
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x1)
	LDI  R30,HIGH(0x1)
	CPC  R27,R30
	BRNE _0x59
;     182 	       	PORTD = 0x11;
	LDI  R30,LOW(17)
	OUT  0x12,R30
;     183 	else if (hund == 2 )
	RJMP _0x5A
_0x59:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x2)
	LDI  R30,HIGH(0x2)
	CPC  R27,R30
	BRNE _0x5B
;     184 		PORTD = 0x12;
	LDI  R30,LOW(18)
	OUT  0x12,R30
;     185 	else if (hund == 3 )
	RJMP _0x5C
_0x5B:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x3)
	LDI  R30,HIGH(0x3)
	CPC  R27,R30
	BRNE _0x5D
;     186 		PORTD = 0x13;
	LDI  R30,LOW(19)
	OUT  0x12,R30
;     187 	else if (hund == 4 )
	RJMP _0x5E
_0x5D:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x4)
	LDI  R30,HIGH(0x4)
	CPC  R27,R30
	BRNE _0x5F
;     188 		PORTD = 0x14;
	LDI  R30,LOW(20)
	OUT  0x12,R30
;     189 	else if (hund == 5 )
	RJMP _0x60
_0x5F:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x5)
	LDI  R30,HIGH(0x5)
	CPC  R27,R30
	BRNE _0x61
;     190 		PORTD = 0x15;
	LDI  R30,LOW(21)
	OUT  0x12,R30
;     191 	else if (hund == 6 )
	RJMP _0x62
_0x61:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x6)
	LDI  R30,HIGH(0x6)
	CPC  R27,R30
	BRNE _0x63
;     192 		PORTD = 0x16;
	LDI  R30,LOW(22)
	OUT  0x12,R30
;     193 	else if (hund == 7 )
	RJMP _0x64
_0x63:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x7)
	LDI  R30,HIGH(0x7)
	CPC  R27,R30
	BRNE _0x65
;     194 		PORTD = 0x17;
	LDI  R30,LOW(23)
	OUT  0x12,R30
;     195 	else if (hund == 8 )
	RJMP _0x66
_0x65:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x8)
	LDI  R30,HIGH(0x8)
	CPC  R27,R30
	BRNE _0x67
;     196 		PORTD = 0x18;
	LDI  R30,LOW(24)
	OUT  0x12,R30
;     197 	else if (hund == 9 )
	RJMP _0x68
_0x67:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CPI  R26,LOW(0x9)
	LDI  R30,HIGH(0x9)
	CPC  R27,R30
	BRNE _0x69
;     198 		PORTD = 0x19;
	LDI  R30,LOW(25)
	OUT  0x12,R30
;     199 	else if (hund == 0 )
	RJMP _0x6A
_0x69:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SBIW R30,0
	BRNE _0x6B
;     200 		PORTD = 0x10;
	LDI  R30,LOW(16)
	OUT  0x12,R30
;     201 	delay_ms(1);
_0x6B:
_0x6A:
_0x68:
_0x66:
_0x64:
_0x62:
_0x60:
_0x5E:
_0x5C:
_0x5A:
	RCALL SUBOPT_0x6
;     202         
;     203         //Display the tens digit on Port D  	
;     204         if(ten == 1 )
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x1)
	LDI  R30,HIGH(0x1)
	CPC  R27,R30
	BRNE _0x6C
;     205 		PORTD = 0x21;
	LDI  R30,LOW(33)
	OUT  0x12,R30
;     206 	else if (ten == 2 )
	RJMP _0x6D
_0x6C:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x2)
	LDI  R30,HIGH(0x2)
	CPC  R27,R30
	BRNE _0x6E
;     207 		PORTD = 0x22;
	LDI  R30,LOW(34)
	OUT  0x12,R30
;     208 	else if (ten == 3 )
	RJMP _0x6F
_0x6E:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x3)
	LDI  R30,HIGH(0x3)
	CPC  R27,R30
	BRNE _0x70
;     209 		PORTD = 0x23;
	LDI  R30,LOW(35)
	OUT  0x12,R30
;     210 	else if (ten == 4 )
	RJMP _0x71
_0x70:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x4)
	LDI  R30,HIGH(0x4)
	CPC  R27,R30
	BRNE _0x72
;     211 	 	PORTD = 0x24;
	LDI  R30,LOW(36)
	OUT  0x12,R30
;     212 	else if (ten == 5 )
	RJMP _0x73
_0x72:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x5)
	LDI  R30,HIGH(0x5)
	CPC  R27,R30
	BRNE _0x74
;     213 		PORTD = 0x25;
	LDI  R30,LOW(37)
	OUT  0x12,R30
;     214 	else if (ten == 6 )
	RJMP _0x75
_0x74:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x6)
	LDI  R30,HIGH(0x6)
	CPC  R27,R30
	BRNE _0x76
;     215 		PORTD = 0x26;
	LDI  R30,LOW(38)
	OUT  0x12,R30
;     216 	else if (ten == 7 )
	RJMP _0x77
_0x76:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x7)
	LDI  R30,HIGH(0x7)
	CPC  R27,R30
	BRNE _0x78
;     217 		PORTD = 0x27;
	LDI  R30,LOW(39)
	OUT  0x12,R30
;     218 	else if (ten == 8 )
	RJMP _0x79
_0x78:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x8)
	LDI  R30,HIGH(0x8)
	CPC  R27,R30
	BRNE _0x7A
;     219 		PORTD = 0x28;
	LDI  R30,LOW(40)
	OUT  0x12,R30
;     220 	else if (ten == 9 )
	RJMP _0x7B
_0x7A:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CPI  R26,LOW(0x9)
	LDI  R30,HIGH(0x9)
	CPC  R27,R30
	BRNE _0x7C
;     221 		PORTD = 0x29;
	LDI  R30,LOW(41)
	OUT  0x12,R30
;     222 	else if (ten == 0 )
	RJMP _0x7D
_0x7C:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BRNE _0x7E
;     223 		PORTD = 0x20;
	LDI  R30,LOW(32)
	OUT  0x12,R30
;     224   	delay_ms(1);
_0x7E:
_0x7D:
_0x7B:
_0x79:
_0x77:
_0x75:
_0x73:
_0x71:
_0x6F:
_0x6D:
	RCALL SUBOPT_0x6
;     225                 	
;     226         //Display the Ones digit on Port D  	
;     227    	if(one == 1 )
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x1)
	LDI  R30,HIGH(0x1)
	CPC  R27,R30
	BRNE _0x7F
;     228 		PORTD = 0x41;
	LDI  R30,LOW(65)
	OUT  0x12,R30
;     229 	else if (one == 2 )
	RJMP _0x80
_0x7F:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x2)
	LDI  R30,HIGH(0x2)
	CPC  R27,R30
	BRNE _0x81
;     230 		PORTD = 0x42;
	LDI  R30,LOW(66)
	OUT  0x12,R30
;     231 	else if (one == 3 )
	RJMP _0x82
_0x81:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x3)
	LDI  R30,HIGH(0x3)
	CPC  R27,R30
	BRNE _0x83
;     232 		PORTD = 0x43;
	LDI  R30,LOW(67)
	OUT  0x12,R30
;     233 	else if (one == 4 )
	RJMP _0x84
_0x83:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x4)
	LDI  R30,HIGH(0x4)
	CPC  R27,R30
	BRNE _0x85
;     234 		PORTD = 0x44;
	LDI  R30,LOW(68)
	OUT  0x12,R30
;     235 	else if (one == 5 )
	RJMP _0x86
_0x85:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x5)
	LDI  R30,HIGH(0x5)
	CPC  R27,R30
	BRNE _0x87
;     236 		PORTD = 0x45;
	LDI  R30,LOW(69)
	OUT  0x12,R30
;     237 	else if (one == 6 )
	RJMP _0x88
_0x87:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x6)
	LDI  R30,HIGH(0x6)
	CPC  R27,R30
	BRNE _0x89
;     238 		PORTD = 0x46;
	LDI  R30,LOW(70)
	OUT  0x12,R30
;     239 	else if (one == 7 )
	RJMP _0x8A
_0x89:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x7)
	LDI  R30,HIGH(0x7)
	CPC  R27,R30
	BRNE _0x8B
;     240 		PORTD = 0x47;
	LDI  R30,LOW(71)
	OUT  0x12,R30
;     241 	else if (one == 8 )
	RJMP _0x8C
_0x8B:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x8)
	LDI  R30,HIGH(0x8)
	CPC  R27,R30
	BRNE _0x8D
;     242 		PORTD = 0x48;
	LDI  R30,LOW(72)
	OUT  0x12,R30
;     243 	else if (one == 9 )
	RJMP _0x8E
_0x8D:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x9)
	LDI  R30,HIGH(0x9)
	CPC  R27,R30
	BRNE _0x8F
;     244 		PORTD = 0x49;
	LDI  R30,LOW(73)
	OUT  0x12,R30
;     245 	else if (one == 0 )
	RJMP _0x90
_0x8F:
	LD   R30,Y
	LDD  R31,Y+1
	SBIW R30,0
	BRNE _0x91
;     246 		PORTD = 0x40;
	LDI  R30,LOW(64)
	OUT  0x12,R30
;     247 	delay_ms(1);         
_0x91:
_0x90:
_0x8E:
_0x8C:
_0x8A:
_0x88:
_0x86:
_0x84:
_0x82:
_0x80:
	RCALL SUBOPT_0x6
;     248 	}
	ADIW R28,8
	__GETW1R 8,9
	ADIW R30,1
	__PUTW1R 8,9
	RJMP _0x57
_0x58:
;     249 }                          
	ADIW R28,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x0:
	CLR  R30
	OUT  0x7,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1:
	__PUTW1R 6,7
	__GETW1R 6,7
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES
SUBOPT_0x2:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x3:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x6:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP SUBOPT_0x3

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__SAVEISR:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R0,SREG
	ST   -Y,R0
	RET

__LOADISR:
	LD   R0,Y+
	OUT  SREG,R0
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RET

__ANEGW1:
	COM  R30
	COM  R31
	ADIW R30,1
	RET

__ANEGD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD2:
	CLR  R24
	CLR  R25
	SBRS R27,7
	RET
	SER  R24
	SER  R25
	RET

__EQW12:
	CP   R30,R26
	CPC  R31,R27
	LDI  R30,1
	BREQ __EQW12T
	CLR  R30
__EQW12T:
	RET

__GEW12:
	CP   R26,R30
	CPC  R27,R31
	LDI  R30,1
	BRGE __GEW12T
	CLR  R30
__GEW12T:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__CDF2U:
	SET
	RJMP __CDF2U0
__CDF2:
	CLT
__CDF2U0:
	RCALL __SWAPD12
	RCALL __CDF1U0

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,24
__MULF120:
	LSL  R19
	ROL  R20
	ROL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	BRCC __MULF121
	ADD  R19,R26
	ADC  R20,R27
	ADC  R21,R24
	ADC  R30,R1
	ADC  R31,R1
	ADC  R22,R1
__MULF121:
	DEC  R25
	BRNE __MULF120
	POP  R20
	POP  R19
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __REPACK
	POP  R21
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __MAXRES
	RJMP __MINRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	LSR  R22
	ROR  R31
	ROR  R30
	LSR  R24
	ROR  R27
	ROR  R26
	PUSH R20
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R25,24
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R1
	ROL  R20
	ROL  R21
	ROL  R26
	ROL  R27
	ROL  R24
	DEC  R25
	BRNE __DIVF212
	MOV  R30,R1
	MOV  R31,R20
	MOV  R22,R21
	LSR  R26
	ADC  R30,R25
	ADC  R31,R25
	ADC  R22,R25
	POP  R20
	TST  R22
	BRMI __DIVF215
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __REPACK
	POP  R21
	RET

__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR2P:
	LD   R16,Y+
	LD   R17,Y+
	RET

