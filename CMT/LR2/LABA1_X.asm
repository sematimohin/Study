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

TMP1 RES 1 ; Gave names to variables in RAM
TMP2 RES 1
SUM  RES 1
  
summand_1 RES 2 ; For the lab
summand_2 RES 2
summa RES 2
final_result RES 2


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
		; THE ADDITION OF TWO NUMBERS
		
;MOVLW .10 ; Writing the number 10 to the battery
;MOVWF TMP1 ; Writing the current number from the accumulator to a variable named TMP1
 
;MOVLW .7 ; Writing the number 7 to the battery
;MOVWF TMP2 ; Writing the current number from the accumulator to a variable named TMP2
 
;MOVF TMP1, W ; Copy the value from the register named TMP1 to the accumulator
;ADDWF TMP2, W ; Add the current number that is in the accumulator (TMP1)
		; with specified register (TMP2)
		; Separated by commas, indicate where to write the result
		; WREG(accumulator) = TMP1 + TMP2
		
;MOVWF SUM ; Writing the value from the accumulator to the SUM variable
;MOVFF SUM, TMP1 ; We write the value from SUM to the TMP1 variable
		
		; LABA1
		
        ; код выполняет операцию [(75+-132)]/2
MOVLW  d'75'
MOVWF summand_1
		
MOVLW  d'132'
MOVWF summand_2

		
COMF summand_2,F 
INCF summand_2,F
		
MOVF summand_1, W
ADDWF summand_2, W 
MOVWF summa
		
BSF STATUS,C ; reset flag C
RRCF summa,F
		
DECF summa,F
COMF summa,F
			
MOVFF summa,final_result
		
;COMF summa ; convert reg summa in dop code
;INCF summa
		
;BSF STATUS,C ; 
;RRCF summa,F ;
		



		END