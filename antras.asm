LIST P=16F628, R=DEC    ; Use the PIC16F628 and decimal system

#include "P16F628.INC"  ; Include header file

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
movlw 0x19              ; 0x19=9600 bps (0x0C=19200 bps)
movwf SPBRG
movlw b'00100100'       ; brgh = high (2)
movwf TXSTA             ; enable Async Transmission, set brgh

bcf STATUS,RP0          ; RAM PAGE 0

movlw b'10010000'       ; enable Async Reception
movwf RCSTA

; ---------
; MAIN LOOP
; ---------
;



loop
movlw B'00000001'	; -----------------------------
movwf PORTB			;
call LAIK		;
call LAIK		;
call LAIK		;
call LAIK		; LED
movlw B'00000000'	;
movwf PORTB			;
clrwdt				;	WATCHDOG reset
call LAIK		;
call LAIK		;
call LAIK		;
call LAIK		; LED
btfss PORTB,6		; Durys atrakinamos, jei b6=high
goto unlock
clrwdt				;WATCHDOG clear
goto loop

unlock
movlw B'00001001'	; RS232 rele ON
movwf PORTB
call LAIK
movlw 0x3A				;1.1-1 U
movwf temp1
movlw 0x30
movwf temp2
movlw 0x30
movwf temp3
movlw 0x30
movwf temp4
movlw 0x31
movwf temp5
movlw 0x30
movwf temp6
movlw 0x30
movwf temp7
movlw 0x34
movwf temp8
movlw 0x32
movwf temp9
movlw 0x42
movwf temp10
movlw 0x44
movwf temp11
movlw 0x0D
movwf temp12
movlw 0x0A
movwf temp13
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;1.1-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x46
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK

movlw 0x30			;1.1-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x46
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x34			;1.2-1 U
movwf temp8
movlw 0x36
movwf temp9
movlw 0x42
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;1.2-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x46
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;1.2-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x46
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x33			;3.1-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x32
movwf temp9
movlw 0x42
movwf temp10
movlw 0x42
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;3.1-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x44
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;3.1-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x44
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x34			;4.1-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x32
movwf temp9
movlw 0x42
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;4.1-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x43
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;4.1-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x43
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x35			;5.1-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x32
movwf temp9
movlw 0x42
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;5.1-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x42
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;5.1-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x42
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x36			;6.1-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x32
movwf temp9
movlw 0x42
movwf temp10
movlw 0x38
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;6.1-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;6.1-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x36			;6.2-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x36
movwf temp9
movlw 0x42
movwf temp10
movlw 0x34
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;6.2-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;6.2-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x37			;7.1-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x32
movwf temp9
movlw 0x42
movwf temp10
movlw 0x37
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;7.1-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;7.1-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x37			;7.2-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x36
movwf temp9
movlw 0x42
movwf temp10
movlw 0x33
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;7.2-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;7.2-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x38			;8.1-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x32
movwf temp9
movlw 0x42
movwf temp10
movlw 0x36
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;8.1-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x38
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;8.1-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x38
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x39			;9.1-1 U
movwf temp5
movlw 0x34
movwf temp8
movlw 0x32
movwf temp9
movlw 0x42
movwf temp10
movlw 0x35
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;9.1-2 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x37
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;9.1-3 U
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x37
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK

movlw  0x00			;2 durys - 1 door contr
call send
movlw  0x3A
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x32
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x34
call send
movlw  0x36
call send
movlw  0x42
call send
movlw  0x38
call send
movlw  0x0D
call send
movlw  0x0A
call send
call LAIK
movlw  0x00
call send
movlw  0x3A
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x32
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x46
call send
movlw  0x45
call send
movlw  0x0D
call send
movlw  0x0A
call send
call LAIK
movlw  0x00
call send
movlw  0x3A
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x32
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x34
call send
movlw  0x32
call send
movlw  0x42
call send
movlw  0x43
call send
movlw  0x0D
call send
movlw  0x0A
call send
call LAIK


