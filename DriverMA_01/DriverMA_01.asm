
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;DriverMA_01.c,31 :: 		void main(){
;DriverMA_01.c,33 :: 		ADPCFG = 0x01FE;       // PORTB0 como analógico y PORTB1...PORTB7 como digital
	PUSH	W10
	PUSH	W11
	MOV	#510, W0
	MOV	WREG, ADPCFG
;DriverMA_01.c,34 :: 		TRISB = 0x0001;        // PORTB0 como entrada y PORTB1...PORTB7 como salidas  0 0000 0001
	MOV	#1, W0
	MOV	WREG, TRISB
;DriverMA_01.c,35 :: 		TRISE = 0x0100;        // Los pines PWM como salidas y  FLTA como entrada
	MOV	#256, W0
	MOV	WREG, TRISE
;DriverMA_01.c,36 :: 		config_INT_TMR1();
	CALL	_config_INT_TMR1
;DriverMA_01.c,37 :: 		config_MCPWM();
	CALL	_config_MCPWM
;DriverMA_01.c,38 :: 		UART2_Init(9600);               // Initialize UART module at 9600 bps
	MOV	#9600, W10
	MOV	#0, W11
	CALL	_UART2_Init
;DriverMA_01.c,39 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOV	#3, W8
	MOV	#35594, W7
L_main0:
	DEC	W7
	BRA NZ	L_main0
	DEC	W8
	BRA NZ	L_main0
	NOP
;DriverMA_01.c,40 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOV	#9600, W10
	MOV	#0, W11
	CALL	_UART1_Init
;DriverMA_01.c,41 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOV	#3, W8
	MOV	#35594, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
	NOP
;DriverMA_01.c,43 :: 		ref = 230.0;
	MOV	#0, W0
	MOV	#17254, W1
	MOV	W0, _ref
	MOV	W1, _ref+2
;DriverMA_01.c,45 :: 		do{
L_main4:
;DriverMA_01.c,47 :: 		PORTB.RB1 = 1;
	BSET.B	PORTB, #1
;DriverMA_01.c,48 :: 		Delay_ms(50);
	MOV	#2, W8
	MOV	#17796, W7
L_main7:
	DEC	W7
	BRA NZ	L_main7
	DEC	W8
	BRA NZ	L_main7
	NOP
	NOP
;DriverMA_01.c,49 :: 		PORTB.RB1 = 0;
	BCLR.B	PORTB, #1
;DriverMA_01.c,50 :: 		Delay_ms(50);
	MOV	#2, W8
	MOV	#17796, W7
L_main9:
	DEC	W7
	BRA NZ	L_main9
	DEC	W8
	BRA NZ	L_main9
	NOP
	NOP
;DriverMA_01.c,52 :: 		if (UART1_Data_Ready()== 1) {     // If data is received,
	CALL	_UART1_Data_Ready
	CP	W0, #1
	BRA Z	L__main35
	GOTO	L_main11
L__main35:
;DriverMA_01.c,53 :: 		uart_rd = UART1_Read();     // read the received data,
	CALL	_UART1_Read
	MOV	W0, _uart_rd
;DriverMA_01.c,54 :: 		if (uart_rd == 1){
	CP	W0, #1
	BRA Z	L__main36
	GOTO	L_main12
L__main36:
;DriverMA_01.c,55 :: 		PORTB.RB8 = 1;
	BSET	PORTB, #8
;DriverMA_01.c,56 :: 		PORTB.RB6 = 0;
	BCLR.B	PORTB, #6
;DriverMA_01.c,57 :: 		for(i=1; i<=10000000; i++){       // 10mm = ??? ms.....= (10mm * 200) / 35mm  = 57
	MOV	#1, W0
	MOV	W0, _i
L_main13:
	MOV	_i, W2
	ASR	W2, #15, W3
	MOV	#38528, W0
	MOV	#152, W1
	CP	W2, W0
	CPB	W3, W1
	BRA LE	L__main37
	GOTO	L_main14
L__main37:
;DriverMA_01.c,58 :: 		PORTB.RB7 = 1;
	BSET.B	PORTB, #7
;DriverMA_01.c,59 :: 		Delay_ms(10);
	MOV	#16666, W7
L_main16:
	DEC	W7
	BRA NZ	L_main16
	NOP
	NOP
;DriverMA_01.c,60 :: 		PORTB.RB7 = 0;
	BCLR.B	PORTB, #7
;DriverMA_01.c,61 :: 		sprintf(txt,"VEL-1%4.3f,%4.3f", Temperatura, error);
	PUSH	_error
	PUSH	_error+2
	PUSH	_Temperatura
	PUSH	_Temperatura+2
	MOV	#lo_addr(?lstr_1_DriverMA_01), W0
	PUSH	W0
	MOV	#lo_addr(_txt), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#12, W15
;DriverMA_01.c,62 :: 		UART1_Write_Text(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_UART1_Write_Text
;DriverMA_01.c,63 :: 		Delay_ms(10);
	MOV	#16666, W7
L_main18:
	DEC	W7
	BRA NZ	L_main18
	NOP
	NOP
;DriverMA_01.c,64 :: 		UART1_Write_Text("\n");
	MOV	#lo_addr(?lstr2_DriverMA_01), W10
	CALL	_UART1_Write_Text
;DriverMA_01.c,57 :: 		for(i=1; i<=10000000; i++){       // 10mm = ??? ms.....= (10mm * 200) / 35mm  = 57
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;DriverMA_01.c,65 :: 		}
	GOTO	L_main13
L_main14:
;DriverMA_01.c,66 :: 		}
L_main12:
;DriverMA_01.c,67 :: 		if (uart_rd == 0){
	MOV	_uart_rd, W0
	CP	W0, #0
	BRA Z	L__main38
	GOTO	L_main20
L__main38:
;DriverMA_01.c,68 :: 		PORTB.RB8 = 0;
	BCLR	PORTB, #8
;DriverMA_01.c,69 :: 		PORTB.RB6 = 0;
	BCLR.B	PORTB, #6
;DriverMA_01.c,70 :: 		for(i=1; i<=50; i++){       // 10mm = ??? ms.....= (10mm * 200) / 35mm  = 57
	MOV	#1, W0
	MOV	W0, _i
L_main21:
	MOV	#50, W1
	MOV	#lo_addr(_i), W0
	CP	W1, [W0]
	BRA GE	L__main39
	GOTO	L_main22
L__main39:
;DriverMA_01.c,71 :: 		PORTB.RB7 = 1;
	BSET.B	PORTB, #7
;DriverMA_01.c,72 :: 		Delay_ms(10);
	MOV	#16666, W7
L_main24:
	DEC	W7
	BRA NZ	L_main24
	NOP
	NOP
;DriverMA_01.c,73 :: 		PORTB.RB7 = 0;
	BCLR.B	PORTB, #7
;DriverMA_01.c,74 :: 		Delay_ms(10);
	MOV	#16666, W7
L_main26:
	DEC	W7
	BRA NZ	L_main26
	NOP
	NOP
;DriverMA_01.c,75 :: 		sprintf(txt,"VEL-1%4.3f,%4.3f", Temperatura, error);
	PUSH	_error
	PUSH	_error+2
	PUSH	_Temperatura
	PUSH	_Temperatura+2
	MOV	#lo_addr(?lstr_3_DriverMA_01), W0
	PUSH	W0
	MOV	#lo_addr(_txt), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#12, W15
;DriverMA_01.c,76 :: 		UART1_Write_Text(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_UART1_Write_Text
;DriverMA_01.c,77 :: 		UART1_Write_Text("\n");
	MOV	#lo_addr(?lstr4_DriverMA_01), W10
	CALL	_UART1_Write_Text
;DriverMA_01.c,70 :: 		for(i=1; i<=50; i++){       // 10mm = ??? ms.....= (10mm * 200) / 35mm  = 57
	MOV	#1, W1
	MOV	#lo_addr(_i), W0
	ADD	W1, [W0], [W0]
;DriverMA_01.c,78 :: 		}
	GOTO	L_main21
L_main22:
;DriverMA_01.c,79 :: 		}
L_main20:
;DriverMA_01.c,80 :: 		if (uart_rd == 9){
	MOV	_uart_rd, W0
	CP	W0, #9
	BRA Z	L__main40
	GOTO	L_main28
L__main40:
;DriverMA_01.c,81 :: 		PORTB.RB6 = 1;
	BSET.B	PORTB, #6
;DriverMA_01.c,82 :: 		}
	GOTO	L_main29
L_main28:
;DriverMA_01.c,85 :: 		PORTB.RB6 = 0;
	BCLR.B	PORTB, #6
;DriverMA_01.c,86 :: 		}
L_main29:
;DriverMA_01.c,87 :: 		uart_rd = 9;
	MOV	#9, W0
	MOV	W0, _uart_rd
;DriverMA_01.c,91 :: 		}
L_main11:
;DriverMA_01.c,93 :: 		sprintf(txt,"VEL-1%4.3f,%4.3f", Temperatura, error);
	PUSH	_error
	PUSH	_error+2
	PUSH	_Temperatura
	PUSH	_Temperatura+2
	MOV	#lo_addr(?lstr_5_DriverMA_01), W0
	PUSH	W0
	MOV	#lo_addr(_txt), W0
	PUSH	W0
	CALL	_sprintf
	SUB	#12, W15
;DriverMA_01.c,94 :: 		UART1_Write_Text(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_UART1_Write_Text
;DriverMA_01.c,95 :: 		Delay_ms(10);
	MOV	#16666, W7
L_main30:
	DEC	W7
	BRA NZ	L_main30
	NOP
	NOP
;DriverMA_01.c,96 :: 		UART1_Write_Text("\n");
	MOV	#lo_addr(?lstr6_DriverMA_01), W10
	CALL	_UART1_Write_Text
;DriverMA_01.c,98 :: 		}while(1);
	GOTO	L_main4
;DriverMA_01.c,100 :: 		}
L_end_main:
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_config_INT_TMR1:

;DriverMA_01.c,102 :: 		void   config_INT_TMR1(void){
;DriverMA_01.c,104 :: 		T1CON = 0x0000;        // se desactiva el timer 1 y se reinicia al registro de control
	CLR	T1CON
;DriverMA_01.c,105 :: 		TMR1  = 0;             // se limpia el contenido del registro del timer 1
	CLR	TMR1
;DriverMA_01.c,106 :: 		PR1   = 0x9362;        // se carga 0xFFFF al registro de perido del timer 1  t = 7ms aprox    9362
	MOV	#37730, W0
	MOV	WREG, PR1
;DriverMA_01.c,107 :: 		IPC0bits.T1IP0 = 1;    // se establece como nivel de prioridad 1
	BSET	IPC0bits, #12
;DriverMA_01.c,108 :: 		IPC0bits.T1IP1 = 0;    // las interrupciones del TMR1
	BCLR	IPC0bits, #13
;DriverMA_01.c,109 :: 		IPC0bits.T1IP2 = 0;    // T1IP = 0x001
	BCLR	IPC0bits, #14
;DriverMA_01.c,110 :: 		IFS0bits.T1IF  = 0;    // se limpia bandera de interrupcion de TMR1
	BCLR.B	IFS0bits, #3
;DriverMA_01.c,111 :: 		IEC0bits.T1IE  = 1;    // se habilita las interrupciones para TMR1
	BSET.B	IEC0bits, #3
;DriverMA_01.c,112 :: 		T1CONbits.TON  = 1;    // se activa el timer 1 con prescalador 1:1 y
	BSET	T1CONbits, #15
;DriverMA_01.c,115 :: 		}
L_end_config_INT_TMR1:
	RETURN
; end of _config_INT_TMR1

_config_MCPWM:

;DriverMA_01.c,117 :: 		void  config_MCPWM(void){
;DriverMA_01.c,118 :: 		PTPER = 24991;         //(FCY/FPWM - 1) >> 1, 5M / 200Hz - 1 =  24991
	MOV	#24991, W0
	MOV	WREG, PTPER
;DriverMA_01.c,119 :: 		OVDCON = 0x0000;       // se desactivan todas las señales PWM
	CLR	OVDCON
;DriverMA_01.c,120 :: 		DTCON1 = 0x0000;       // ~2 us of dead time @ 20 MIPS and 1:1 Prescaler
	CLR	DTCON1
;DriverMA_01.c,121 :: 		PWMCON1 = 0x0111;      // se activa L1 y en modo independiente
	MOV	#273, W0
	MOV	WREG, PWMCON1
;DriverMA_01.c,122 :: 		PDC1 = 50000;          // ciclo de trabajo para el PWM1(100% = 50000)
	MOV	#50000, W0
	MOV	WREG, PDC1
;DriverMA_01.c,123 :: 		OVDCON = 0x0F00;       // las salidas E0,E1,E2,E3 son controladas por el generador PWM
	MOV	#3840, W0
	MOV	WREG, OVDCON
;DriverMA_01.c,124 :: 		PTCONbits.PTMOD = 0;   // la base de tiempo PWM funciona en modo libre
	MOV	#lo_addr(PTCONbits), W0
	MOV.B	[W0], W1
	MOV.B	#252, W0
	AND.B	W1, W0, W1
	MOV	#lo_addr(PTCONbits), W0
	MOV.B	W1, [W0]
;DriverMA_01.c,125 :: 		PTCONbits.PTEN = 1;    // se activa el generador PWM
	BSET	PTCONbits, #15
;DriverMA_01.c,126 :: 		}
L_end_config_MCPWM:
	RETURN
; end of _config_MCPWM

_interrupt_T1:
	LNK	#8
	PUSH	52
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;DriverMA_01.c,128 :: 		void interrupt_T1() org 0x1A
;DriverMA_01.c,130 :: 		IFS0bits.T1IF  = 0;                    // se limpia bandera de interrupcion de TMR1
	PUSH	W10
	PUSH	W11
	BCLR.B	IFS0bits, #3
;DriverMA_01.c,131 :: 		Vo = ADC1_Read(0);                    // lectura de AN0
	CLR	W10
	CALL	_ADC1_Read
	MOV	W0, _Vo
;DriverMA_01.c,132 :: 		R1 = R2 * (1023.0 / (float)Vo - 1.0); // conversión de voltaje a resistencia
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV.D	W0, W2
	MOV	#49152, W0
	MOV	#17535, W1
	CALL	__Div_FP
	MOV	#0, W2
	MOV	#16256, W3
	CALL	__Sub_FP
	MOV	_R2, W2
	MOV	_R2+2, W3
	CALL	__Mul_FP
	MOV	W0, _R1
	MOV	W1, _R1+2
;DriverMA_01.c,133 :: 		logR1 = log(R1);                      // logaritmo de R1 necesario para ecuacion
	MOV.D	W0, W10
	CALL	_log
	MOV	W0, _logR1
	MOV	W1, _logR1+2
;DriverMA_01.c,134 :: 		Temperatura = (1.0 / (c1 + c2*logR1 + c3*logR1*logR1*logR1));
	MOV	_c2, W2
	MOV	_c2+2, W3
	CALL	__Mul_FP
	MOV	_c1, W2
	MOV	_c1+2, W3
	CALL	__AddSub_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_c3, W0
	MOV	_c3+2, W1
	MOV	_logR1, W2
	MOV	_logR1+2, W3
	CALL	__Mul_FP
	MOV	_logR1, W2
	MOV	_logR1+2, W3
	CALL	__Mul_FP
	MOV	_logR1, W2
	MOV	_logR1+2, W3
	CALL	__Mul_FP
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__AddSub_FP
	MOV.D	W0, W2
	MOV	#0, W0
	MOV	#16256, W1
	CALL	__Div_FP
	MOV	W0, _Temperatura
	MOV	W1, _Temperatura+2
;DriverMA_01.c,136 :: 		Temperatura = Temperatura - 273.15;   // conversión de Kelvin a Centigrados (Celsius)
	MOV	#37683, W2
	MOV	#17288, W3
	CALL	__Sub_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	PUSH.D	W0
	MOV	[W14+0], W0
	MOV	[W14+2], W1
	MOV	W0, _Temperatura
	MOV	W1, _Temperatura+2
	POP.D	W0
;DriverMA_01.c,138 :: 		error = ref - Temperatura;            // calculo del error
	MOV	_ref, W0
	MOV	_ref+2, W1
	PUSH.D	W2
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Sub_FP
	POP.D	W2
	MOV	W0, _error
	MOV	W1, _error+2
;DriverMA_01.c,139 :: 		error = abs(error);                   // se obtiene el valor absoluto de el error
	CALL	__Float2Longint
	MOV	W0, W10
	CALL	_abs
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _error
	MOV	W1, _error+2
;DriverMA_01.c,141 :: 		mkt   = error*kp;
	MOV	_kp, W2
	MOV	_kp+2, W3
	CALL	__Mul_FP
	MOV	W0, _mkt
	MOV	W1, _mkt+2
;DriverMA_01.c,142 :: 		pkt   = error*ki + pkt_ant;
	MOV	_error, W0
	MOV	_error+2, W1
	MOV	_ki, W2
	MOV	_ki+2, W3
	CALL	__Mul_FP
	MOV	_pkt_ant, W2
	MOV	_pkt_ant+2, W3
	CALL	__AddSub_FP
	MOV	W0, _pkt
	MOV	W1, _pkt+2
;DriverMA_01.c,143 :: 		qkt   = error*kd - error_ant*kd;
	MOV	_error, W0
	MOV	_error+2, W1
	MOV	_kd, W2
	MOV	_kd+2, W3
	CALL	__Mul_FP
	MOV	W0, [W14+4]
	MOV	W1, [W14+6]
	MOV	_error_ant, W0
	MOV	_error_ant+2, W1
	MOV	_kd, W2
	MOV	_kd+2, W3
	CALL	__Mul_FP
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	[W14+4], W0
	MOV	[W14+6], W1
	PUSH.D	W2
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Sub_FP
	POP.D	W2
	MOV	W0, _qkt
	MOV	W1, _qkt+2
;DriverMA_01.c,144 :: 		ukt   = (int)floor(mkt + pkt + qkt);  // devuelve el valor del parámetro x redondeado
	MOV	_mkt, W2
	MOV	_mkt+2, W3
	MOV	_pkt, W0
	MOV	_pkt+2, W1
	CALL	__AddSub_FP
	MOV	_qkt, W2
	MOV	_qkt+2, W3
	CALL	__AddSub_FP
	MOV.D	W0, W10
	CALL	_floor
	CALL	__Float2Longint
	ASR	W0, #15, W1
	SETM	W2
	CALL	__Long2Float
	MOV	W0, _ukt
	MOV	W1, _ukt+2
;DriverMA_01.c,147 :: 		error_ant  = error;                   // actulizacion del error
	MOV	_error, W2
	MOV	_error+2, W3
	MOV	W2, _error_ant
	MOV	W3, _error_ant+2
;DriverMA_01.c,148 :: 		pkt_ant    = pkt;
	MOV	_pkt, W2
	MOV	_pkt+2, W3
	MOV	W2, _pkt_ant
	MOV	W3, _pkt_ant+2
;DriverMA_01.c,151 :: 		if(ukt <= 0){
	CLR	W2
	CLR	W3
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GT	L__interrupt_T145
	INC.B	W0
L__interrupt_T145:
	CP0.B	W0
	BRA NZ	L__interrupt_T146
	GOTO	L_interrupt_T132
L__interrupt_T146:
;DriverMA_01.c,152 :: 		ukt= 0;
	CLR	W0
	CLR	W1
	MOV	W0, _ukt
	MOV	W1, _ukt+2
;DriverMA_01.c,153 :: 		}
L_interrupt_T132:
;DriverMA_01.c,154 :: 		if(ukt >= 30000){
	MOV	#24576, W2
	MOV	#18154, W3
	MOV	_ukt, W0
	MOV	_ukt+2, W1
	CALL	__Compare_Ge_Fp
	CP0	W0
	CLR.B	W0
	BRA LT	L__interrupt_T147
	INC.B	W0
L__interrupt_T147:
	CP0.B	W0
	BRA NZ	L__interrupt_T148
	GOTO	L_interrupt_T133
L__interrupt_T148:
;DriverMA_01.c,155 :: 		ukt= 30000;
	MOV	#24576, W0
	MOV	#18154, W1
	MOV	W0, _ukt
	MOV	W1, _ukt+2
;DriverMA_01.c,156 :: 		}
L_interrupt_T133:
;DriverMA_01.c,158 :: 		PDC1 = 30000 - ukt;    //50 000       200 40000 kp 100 kd 50  ***** 100 45000 kp 200 kd 100
	MOV	#24576, W0
	MOV	#18154, W1
	MOV	_ukt, W2
	MOV	_ukt+2, W3
	CALL	__Sub_FP
	CALL	__Float2Longint
	MOV	WREG, PDC1
;DriverMA_01.c,160 :: 		}
L_end_interrupt_T1:
	POP	W11
	POP	W10
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	POP	52
	ULNK
	RETFIE
; end of _interrupt_T1
