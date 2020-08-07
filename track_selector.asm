	list		p=16f628A
	#include		<p16f628A.inc>

	__CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT

w_temp		EQU		0x70
status_temp	EQU		0x71
CNT_TRC	EQU		0x20
CNT1		EQU		0x21
CNT2		EQU		0x22
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

			movlw	0x03		;00000011
			movwf	TRISA		;PORTA=input
			clrf	TRISB

			bcf	STATUS,RP0

			clrf	PORTA
			clrf	PORTB
			clrf	CNT_TRC

TRC_LP1
			MOVLW	0x03
			ANDWF	PORTA,W	;RA0, RA1を読み出す
			GOTO		SELECT
TRC_LP2
			MOVF		CNT_TRC,w
			MOVWF	PORTB
			CALL		LP_DLY
			GOTO		TRC_LP1 
TRC_UP
			MOVF		CNT_TRC,w
			XORLW	0x0F			;最大値と一致不一致
			BTFSC	STATUS,Z	;最大値かどうか判別
			CLRF	CNT_TRC		;最大値の時のみ実行
			INCF		CNT_TRC,f
			GOTO		TRC_LP2
TRC_DOWN
			MOVF		CNT_TRC,w
			XORLW	0x00
			BTFSC	STATUS,Z
			GOTO	TRC_DOWN2
			DECFSZ	CNT_TRC,f
			GOTO		TRC_LP2
TRC_DOWN2
			MOVLW		0x0F		;最大値を設定
			MOVWF		CNT_TRC
			GOTO		TRC_LP2

SELECT
			ADDWF	PCL,f
			GOTO		TRC_LP1		;0 
			GOTO		TRC_UP		;1
			GOTO		TRC_DOWN		;2
			GOTO		TRC_LP1		;3
;************************************************************************ 
LP_DLY		;250mS
			movlw	0xfa
			movwf	CNT1
DLP1			;1mS
			movlw	0xf0
			movwf	CNT2
DLP2
			nop
			nop
			decfsz	CNT2,f
			goto	DLP2
			decfsz	CNT1,f
			goto	DLP1
			return
;************************************************************************
			END
