#define FCY 20000000 // 20 MIPS
#define FPWM 20000 // 20 kHz
#define DEADTIME (unsigned int)(0.000002 * FCY)

//void InitINT1(void);     Interrupcion externa numero 1 en RD0  0x000034

float y;
float x;
float vel;
float corr;
unsigned uart_rd;
int cont_0 = 0, cont_1;
char txt[30]= {0};
float RPM = 0;

void main(){
  PORTB = 0x0000;
  TRISB = 0x0001;
  PORTD = 0x0000;
  TRISD = 0x0001;
  ADPCFG = 0x01FF;
  uart_rd = 70;

  INTCON2bits.INT1EP = 1; //bit de selección para interrupcion externa # 1, flanco positivo
  IFS1bits.INT1IF = 0;    // bandera de interrupción externa # 1
  IEC1bits.INT1IE = 1;    // bit de habilitación de interrupción externa # 1

  TRISE = 0x0100; // PWM pins as outputs, and FLTA as input
  PTPER = (FCY/FPWM - 1) >> 1; // Compute Period for desired frequency
  OVDCON = 0x0000; // Disable all PWM outputs.
  DTCON1 = DEADTIME; // ~2 us of dead time @ 20 MIPS and 1:1 Prescaler
  //PWMCON1 = 0x0333; // Enable PWM output pins and enable complementary mode
  PWMCON1 = 0x0312; // Enable PWM output pins and enable complementary mode
  //PWMCON1 = 0x0321; // Enable PWM output pins and enable complementary mode
  PDC1 = 850;  // ciclo de trabajo para el PWM1
  PDC2 = 850; // ciclo de trabajo para el PWM2
  OVDCON = 0x0F00; // PWM outputs are controller by PWM module
  PTCONbits.PTMOD = 0; // Center aligned PWM operation
  PTCONbits.PTEN = 1; // Start PWM
 // ADC1_Init();
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize


 do{
   //y = ADC1_Read(0);
    //x = ADC1_Read(0)/40;

    PORTB.RB1 = 1;
    delay_ms(100);    // 1 second delay
    PORTB.RB1 = 0;
    delay_ms(100);    // 1   delay
     if (UART_Data_Ready()) {     // If data is received,
       uart_rd = UART_Read();     // read the received data,
       vel  = uart_rd*10;
       corr = vel/100;
      if(uart_rd == 1){
         PWMCON1 = 0x0321; // Enable PWM output pins and enable complementary mode
       }
       else{
       PDC1 = uart_rd*10;  // ciclo de trabajo para el PWM1
       PDC2 = uart_rd*10; // ciclo de trabajo para el PWM2
       vel  = uart_rd*10;
       corr = vel/400;
       }
       PORTB.RB2 = 1;
       delay_ms(100);    // 1 second delay
       PORTB.RB2 = 0;
       delay_ms(100);
     }
     sprintf(txt,"VEL-1%4.3f,%4.3f", vel, corr);             // Format ww and store it to buffer
     UART1_Write_Text(txt);
     delay_ms(200);
     UART1_Write_Text("\n");
   }while(1);
   
}

void interrupt_INT1() org 0x34
{
  IFS1bits.INT1IF = 0;    // apago bandera bandera de interrupción externa # 1
  Vdelay_ms((unsigned int)corr);
  PORTB.RB3 = 1;
  delay_us(200);
  PORTB.RB3 = 0;

}