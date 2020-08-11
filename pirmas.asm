LIST P=16F648A, R=DEC    ; Use the PIC16F628 and decimal system

#include "P16F648A.INC"  ; Include header file

__config  _INTRC_OSC_NOCLKOUT & _LVP_OFF & _WDT_ON & _PWRTE_ON & _BODEN_ON


CBLOCK 0x20
temp1
temp2
temp3
temp4
temp5
temp6
temp7
temp8
temp9
temp10
temp11
temp12
temp13
temp14
temp15
temp16
temp17
ParityByte
ENDC


ORG    0x000            ; Program starts at 0x000

KINT1=0FH
KINT2=0EH
z=2

;
; --------------------------------
; SET ANALOG/DIGITAL INPUTS PORT A
; --------------------------------
;
movlw 7
movwf CMCON             ; CMCON=7 set comperators off
;
; ----------------
; INITIALIZE PORTS
; ----------------
;
movlw b'00000000'       ; set up portA
movwf PORTA

movlw b'00000100'       ; RB2(TX)=1 others are 0
movwf PORTB

bsf STATUS,RP0          ; RAM PAGE 1

movlw 0xFF
movwf TRISA             ; portA all pins input

movlw b'11110010'       ; RB7-RB4 and RB1(RX)=input, others output
movwf TRISB

MOVLW b'00001111'		;WATCHDOG
MOVWF OPTION_REG		;WATCHDOG


; ------------------------------------
; SET BAUD RATE TO COMMUNICATE WITH PC
; ------------------------------------
; Boot Baud Rate = 9600, No Parity, 1 Stop Bit
;
movlw 0x0C              ; 0x19=9600 bps (0x0C=19200 bps)
movwf SPBRG
movlw b'01100101'       ; brgh = high (2)
movwf TXSTA             ; enable Async Transmission, set brgh

bcf STATUS,RP0          ; RAM PAGE 0

movlw b'10010000'       ; enable Async Reception
movwf RCSTA

; ---------
; MAIN LOOP
; ---------
;

loop

loop
movlw B'00000001'	; -----------------------------
movwf PORTB			;
call LAIK			;
call LAIK			;  LED
movlw B'00000000'	;
movwf PORTB			;
clrwdt				;	WATCHDOG reset
call LAIK			;
call LAIK			; -----------------------------
btfss PORTB,6		; Durys atrakinamos, jei b6=high
goto unlock
clrwdt				;WATCHDOG clear
goto loop

