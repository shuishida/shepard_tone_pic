	list		p=16f628A
	#include	<p16f628A.inc>

	__CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BODEN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTRC_OSC_NOCLKOUT 

w_temp		EQU		0x70
status_temp	EQU		0x71
NOTE		EQU		0x20	; store base key
TONE		EQU		0x21
CNT0		EQU		0x22	; store decrement count
CNT1		EQU		0x23	; store number of loops per note
CNT2		EQU		0x24	; store delay count
CNT3		EQU		0x25	; store music loop count
CNT4		EQU		0x26	; store music loop count
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
			clrf	CNT0

main_loop
			movlw	0x07		; extract upper address
			movwf	PCLATH		; store upper address
			MOVF	PORTA,w
			GOTO	SELECT
;************************************************************************
MUSIC_0
			goto	MUSIC_0
MUSIC_1
			clrf	TONE
MUSIC_1_1
			call	TONE_A
			call	TONE_A
			call	TONE_Gb
			call	TONE_G
			call	TONE_A
			call	TONE_A
			call	TONE_Gb
			call	TONE_G
			call	TONE_A
			call	BREATH
			call	TONE_A
			call	TONE_B
			call	TONE_Db
			call	TONE_D
			call	TONE_E
			call	TONE_Gb
			call	TONE_G
			call	TONE_Gb
			call	TONE_Gb
			call	TONE_D
			call	TONE_E
			call	TONE_Gb
			call	TONE_Gb
			call	BREATH
			call	TONE_Gb
			call	TONE_G
			call	TONE_A
			call	TONE_B
			call	TONE_A
			call	TONE_G
			call	TONE_A
			call	TONE_D
			call	TONE_Db
			call	TONE_D
			call	TONE_G
			call	TONE_G
			call	TONE_B
			call	TONE_A
			call	TONE_G
			call	TONE_G
			call	TONE_Gb
			call	TONE_E
			call	TONE_Gb
			call	TONE_E
			call	TONE_D
			call	TONE_E
			call	TONE_Gb
			call	TONE_G
			call	TONE_A
			call	TONE_B
			call	TONE_G
			call	TONE_G
			call	TONE_B
			call	TONE_A
			call	TONE_B
			call	TONE_B
			call	TONE_Db
			call	TONE_D
			call	TONE_A
			call	TONE_B
			call	TONE_Db
			call	TONE_D
			call	TONE_E
			call	TONE_Gb
			call	TONE_G
			call	TONE_A
			movlw	0x09
			addwf	TONE,w
			addlw	0xF4
			btfss	STATUS,C
			addlw	0x0C
			movwf	TONE
			goto	MUSIC_1_1
MUSIC_2
			clrf	TONE
			movlw	0x0C
			movwf	CNT3
MUSIC_2_1
			movlw	0x02
			movwf	CNT4
MUSIC_2_2
			call	TONE_D
			call	TONE_D
			call	BREATH
			call	TONE_D
			call	TONE_D
			call	TONE_C
			call	TONE_C
			call	TONE_B
			call	TONE_B
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_A
			call	TONE_A
			call	TONE_E
			call	TONE_E
			call	REST
			call	REST
			call	TONE_Gb
			call	TONE_Gb
			call	BREATH
			call	TONE_Gb
			call	TONE_Gb
			call	TONE_E
			call	TONE_E
			call	TONE_D
			call	TONE_D
			call	TONE_Db
			call	TONE_Db
			call	TONE_D
			call	TONE_D
			call	TONE_G
			call	TONE_G
			call	REST
			call	REST
			call	TONE_A
			call	TONE_A
			call	TONE_G
			call	TONE_G
			call	TONE_Gb
			call	TONE_Gb
			call	TONE_E
			call	TONE_E
			call	TONE_D
			call	TONE_D
			call	TONE_C
			call	TONE_C
			call	TONE_B
			call	TONE_B
			call	TONE_A
			call	TONE_A
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	TONE_Gb
			call	TONE_Gb
			call	TONE_Gb
			call	TONE_Gb
			decfsz	CNT4,f
			goto	MUSIC_2_3
			call	TONE_G
			call	TONE_G
			call	TONE_G
			call	TONE_G
			call	REST
			call	REST
			call	REST
			call	REST
			incf	TONE,f
			decfsz	CNT3,f
			goto	MUSIC_2_1
			goto	MUSIC_2
