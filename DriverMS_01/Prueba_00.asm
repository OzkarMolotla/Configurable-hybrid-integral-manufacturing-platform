
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;Prueba_00.c,16 :: 		void main(){
;Prueba_00.c,17 :: 		PORTB = 0x0000;
	PUSH	W10
	PUSH	W11
	CLR	PORTB
;Prueba_00.c,18 :: 		TRISB = 0x0001;
	MOV	#1, W0
	MOV	WREG, TRISB
;Prueba_00.c,19 :: 		PORTD = 0x0000;
	CLR	PORTD
;Prueba_00.c,20 :: 		TRISD = 0x0001;
	MOV	#1, W0
	MOV	WREG, TRISD
;Prueba_00.c,21 :: 		ADPCFG = 0x01FF;
	MOV	#511, W0
	MOV	WREG, ADPCFG
;Prueba_00.c,22 :: 		uart_rd = 70;
	MOV	#70, W0
	MOV	W0, _uart_rd
;Prueba_00.c,24 :: 		INTCON2bits.INT1EP = 1; //bit de selección para interrupcion externa # 1, flanco positivo
	BSET.B	INTCON2bits, #1
;Prueba_00.c,25 :: 		IFS1bits.INT1IF = 0;    // bandera de interrupción externa # 1
	BCLR.B	IFS1bits, #0
;Prueba_00.c,26 :: 		IEC1bits.INT1IE = 1;    // bit de habilitación de interrupción externa # 1
	BSET.B	IEC1bits, #0
;Prueba_00.c,28 :: 		TRISE = 0x0100; // PWM pins as outputs, and FLTA as input
	MOV	#256, W0
	MOV	WREG, TRISE
;Prueba_00.c,29 :: 		PTPER = (FCY/FPWM - 1) >> 1; // Compute Period for desired frequency
	MOV	#499, W0
	MOV	WREG, PTPER
;Prueba_00.c,30 :: 		OVDCON = 0x0000; // Disable all PWM outputs.
	CLR	OVDCON
;Prueba_00.c,31 :: 		DTCON1 = DEADTIME; // ~2 us of dead time @ 20 MIPS and 1:1 Prescaler
	MOV	#40, W0
	MOV	WREG, DTCON1
;Prueba_00.c,33 :: 		PWMCON1 = 0x0312; // Enable PWM output pins and enable complementary mode
	MOV	#786, W0
	MOV	WREG, PWMCON1
;Prueba_00.c,35 :: 		PDC1 = 850;  // ciclo de trabajo para el PWM1
	MOV	#850, W0
	MOV	WREG, PDC1
;Prueba_00.c,36 :: 		PDC2 = 850; // ciclo de trabajo para el PWM2
	MOV	#850, W0
	MOV	WREG, PDC2
;Prueba_00.c,37 :: 		OVDCON = 0x0F00; // PWM outputs are controller by PWM module
	MOV	#3840, W0
	MOV	WREG, OVDCON
;Prueba_00.c,38 :: 		PTCONbits.PTMOD = 0; // Center aligned PWM operation
	MOV	#lo_addr(PTCONbits), W0
	MOV.B	[W0], W1
	MOV.B	#252, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(PTCONbits), W0
	MOV.B	W1, [W0]
;Prueba_00.c,39 :: 		PTCONbits.PTEN = 1; // Start PWM
	BSET	PTCONbits, #15
;Prueba_00.c,41 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOV	#9600, W10
	MOV	#0, W11
	CALL	_UART1_Init
;Prueba_00.c,42 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOV	#3, W8
	MOV	#35594, W7
L_main0:
	DEC	W7
	BRA NZ	L_main0
	DEC	W8
	BRA NZ	L_main0
	NOP
;Prueba_00.c,45 :: 		do{
L_main2:
;Prueba_00.c,49 :: 		PORTB.RB1 = 1;
	BSET.B	PORTB, #1
;Prueba_00.c,50 :: 		delay_ms(100);    // 1 second delay
	MOV	#3, W8
	MOV	#35594, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	DEC	W8
	BRA NZ	L_main5
	NOP
;Prueba_00.c,51 :: 		PORTB.RB1 = 0;
	BCLR.B	PORTB, #1
;Prueba_00.c,52 :: 		delay_ms(100);    // 1   delay
	MOV	#3, W8
	MOV	#35594, W7
L_main7:
	DEC	W7
	BRA NZ	L_main7
	DEC	W8
	BRA NZ	L_main7
	NOP
;Prueba_00.c,53 :: 		if (UART_Data_Ready()) {     // If data is received,
	CALL	_UART_Data_Ready
	CP0	W0
	BRA NZ	L__main19
	GOTO	L_main9
L__main19:
;Prueba_00.c,54 :: 		uart_rd = UART_Read();     // read the received data,
	CALL	_UART_Read
	MOV	W0, _uart_rd
;Prueba_00.c,55 :: 		vel  = uart_rd*10;
	MOV	#10, W1
	MUL.UU	W0, W1, W0
	CLR	W1
	CALL	__Long2Float
	MOV	W0, _vel
	MOV	W1, _vel+2
;Prueba_00.c,56 :: 		corr = vel/100;
	MOV	#0, W2
	MOV	#17096, W3
	CALL	__Div_FP
	MOV	W0, _corr
	MOV	W1, _corr+2
;Prueba_00.c,66 :: 		PORTB.RB2 = 1;
	BSET.B	PORTB, #2
;Prueba_00.c,67 :: 		delay_ms(100);    // 1 second delay
	MOV	#3, W8
	MOV	#35594, W7
L_main10:
	DEC	W7
	BRA NZ	L_main10
	DEC	W8
	BRA NZ	L_main10
	NOP
;Prueba_00.c,68 :: 		PORTB.RB2 = 0;
	BCLR.B	PORTB, #2
;Prueba_00.c,69 :: 		delay_ms(100);
	MOV	#3, W8
	MOV	#35594, W7
L_main12:
	DEC	W7
	BRA NZ	L_main12
	DEC	W8
	BRA NZ	L_main12
	NOP
;Prueba_00.c,70 :: 		}
L_main9:
;Prueba_00.c,71 :: 		sprintf(txt,"VEL-1%4.3f,%4.3f", vel, corr);             // Format ww and store it to buffer
	PUSH	_corr
	PUSH	_corr+2
	PUSH	_vel
	PUSH	_vel+2
	MOV	#lo_addr(?lstr_1_Prueba_00), W0
	PUSH	W0
	MOV	#lo_addr(_txt), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#12, W15
;Prueba_00.c,72 :: 		UART1_Write_Text(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_UART1_Write_Text
;Prueba_00.c,73 :: 		delay_ms(200);
	MOV	#6, W8
	MOV	#5654, W7
L_main14:
	DEC	W7
	BRA NZ	L_main14
	DEC	W8
	BRA NZ	L_main14
;Prueba_00.c,74 :: 		UART1_Write_Text("\n");
	MOV	#lo_addr(?lstr2_Prueba_00), W10
	CALL	_UART1_Write_Text
;Prueba_00.c,75 :: 		}while(1);
	GOTO	L_main2
;Prueba_00.c,77 :: 		}
L_end_main:
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_interrupt_INT1:
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;Prueba_00.c,79 :: 		void interrupt_INT1() org 0x34
;Prueba_00.c,81 :: 		IFS1bits.INT1IF = 0;    // apago bandera bandera de interrupción externa # 1
	PUSH	W10
	BCLR.B	IFS1bits, #0
;Prueba_00.c,82 :: 		Vdelay_ms((unsigned int)corr);
	MOV	_corr, W0
	MOV	_corr+2, W1
	CALL	__Float2Longint
	MOV	W0, W10
	CALL	_VDelay_ms
;Prueba_00.c,83 :: 		PORTB.RB3 = 1;
	BSET.B	PORTB, #3
;Prueba_00.c,84 :: 		delay_us(200);
	MOV	#333, W7
L_interrupt_INT116:
	DEC	W7
	BRA NZ	L_interrupt_INT116
	NOP
;Prueba_00.c,85 :: 		PORTB.RB3 = 0;
	BCLR.B	PORTB, #3
;Prueba_00.c,87 :: 		}
L_end_interrupt_INT1:
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	RETFIE
; end of _interrupt_INT1
