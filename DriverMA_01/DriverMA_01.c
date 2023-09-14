
//**************************** Declaración de variables y funciones **************************************
int Vo, i, j=0;
int E = 0, D = 0;            // voltaje en la resitencia R2
float Tem, logR1, R1, Temperatura, R2 = 100;  // R2 resistencia fija del divisor de tension
//float c1=0.65259009683e-3, c2=2.42005479608e-4, c3=3.63568632226e-8;  fformula
//float c1=0.7033206270e-3, c2=2.147745199e-4, c3=1.229510569e-7; // 100 125 155
//float c1=0.8647575583e-3, c2=1.833944308e-4, c3=3.034025960e-7;   // 150 180  210
//float c1=0.9305567436e-3, c2=1.724360081e-4, c3=3.347975267e-7;   // 155 185  195
//float c1=1.136589301e-3, c2=1.179977717e-4, c3=8.644629618e-7;   // 185 205  225
float c1=0.7976028588e-3, c2=2.017136122e-4, c3=1.104162098e-7;   // 205 225  245
//float c1=2.114990448e-3, c2=0.3832381228e-4, c3=5.228061052e-7;  // coeficientes de S-H en pagina:
/*https://www.thinksrs.com/downloads/programs/therm%20calc/ntccalibrator/ntccalculator.html*/
float  error, mkt, pkt, qkt, ukt, pkt_ant, error_ant, ref, kp=160, kd=40, ki=0;    //160 y 40
unsigned uart_rd;
char txt[15]= {0};
char txt0[15]= {0};
char txt1[10]= {0};
char txt2[10]= {0};
char txt3[10]= {0};
char txt4[10]= {0};



void   config_INT_TMR1(void);
void   config_MCPWM(void);
void   interrupt_T1(void);

//************************************** Programa principal *********************************************

void main(){

ADPCFG = 0x01FE;       // PORTB0 como analógico y PORTB1...PORTB7 como digital
TRISB = 0x0001;        // PORTB0 como entrada y PORTB1...PORTB7 como salidas  0 0000 0001
TRISE = 0x0100;        // Los pines PWM como salidas y  FLTA como entrada
config_INT_TMR1();
config_MCPWM();
UART2_Init(9600);               // Initialize UART module at 9600 bps
Delay_ms(100);                  // Wait for UART module to stabilize
UART1_Init(9600);               // Initialize UART module at 9600 bps
Delay_ms(100);                  // Wait for UART module to stabilize

ref = 230.0;

do{

  PORTB.RB1 = 1;
  Delay_ms(50);
  PORTB.RB1 = 0;
  Delay_ms(50);

  if (UART1_Data_Ready()== 1) {     // If data is received,
     uart_rd = UART1_Read();     // read the received data,
     if (uart_rd == 1){
         PORTB.RB8 = 1;
         PORTB.RB6 = 0;
         for(i=1; i<=10000000; i++){       // 10mm = ??? ms.....= (10mm * 200) / 35mm  = 57
            PORTB.RB7 = 1;
            Delay_ms(10);
            PORTB.RB7 = 0;
            sprintf(txt,"VEL-1%4.3f,%4.3f", Temperatura, error);
            UART1_Write_Text(txt);
            Delay_ms(10);
            UART1_Write_Text("\n");
         }
     }
     if (uart_rd == 0){
         PORTB.RB8 = 0;
         PORTB.RB6 = 0;
         for(i=1; i<=50; i++){       // 10mm = ??? ms.....= (10mm * 200) / 35mm  = 57
             PORTB.RB7 = 1;
             Delay_ms(10);
             PORTB.RB7 = 0;
             Delay_ms(10);
             sprintf(txt,"VEL-1%4.3f,%4.3f", Temperatura, error);
             UART1_Write_Text(txt);
             UART1_Write_Text("\n");
         }
     }
     if (uart_rd == 9){
          PORTB.RB6 = 1;
     }
     else{
          //ref =  uart_rd;
          PORTB.RB6 = 0;
     }
     uart_rd = 9;
    //Tem  = uart_rd*10;
    //corr = vel/100;

  }
  
  sprintf(txt,"VEL-1%4.3f,%4.3f", Temperatura, error);
  UART1_Write_Text(txt);
  Delay_ms(10);
  UART1_Write_Text("\n");

}while(1);

}

void   config_INT_TMR1(void){

    T1CON = 0x0000;        // se desactiva el timer 1 y se reinicia al registro de control
    TMR1  = 0;             // se limpia el contenido del registro del timer 1
    PR1   = 0x9362;        // se carga 0xFFFF al registro de perido del timer 1  t = 7ms aprox    9362
    IPC0bits.T1IP0 = 1;    // se establece como nivel de prioridad 1
    IPC0bits.T1IP1 = 0;    // las interrupciones del TMR1
    IPC0bits.T1IP2 = 0;    // T1IP = 0x001
    IFS0bits.T1IF  = 0;    // se limpia bandera de interrupcion de TMR1
    IEC0bits.T1IE  = 1;    // se habilita las interrupciones para TMR1
    T1CONbits.TON  = 1;    // se activa el timer 1 con prescalador 1:1 y
                           // la fuente de reloj se establece con ciclo
                           // de instrucción interno.
}

void  config_MCPWM(void){
    PTPER = 24991;         //(FCY/FPWM - 1) >> 1, 5M / 200Hz - 1 =  24991
    OVDCON = 0x0000;       // se desactivan todas las señales PWM
    DTCON1 = 0x0000;       // ~2 us of dead time @ 20 MIPS and 1:1 Prescaler
    PWMCON1 = 0x0111;      // se activa L1 y en modo independiente
    PDC1 = 50000;          // ciclo de trabajo para el PWM1(100% = 50000)
    OVDCON = 0x0F00;       // las salidas E0,E1,E2,E3 son controladas por el generador PWM
    PTCONbits.PTMOD = 0;   // la base de tiempo PWM funciona en modo libre
    PTCONbits.PTEN = 1;    // se activa el generador PWM
}

void interrupt_T1() org 0x1A
{
  IFS0bits.T1IF  = 0;                    // se limpia bandera de interrupcion de TMR1
  Vo = ADC1_Read(0);                    // lectura de AN0
  R1 = R2 * (1023.0 / (float)Vo - 1.0); // conversión de voltaje a resistencia
  logR1 = log(R1);                      // logaritmo de R1 necesario para ecuacion
  Temperatura = (1.0 / (c1 + c2*logR1 + c3*logR1*logR1*logR1));
                                        // ecuacion de Steinhart-Hart
  Temperatura = Temperatura - 273.15;   // conversión de Kelvin a Centigrados (Celsius)
  
  error = ref - Temperatura;            // calculo del error
  error = abs(error);                   // se obtiene el valor absoluto de el error
  
  mkt   = error*kp;
  pkt   = error*ki + pkt_ant;
  qkt   = error*kd - error_ant*kd;
  ukt   = (int)floor(mkt + pkt + qkt);  // devuelve el valor del parámetro x redondeado
                                           // al entero inferior más próximo.

  error_ant  = error;                   // actulizacion del error
  pkt_ant    = pkt;
     //ukt_ajust  = ukt*kajust;
     //ukt_ajust  = (int)floor(ukt_ajust); //convierte a entero y lo trunca
  if(ukt <= 0){
  ukt= 0;
  }
  if(ukt >= 30000){
  ukt= 30000;
  }
  
  PDC1 = 30000 - ukt;    //50 000       200 40000 kp 100 kd 50  ***** 100 45000 kp 200 kd 100
 
}