MUSIC_2_3
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	REST
			call	REST
			call	REST
			call	REST
			goto	MUSIC_2_2
MUSIC_3
			clrf	TONE
			movlw	0x0C
			movwf	CNT3
MUSIC_3_A
			call	MUSIC_3_1
			call	MUSIC_3_2
			call	MUSIC_3_1
			call	MUSIC_3_3
			call	MUSIC_3_4
			call	MUSIC_3_2
			call	MUSIC_3_4
			call	MUSIC_3_3
			incf	TONE,f
			decfsz	CNT3,f
			goto	MUSIC_3_A
			goto	MUSIC_3
MUSIC_3_1
			call	TONE_A
			call	TONE_A
			call	TONE_C
			call	TONE_C
			call	TONE_C
			call	TONE_C
			call	TONE_D
			call	TONE_D
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	TONE_F
			call	TONE_E
			call	TONE_E
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	TONE_B
			call	TONE_B
			call	TONE_G
			call	TONE_G
			call	TONE_G
			call	TONE_A
			call	TONE_B
			call	TONE_B
			call	TONE_C
			call	TONE_C
			call	TONE_C
			return
MUSIC_3_2
			call	TONE_C
			call	TONE_A
			call	TONE_A
			call	BREATH
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_Ab
			call	TONE_A
			call	TONE_A
			call	TONE_B
			call	TONE_B
			call	TONE_B
			call	TONE_B
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	TONE_E
			return
MUSIC_3_3
			call	TONE_B
			call	TONE_A
			call	TONE_A
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_Gb
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			return
MUSIC_3_4
			call	REST
			call	REST
			call	TONE_G
			call	TONE_G
			call	TONE_G
			call	TONE_G
			call	BREATH
			call	TONE_G
			call	TONE_G
			call	BREATH
			call	TONE_G
			call	TONE_G
			call	TONE_G
			call	TONE_Gb
			call	TONE_E
			call	TONE_E
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	TONE_B
			call	TONE_B
			call	TONE_G
			call	TONE_G
			call	TONE_G
			call	TONE_A
			call	TONE_B
			call	TONE_B
			call	TONE_C
			call	TONE_C
			call	TONE_C
			return
MUSIC_4
			clrf	TONE
			movlw	0x0C
			movwf	CNT3
MUSIC_4_A
			call	MUSIC_4_1
			call	MUSIC_4_2
			call	MUSIC_4_1
			call	MUSIC_4_3
			incf	TONE,f
			decfsz	CNT3,f
			goto	MUSIC_4_A
			goto	MUSIC_4
MUSIC_4_1
			call	TONE_E
			call	TONE_A
			call	TONE_A
			call	TONE_C
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	REST
			call	TONE_E
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_B
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	REST
			call	TONE_E
			call	TONE_F
			call	TONE_E
			call	TONE_G
			call	BREATH
			call	TONE_G
			call	TONE_G
			call	TONE_F
			call	TONE_E
			call	TONE_D
			call	TONE_E
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	REST
			call	TONE_D
			call	TONE_E
			call	TONE_F
			call	TONE_G
			call	BREATH
			call	TONE_G
			call	BREATH
			call	TONE_G
			call	TONE_F
			call	TONE_E
			call	TONE_D
			call	TONE_C
			call	TONE_E
			call	TONE_E
			call	TONE_E
			call	REST
			call	REST
			call	TONE_B
			call	TONE_B
			call	TONE_C
			call	TONE_C
			return
MUSIC_4_2
			call	TONE_D
			call	TONE_E
			call	TONE_E
			call	TONE_B
			call	TONE_B
			call	TONE_B
			call	TONE_B
			call	TONE_B
			call	TONE_B
			call	TONE_B
			call	REST
			return
MUSIC_4_3
			call	TONE_Ab
			call	TONE_B
			call	TONE_B
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	TONE_A
			call	REST
			return
