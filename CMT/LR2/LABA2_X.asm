;******************************************************************************
;   This file is a basic template for creating relocatable assembly code for  *
;   a PIC18F2520. Copy this file into your project directory and modify or    *
;   add to it as needed.                                                      *
;                                                                             *
;   The PIC18FXXXX architecture allows two interrupt configurations. This     *
;   template code is written for priority interrupt levels and the IPEN bit   *
;   in the RCON register must be set to enable priority levels. If IPEN is    *
;   left in its default zero state, only the interrupt vector at 0x008 will   *
;   be used and the WREG_TEMP, BSR_TEMP and STATUS_TEMP variables will not    *
;   be needed.                                                                *
;                                                                             *
;   Refer to the MPASM User's Guide for additional information on the         *
;   features of the assembler and linker.                                     *
;                                                                             *
;   Refer to the PIC18Fxx20 Data Sheet for additional                         *
;   information on the architecture and instruction set.                      *
;                                                                             *
;******************************************************************************
;                                                                             *
;    Filename:      12F2520TMPO.ASM                                                          *
;    Date:          09.09.2024                                                          *
;    File Version:                                                            *
;                                                                             *
;    Author:    TImokhin Semyon                                                              *
;    Company:   MPEI                                                              *
;                                                                             * 
;******************************************************************************
;                                                                             *
;    Files required: P18F2520.INC                                             *
;                                                                             *
;******************************************************************************

	LIST P=18F2520, F=INHX32 ;directive to define processor and file format
	#include <P18F2520.INC>	 ;processor specific variable definitions

;******************************************************************************
;Configuration bits
;Microchip has changed the format for defining the configuration bits, please 
;see the .inc file for futher details on notation.  Below are a few examples.



;   Oscillator Selection:
    CONFIG	OSC = LP             ;LP

;******************************************************************************
;Variable definitions
; These variables are only needed if low priority interrupts are used. 
; More variables may be needed to store other special function registers used
; in the interrupt routines.

		UDATA

WREG_TEMP	RES	1	;variable in RAM for context saving 
STATUS_TEMP	RES	1	;variable in RAM for context saving
BSR_TEMP	RES	1	;variable in RAM for context saving

		UDATA_ACS

point_64 RES 1
point_128 RES 1
point_192 RES 1
point_256 RES 1
result RES 2

;******************************************************************************
;EEPROM data
; Data to be programmed into the Data EEPROM is defined here

DATA_EEPROM	CODE	0xf00000

		DE	"Test Data",0,1,2,3,4,5

;******************************************************************************
;Reset vector
; This code will start executing when a reset occurs.

RESET_VECTOR	CODE	0x0000

		goto	Main		;go to start of main code

;******************************************************************************
;High priority interrupt vector
; This code will start executing when a high priority interrupt occurs or
; when any interrupt occurs if interrupt priorities are not enabled.

HI_INT_VECTOR	CODE	0x0008

		bra	HighInt		;go to high priority interrupt routine

;******************************************************************************
;Low priority interrupt vector
; This code will start executing when a low priority interrupt occurs.
; This code can be removed if low priority interrupts are not used.

LOW_INT_VECTOR	CODE	0x0018

		bra	LowInt		;go to low priority interrupt routine

;******************************************************************************
;High priority interrupt routine
; The high priority interrupt code is placed here.

		CODE

HighInt:

;	*** high priority interrupt code goes here ***


		retfie	FAST

;******************************************************************************
;Low priority interrupt routine
; The low priority interrupt code is placed here.
; This code can be removed if low priority interrupts are not used.

LowInt:
		movff	STATUS,STATUS_TEMP	;save STATUS register
		movff	WREG,WREG_TEMP		;save working register
		movff	BSR,BSR_TEMP		;save BSR register

;	*** low priority interrupt code goes here ***


		movff	BSR_TEMP,BSR		;restore BSR register
		movff	WREG_TEMP,WREG		;restore working register
		movff	STATUS_TEMP,STATUS	;restore STATUS register
		retfie

;******************************************************************************
;Start of main program
; The main program code is placed here.

Main:
; Пример программмы построения пилообразного сигнала 

; Запись константы максимального значения графика в переменную REG_MAX
MOVLW 05h
MOVWF REG_MAX

; FSR0_16 -> RSR0H_8, FSR0L_8
;Для выполнения косвенной адресации необходимо обратиться к физически не реализованному регистру INDF. 
;Обращение к регистру INDF фактически вызовет действие с регистром, адрес которого указан в FSR. 
;Косвенное чтение регистра INDF (FSR=0) даст результат 00h.
; Запись адреса из двух частей
MOVLW 00h
MOVWF FSR0L
MOVLW 02h
MOVWF FSR0H

MOVLW 00h; Запись начального значения функции в аккумулятор

CPFSLT WREG,REG_MAX ;Условие (WREG < REG_mAX)? BRA M1:BRA M2
BRA M2
BRA M1

M1:MOVWF INDF0 ; Запись первого значения функции по адресу 200h
INCF FSR0L ; Прибавляем адрес значения
INCF WREG ; Инкрементируем аккумулятор

M2:MOVWF INDF0
INCF FSR0L
DECF WREG

CPFSGT WREG,b'0' ;Условие (WREG > 0)? BRA M2:BRA M1
BRA M1
BRA M2
;--------------------------------------------------------
; Подготовка к лабе вариант 15

; Запись константы начального значения графика в переменную start_number

MOVLW d'64'
MOVWF start_number

MOVLW d'64'
MOVWF point_64

MOVLW d'128'
MOVWF point_128

MOVLW d'192'
MOVWF point_192

MOVLW d'256'
MOVWF point_256

; запись адреса нуля
MOVLW 00h
MOVWF FSR0L
MOVLW 02h
MOVWF FSR0H

MOVFF start_number, result ; из старта копируем в результат

; Интервал [0, 64)
M1:MOVWF INDF0 ; y = x
INCF result
INCF FSR0L
CPFSLT INDF0,point_64 ;Условие (INDF0 < point_64)? BRA M1:BRA M2
BRA M2
BRA M1

; Интервал [64, 128)
COMF result,F

M2:INCF result ;y = -x
INCF FSR0L
CPFSLT INDF0,point_128 ;Условие (INDF0 < point_128)? BRA M2:BRA M3
BRA M3
BRA M2


M3:MOVLW result
ADDWF result,W
ADDWF result,W
ADDWF result,W
MOVWF result
INCF FSR0L
CPFSLT INDF0,point_192 ;Условие (INDF0 < point_192)? BRA M3:BRA M4
BRA M4
BRA M3

COMF result,F

M4:INCF result ;y = -x
INCF FSR0L
CPFSLT INDF0,point_256 ;Условие (INDF0 < point_256)? BRA M4:BRA M5
BRA M5
BRA M4

M5:STOP: BRA STOP
END



















		END