unlock
movlw B'00001001'	; RS232 rele ON
movwf PORTB
call LAIK
movlw 0x02				;1 U
movwf temp1
movlw 0x0C
movwf temp2
movlw 0x62
movwf temp3
movlw 0x2E
movwf temp4
movlw 0x56
movwf temp5
movlw 0x44
movwf temp6
movlw 0x5B
movwf temp7
movlw 0x50
movwf temp8
movlw 0x3A
movwf temp9
movlw 0x31
movwf temp10
movlw 0x2D
movwf temp11
movlw 0x31
movwf temp12
movlw 0x5D
movwf temp13
movlw 0x24
movwf temp14
movlw 0x2D
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xA7			;2 U
movwf temp4
movlw 0x32
movwf temp10
movlw 0x32
movwf temp12
movlw 0xA8
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xF7			;3 U
movwf temp4
movlw 0x33
movwf temp10
movlw 0x33
movwf temp12
movlw 0xFA
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x02			;4 U
movwf temp4
movlw 0x34
movwf temp10
movlw 0x34
movwf temp12
movlw 0x07
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x13			;5 U
movwf temp4
movlw 0x35
movwf temp10
movlw 0x35
movwf temp12
movlw 0x1A
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x19			;6 U
movwf temp4
movlw 0x36
movwf temp10
movlw 0x36
movwf temp12
movlw 0x22
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x24			;7 U
movwf temp4
movlw 0x37
movwf temp10
movlw 0x37
movwf temp12
movlw 0x2F
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x2E			;8 U
movwf temp4
movlw 0x38
movwf temp10
movlw 0x38
movwf temp12
movlw 0x3B
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x3A			;9 U
movwf temp4
movlw 0x39
movwf temp10
movlw 0x39
movwf temp12
movlw 0x49
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x0E			;10 U
movwf temp2
movlw 0xBA
movwf temp4
movlw 0x31
movwf temp10
movlw 0x30
movwf temp11
movlw 0x2D
movwf temp12
movlw 0x31
movwf temp13
movlw 0x30
movwf temp14
movlw 0x5D
movwf temp15
movlw 0x24
movwf temp16
movlw 0x1B
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x6C			;11 U
movwf temp4
movlw 0x31
movwf temp11
movlw 0x31
movwf temp14
movlw 0x29
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xD0			;12 U
movwf temp4
movlw 0x32
movwf temp11
movlw 0x32
movwf temp14
movlw 0x35
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xD0			;13 U
movwf temp4
movlw 0x33
movwf temp11
movlw 0x33
movwf temp14
movlw 0x44
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xE3			;14 U
movwf temp4
movlw 0x34
movwf temp11
movlw 0x34
movwf temp14
movlw 0x4C
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xEC			;15 U
movwf temp4
movlw 0x35
movwf temp11
movlw 0x35
movwf temp14
movlw 0x57
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xF6			;16 U
movwf temp4
movlw 0x36
movwf temp11
movlw 0x36
movwf temp14
movlw 0x63
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x02			;17 U
movwf temp4
movlw 0x37
movwf temp11
movlw 0x37
movwf temp14
movlw 0x71
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x07			;18 U
movwf temp4
movlw 0x38
movwf temp11
movlw 0x38
movwf temp14
movlw 0x78
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x13			;19 U
movwf temp4
movlw 0x39
movwf temp11
movlw 0x39
movwf temp14
movlw 0x86
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x20			;20 U ----------
movwf temp4
movlw 0x32
movwf temp10
movlw 0x30
movwf temp11
movlw 0x32
movwf temp13
movlw 0x30
movwf temp14
movlw 0x83
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x26			;21 U
movwf temp4
movlw 0x31
movwf temp11
movlw 0x31
movwf temp14
movlw 0x8B
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x2F			;22 U
movwf temp4
movlw 0x32
movwf temp11
movlw 0x32
movwf temp14
movlw 0x96
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x3C			;23 U
movwf temp4
movlw 0x33
movwf temp11
movlw 0x33
movwf temp14
movlw 0xA5
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x49			;24 U
movwf temp4
movlw 0x34
movwf temp11
movlw 0x34
movwf temp14
movlw 0xB4
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x52			;25 U
movwf temp4
movlw 0x35
movwf temp11
movlw 0x35
movwf temp14
movlw 0xBF
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x58			;26 U
movwf temp4
movlw 0x36
movwf temp11
movlw 0x36
movwf temp14
movlw 0xC7
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x51			;27 U
movwf temp4
movlw 0x37
movwf temp11
movlw 0x37
movwf temp14
movlw 0xD2
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x6B			;28 U
movwf temp4
movlw 0x38
movwf temp11
movlw 0x38
movwf temp14
movlw 0xDE
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x75			;29 U
movwf temp4
movlw 0x39
movwf temp11
movlw 0x39
movwf temp14
movlw 0xEA
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x7F			;30 U ----------
movwf temp4
movlw 0x33
movwf temp10
movlw 0x30
movwf temp11
movlw 0x33
movwf temp13
movlw 0x30
movwf temp14
movlw 0xE4
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x88			;31 U
movwf temp4
movlw 0x31
movwf temp11
movlw 0x31
movwf temp14
movlw 0xEF
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x92			;32 U
movwf temp4
movlw 0x32
movwf temp11
movlw 0x32
movwf temp14
movlw 0xFB
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x9B			;33 U
movwf temp4
movlw 0x33
movwf temp11
movlw 0x33
movwf temp14
movlw 0x06
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xA6			;34 U
movwf temp4
movlw 0x34
movwf temp11
movlw 0x34
movwf temp14
movlw 0x13
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