MUSIC_5
			clrf	TONE
			movlw	0x0C
			movwf	CNT3
MUSIC_5_1
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_D
			call	TONE_C
			call	TONE_D
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Bb
			call	TONE_Ab
			call	TONE_G
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_C
			call	TONE_C
			call	TONE_Bb
			call	TONE_Bb
			call	TONE_F
			call	TONE_G
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_Ab
			call	TONE_G
			call	BREATH
			call	TONE_G
			call	TONE_G
			call	REST
			call	REST
			call	REST
			call	REST
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_D
			call	TONE_C
			call	TONE_Bb
			call	TONE_D
			call	TONE_D
			call	TONE_D
			call	TONE_Eb
			call	BREATH
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	TONE_Eb
			call	REST
			call	TONE_Bb
			call	TONE_Ab
			call	TONE_G
			call	TONE_F
			call	TONE_F
			call	REST
			call	REST
			call	TONE_F
			call	TONE_F
			call	TONE_F
			call	TONE_Eb
			call	BREATH
			call	TONE_Eb
			call	TONE_Eb
			call	REST
			call	REST
			incf	TONE,f
			decfsz	CNT3,f
			goto	MUSIC_5_1
			goto	MUSIC_5

;************************************************************************
TONE_A			movlw	0x00
			goto	NOTESET
TONE_Bb			movlw	0x01
			goto	NOTESET
TONE_B			movlw	0x02
			goto	NOTESET
TONE_C			movlw	0x03
			goto	NOTESET
TONE_Db			movlw	0x04
			goto	NOTESET
TONE_D			movlw	0x05
			goto	NOTESET
TONE_Eb			movlw	0x06
			goto	NOTESET
TONE_E			movlw	0x07
			goto	NOTESET
TONE_F			movlw	0x08
			goto	NOTESET
TONE_Gb			movlw	0x09
			goto	NOTESET
TONE_G			movlw	0x0a
			goto	NOTESET
TONE_Ab			movlw	0x0b
			goto	NOTESET
;************************************************************************
DLYSET
			MOVLW	0x06		; extract upper address
			MOVWF	PCLATH		; store upper address
			MOVLW	0x10
			ADDWF	NOTE,w
			GOTO	SETDATA
NOTESET
			ADDWF	TONE,w
			ADDLW	0xF4
			BTFSS	STATUS,C
			ADDLW	0x0C
			MOVWF	NOTE
			MOVLW	0x06		; extract upper address
			MOVWF	PCLATH		; store upper address
			MOVF	NOTE,w
			CALL	SETDATA
			MOVWF	CNT1
;************************************************************************
TONE_TM
			NOP
			NOP
TONE_LP
			MOVF	CNT0,W		; 1 1
			MOVWF	PORTB		; 1 1	export to PORTB
			CALL	DLYSET

			DECFSZ	CNT0,F		; 1 2
			GOTO	TONE_TM		; 2 0

			DECFSZ	CNT1,f		; 1 2
			GOTO	TONE_LP		; 2 0
			RETURN			; 2 2
;************************************************************************
TONEDLY_A		; DLY + 18 = (base period)/16

			CALL	DLY_32
			CALL	DLY_16
			NOP
			NOP
			NOP
			RETURN
;************************************************************************
TONEDLY_Bb
			CALL	DLY_32
			CALL	DLY_8
			CALL	DLY_4
			NOP
			NOP
			NOP
			RETURN
;************************************************************************
TONEDLY_B
			CALL	DLY_32
			CALL	DLY_8
			NOP
			NOP
			NOP
			RETURN
;************************************************************************
TONEDLY_C
			CALL	DLY_32
			CALL	DLY_8
			RETURN
;************************************************************************
TONEDLY_Db
			CALL	DLY_32
			CALL	DLY_4
			RETURN
;************************************************************************
TONEDLY_D
			CALL	DLY_32
			NOP
			RETURN
;************************************************************************
TONEDLY_Eb
			CALL	DLY_16
			CALL	DLY_8
			CALL	DLY_4
			NOP
			NOP
			RETURN
