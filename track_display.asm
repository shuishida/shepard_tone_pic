	list		p=16f628A
	#include	<p16f628A.inc>

	__CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT

w_temp		EQU		0x70
status_temp	EQU		0x71
DATA1		EQU		0x20
CNT1		EQU		0x21
;************************************************************************
			ORG	0x000
			goto	main

			ORG	0x004
			movwf	w_temp
			movf	STATUS,w
			movwf	status_temp
;ISR	Codes
			movf	status_temp,w
			movwf	STATUS
			swapf	w_temp,f
			swapf	w_temp,w
			retfie

main
			bcf	STATUS,RP0
			bcf	STATUS,RP1

			clrf	INTCON
			clrf	PORTA

			movlw	0x07
			movwf	CMCON

			bsf	STATUS,RP0
			bsf	PCON,OSCF

			movlw	0xFF		;11111111
			movwf	TRISA		;PORTA=input
			clrf	TRISB

			bcf	STATUS,RP0

			clrf	PORTA
			clrf	PORTB

main_loop

			;アノード／1桁目の点灯
			MOVLW	0xF0
			ANDWF	PORTA,w
			MOVWF	DATA1
			SWAPF	DATA1,w
			CALL	SELECT

			XORLW	0xFF		;11111111 SELECTで得た値の逆
			MOVWF	PORTB
			CALL	LP_DLY
			CLRF	PORTB

			;カソード／2桁目の点灯
			MOVLW	0x0F
			ANDWF	PORTA,w
			CALL	SELECT

			MOVWF	PORTB
			CALL	LP_DLY
			CLRF	PORTB

			GOTO	main_loop

;************************************************************************
SELECT
			ADDWF	PCL,f			;b-a-f-g-c-d-e-A/K
			RETLW	b'11101110'		;LIGHT_0 
			RETLW	b'10001000'		;LIGHT_1
			RETLW	b'11010110'		;LIGHT_2
			RETLW	b'11011100'		;LIGHT_3
			RETLW	b'10111000'		;LIGHT_4
			RETLW	b'01111100'		;LIGHT_5
			RETLW	b'01111110'		;LIGHT_6
			RETLW	b'11001000'		;LIGHT_7
			RETLW	b'11111110'		;LIGHT_8
			RETLW	b'11111100'		;LIGHT_9
			RETLW	b'11111010'		;LIGHT_A
			RETLW	b'00111110'		;LIGHT_B
			RETLW	b'01100110'		;LIGHT_C
			RETLW	b'10011110'		;LIGHT_D
			RETLW	b'01110110'		;LIGHT_E
			RETLW	b'01110010'		;LIGHT_F

;************************************************************************
LP_DLY		;	1mS
			movlw	0xf0
			movwf	CNT1
DLP1
			nop
			nop
			decfsz	CNT1,f
			goto	DLP1
			return

;************************************************************************
			END