check	movlw B'00001000'	; -----------------------------
movwf PORTB			;
clrwdt				; WATCHDOG reset
call LAIK			; LED
movlw B'00001001'	;
movwf PORTB			;
call LAIK			; -----------------------------
btfsc PORTB,7		; Durys uzrakinamos, jei b7=high
goto check
clrwdt				;WATCHDOG reset
goto lock

lock

movlw 0x02				;1 L
movwf temp1
movlw 0x0C
movwf temp2
movlw 0x62
movwf temp3
movlw 0x38
movwf temp4
movlw 0x56
movwf temp5
movlw 0x44
movwf temp6
movlw 0x5B
movwf temp7
movlw 0x52
movwf temp8
movlw 0x3A
movwf temp9
movlw 0x31
movwf temp10
movlw 0x2D
movwf temp11
movlw 0x31
movwf temp12
movlw 0x5D
movwf temp13
movlw 0x24
movwf temp14
movlw 0x39
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x9F			;2 L
movwf temp4
movlw 0x32
movwf temp10
movlw 0x32
movwf temp12
movlw 0xA2
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xFC			;3 L
movwf temp4
movlw 0x33
movwf temp10
movlw 0x33
movwf temp12
movlw 0x01
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x07			;4 L
movwf temp4
movlw 0x34
movwf temp10
movlw 0x34
movwf temp12
movlw 0x0E
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x0F			;5 L
movwf temp4
movlw 0x35
movwf temp10
movlw 0x35
movwf temp12
movlw 0x18
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x1E			;6 L
movwf temp4
movlw 0x36
movwf temp10
movlw 0x36
movwf temp12
movlw 0x29
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x28			;7 L
movwf temp4
movlw 0x37
movwf temp10
movlw 0x37
movwf temp12
movlw 0x35
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x33			;8 L
movwf temp4
movlw 0x38
movwf temp10
movlw 0x38
movwf temp12
movlw 0x42
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x3F			;9 L
movwf temp4
movlw 0x39
movwf temp10
movlw 0x39
movwf temp12
movlw 0x50
movwf temp15
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x0E			;10 L
movwf temp2
movlw 0xC0
movwf temp4
movlw 0x31
movwf temp10
movlw 0x30
movwf temp11
movlw 0x2D
movwf temp12
movlw 0x31
movwf temp13
movlw 0x30
movwf temp14
movlw 0x5D
movwf temp15
movlw 0x24
movwf temp16
movlw 0x23
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xCB			;11 L
movwf temp4
movlw 0x31
movwf temp11
movlw 0x31
movwf temp14
movlw 0x30
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xD5			;12 L
movwf temp4
movlw 0x32
movwf temp11
movlw 0x32
movwf temp14
movlw 0x3C
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xD8			;13 L
movwf temp4
movlw 0x33
movwf temp11
movlw 0x33
movwf temp14
movlw 0x41
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xE8			;14 L
movwf temp4
movlw 0x34
movwf temp11
movlw 0x34
movwf temp14
movlw 0x53
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xF1			;15 L
movwf temp4
movlw 0x35
movwf temp11
movlw 0x35
movwf temp14
movlw 0x5E
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xF9			;16 L
movwf temp4
movlw 0x36
movwf temp11
movlw 0x36
movwf temp14
movlw 0x68
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xFD			;17 L
movwf temp4
movlw 0x37
movwf temp11
movlw 0x37
movwf temp14
movlw 0x6E
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x0D			;18 L
movwf temp4
movlw 0x38
movwf temp11
movlw 0x38
movwf temp14
movlw 0x80
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x17			;19 L
movwf temp4
movlw 0x39
movwf temp11
movlw 0x39
movwf temp14
movlw 0x8C
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x1B			;20 L ----------
movwf temp4
movlw 0x32
movwf temp10
movlw 0x30
movwf temp11
movlw 0x32
movwf temp13
movlw 0x30
movwf temp14
movlw 0x80
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x2B			;21 L
movwf temp4
movlw 0x31
movwf temp11
movlw 0x31
movwf temp14
movlw 0x92
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x37			;22 L
movwf temp4
movlw 0x32
movwf temp11
movlw 0x32
movwf temp14
movlw 0xA0
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x40			;23 L
movwf temp4
movlw 0x33
movwf temp11
movlw 0x33
movwf temp14
movlw 0xAB
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x45			;24 L
movwf temp4
movlw 0x34
movwf temp11
movlw 0x34
movwf temp14
movlw 0xB2
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x4E			;25 L
movwf temp4
movlw 0x35
movwf temp11
movlw 0x35
movwf temp14
movlw 0xBD
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x5D			;26 L
movwf temp4
movlw 0x36
movwf temp11
movlw 0x36
movwf temp14
movlw 0xCE
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x64			;27 L
movwf temp4
movlw 0x37
movwf temp11
movlw 0x37
movwf temp14
movlw 0xD7
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x70			;28 L
movwf temp4
movlw 0x38
movwf temp11
movlw 0x38
movwf temp14
movlw 0xE5
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x79			;29 L
movwf temp4
movlw 0x39
movwf temp11
movlw 0x39
movwf temp14
movlw 0xF0
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x84			;30 L ----------
movwf temp4
movlw 0x33
movwf temp10
movlw 0x30
movwf temp11
movlw 0x33
movwf temp13
movlw 0x30
movwf temp14
movlw 0xEB
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x8D			;31 L
movwf temp4
movlw 0x31
movwf temp11
movlw 0x31
movwf temp14
movlw 0xF6
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x97			;32 L
movwf temp4
movlw 0x32
movwf temp11
movlw 0x32
movwf temp14
movlw 0x02
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xA1			;33 U
movwf temp4
movlw 0x33
movwf temp11
movlw 0x33
movwf temp14
movlw 0x0E
movwf temp17
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0xAC			;34 U
movwf temp4
movlw 0x34
movwf temp11
movlw 0x34
movwf temp14
movlw 0x1B
movwf temp17
call sorted