;************************************************************************
TONEDLY_E
			CALL	DLY_16
			CALL	DLY_8
			NOP
			NOP
			NOP
			RETURN
;************************************************************************
TONEDLY_F
			CALL	DLY_16
			CALL	DLY_8
			NOP
			RETURN
;************************************************************************
TONEDLY_Gb
			CALL	DLY_16
			CALL	DLY_4
			NOP
			NOP
			RETURN
;************************************************************************
TONEDLY_G
			CALL	DLY_16
			CALL	DLY_4
			RETURN
;************************************************************************
TONEDLY_Ab
			CALL	DLY_16
			NOP
			NOP
			RETURN
;************************************************************************
DLP1			;CNT2*5+1uS
			nop
			nop
			decfsz	CNT2,f
			goto	DLP1
			return
;************************************************************************
REST			;2+(2+DLP2*CNT1+1)=CNT1*DLP2+5=250000uS
			;239*1046=249994

			movlw	0xef	;239
			movwf	CNT1
DLP2	
			call	DLP3
			decfsz	CNT1,f
			goto	DLP2
			nop
			return
DLP3			;1046uS
			movlw	0xf8	;206
			movwf	CNT2
			call	DLP1
			call	DLY_4
			return
BREATH		
			movlw	0x18
			movwf	CNT1
DLP4
			call	DLP3
			decfsz	CNT1
			goto	DLP4
			return
;************************************************************************
DLY_32			CALL	DLY_16
			CALL	DLY_8
			CALL	DLY_4
			RETURN
DLY_16			CALL	DLY_8
			CALL	DLY_4
			RETURN
DLY_8			CALL	DLY_4
			RETURN
DLY_4			RETURN
;************************************************************************
			ORG		05FFh
SETDATA
			ADDWF	PCL,f
			ORG		0600h
			RETLW	0x0e		;TONE_A  0x00
			RETLW	0x0f		;TONE_Bb 0x01
			RETLW	0x10		;TONE_B  0x02
			RETLW	0x10		;TONE_C  0x03
			RETLW	0x11		;TONE_Db 0x04
			RETLW	0x12		;TONE_D  0x05
			RETLW	0x14		;TONE_Eb 0x06
			RETLW	0x15		;TONE_E  0x07
			RETLW	0x16		;TONE_F  0x08
			RETLW	0x17		;TONE_Gb 0x09
			RETLW	0x18		;TONE_G  0x0a
			RETLW	0x1a		;TONE_Ab 0x0b
			RETLW	0x00		;	 0x0c
			RETLW	0x00		;	 0x0d
			RETLW	0x00		;	 0x0e
			RETLW	0x00		;	 0x0f
			GOTO	TONEDLY_A	;TONE_A  0x10
			GOTO	TONEDLY_Bb	;TONE_Bb 0x11
			GOTO	TONEDLY_B	;TONE_B  0x12
			GOTO	TONEDLY_C	;TONE_C  0x13
			GOTO	TONEDLY_Db	;TONE_Db 0x14
			GOTO	TONEDLY_D	;TONE_D  0x15
			GOTO	TONEDLY_Eb	;TONE_Eb 0x16
			GOTO	TONEDLY_E	;TONE_E  0x17
			GOTO	TONEDLY_F	;TONE_F  0x18
			GOTO	TONEDLY_Gb	;TONE_Gb 0x19
			GOTO	TONEDLY_G	;TONE_G  0x1a
			GOTO	TONEDLY_Ab	;TONE_Ab 0x1b
			GOTO	main_loop	;	 0x1c
			GOTO	main_loop	;	 0x1d
			GOTO	main_loop	;	 0x1e
			GOTO	main_loop	;	 0x1f
;************************************************************************
			ORG		06FFh
SELECT
			ADDWF	PCL,f
			ORG		0700h
			GOTO	MUSIC_0
			GOTO	MUSIC_1
			GOTO	MUSIC_2
			GOTO	MUSIC_3
			GOTO	MUSIC_4
			GOTO	MUSIC_5
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop
			GOTO	main_loop

;*******************************************
			END