check	movlw B'00001000'	; -----------------------------
movwf PORTB			;
clrwdt				; WATCHDOG reset
call LAIK			; LED
call LAIK			;
movlw B'00001001'	;
movwf PORTB			;
call LAIK			; -----------------------------
call LAIK			;
btfsc PORTB,7		; Durys uzrakinamos, jei b7=high
goto check
clrwdt				;WATCHDOG reset
goto lock

lock

movlw 0x31				;1.1-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x31
movwf temp9
movlw 0x42
movwf temp10
movlw 0x45
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;1.1-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x46
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;1.1-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x46
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x34			;1.2-1 L
movwf temp8
movlw 0x35
movwf temp9
movlw 0x42
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;1.2-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x46
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;1.2-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x46
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x33			;3.1-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x31
movwf temp9
movlw 0x42
movwf temp10
movlw 0x43
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;3.1-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x44
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;3.1-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x44
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x34			;4.1-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x31
movwf temp9
movlw 0x42
movwf temp10
movlw 0x42
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;4.1-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x43
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;4.1-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x43
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x35			;5.1-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x31
movwf temp9
movlw 0x42
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;5.1-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x42
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;5.1-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x42
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x36			;6.1-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x31
movwf temp9
movlw 0x42
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;6.1-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;6.1-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x36			;6.2-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x35
movwf temp9
movlw 0x42
movwf temp10
movlw 0x35
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;6.2-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;6.2-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x41
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x37			;7.1-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x31
movwf temp9
movlw 0x42
movwf temp10
movlw 0x38
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;7.1-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;7.1-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x37			;7.2-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x35
movwf temp9
movlw 0x42
movwf temp10
movlw 0x34
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;7.2-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;7.2-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x39
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x38			;8.1-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x31
movwf temp9
movlw 0x42
movwf temp10
movlw 0x37
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;8.1-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x38
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;8.1-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x38
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK
movlw 0x39			;9.1-1 L
movwf temp5
movlw 0x34
movwf temp8
movlw 0x31
movwf temp9
movlw 0x42
movwf temp10
movlw 0x36
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x41			;9.1-2 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x35
movwf temp10
movlw 0x37
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
movlw 0x30			;9.1-3 L
movwf temp8
movlw 0x30
movwf temp9
movlw 0x46
movwf temp10
movlw 0x37
movwf temp11
call sorted
clrwdt				;WATCHDOG clear
call LAIK
call LAIK
call LAIK
call LAIK
call LAIK



movlw  0x00			;2 durys
call send
movlw  0x3A
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x32
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x34
call send
movlw  0x35
call send
movlw  0x42
call send
movlw  0x39
call send
movlw  0x0D
call send
movlw  0x0A
call send
call LAIK
movlw  0x00
call send
movlw  0x3A
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x32
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x46
call send
movlw  0x45
call send
movlw  0x0D
call send
movlw  0x0A
call send
call LAIK
movlw  0x00
call send
movlw  0x3A
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x32
call send
movlw  0x30
call send
movlw  0x30
call send
movlw  0x34
call send
movlw  0x31
call send
movlw  0x42
call send
movlw  0x44
call send
movlw  0x0D
call send
movlw  0x0A
call send
call LAIK

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

return
;
; -------------------------------------------------------------
; SEND CHARACTER IN W VIA RS232 AND WAIT UNTIL FINISHED SENDING
; -------------------------------------------------------------
;
send    movwf 	TXREG             ; send data in W

TransWt bsf 	STATUS,RP0          ; RAM PAGE 1
WtHere  btfss 	TXSTA,TRMT        ; (1) transmission is complete if hi
goto 	WtHere

bcf 	STATUS,RP0          ; RAM PAGE 0
return



LAIK	MOVLW 	D'3'
MOVWF 	KINT2
LAIK2	MOVLW 	D'58'
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