clrwdt				;WATCHDOG clear
movlw B'00000000'	; -----------------------------
movwf PORTB
goto loop

sorted

movf  temp1,W
call send
movf  temp2,W
call send
movf  temp3,W
call send
movf  temp4,W
call send
movf  temp5,W
call send
movf  temp6,W
call send
movf  temp7,W
call send
movf  temp8,W
call send
movf  temp9,W
call send
movf  temp10,W
call send
movf  temp11,W
call send
movf  temp12,W
call send
movf  temp13,W
call send
movf  temp14,W
call send
movf  temp15,W
call send
movf  temp16,W
call send
movf  temp17,W
call send

return
;
; -------------------------------------------------------------
; SEND CHARACTER IN W VIA RS232 AND WAIT UNTIL FINISHED SENDING
; -------------------------------------------------------------
;
send    movwf 	TXREG             ; send data in W
call 	CalcParity
btfsc	ParityByte,0
goto	p0
goto	p1
p0		bsf 	STATUS,RP0
bsf		TXSTA,0
bcf 	STATUS,RP0
goto	p2
p1  	bsf 	STATUS,RP0
bcf		TXSTA,0
bcf 	STATUS,RP0


p2
TransWt bsf 	STATUS,RP0          ; RAM PAGE 1
WtHere  btfss 	TXSTA,TRMT        ; (1) transmission is complete if hi
goto 	WtHere

bcf 	STATUS,RP0          ; RAM PAGE 0
return



CalcParity:	movwf		ParityByte		;get data for parity calculation
rrf			ParityByte,W	;rotate
xorwf		ParityByte,W	;compare all bits against neighbor
movwf		ParityByte		;save
rrf			ParityByte,F	;rotate
rrf			ParityByte,F	;rotate
xorwf		ParityByte,F	;compare every 2nd bit and save
swapf		ParityByte,W	;rotate 4
xorwf		ParityByte,F	;compare every 4th bit and save
return



LAIK	MOVLW 	D'20'
MOVWF 	KINT2
LAIK2	MOVLW 	D'20'
MOVWF 	KINT1
CLRW
LAIK1	ADDLW 	1
BTFSS 	STATUS,z
GOTO 	LAIK1
DECFSZ 	KINT1,F
GOTO	LAIK1
DECFSZ 	KINT2,F
GOTO 	LAIK2
RETURN


END
