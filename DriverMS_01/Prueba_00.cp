#line 1 "C:/Users/molot/Documents/Doctorado/3.Semestre2022-1/Programas/MikroC pro for dsPIC/Prueba_00.c"






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

 INTCON2bits.INT1EP = 1;
 IFS1bits.INT1IF = 0;
 IEC1bits.INT1IE = 1;

 TRISE = 0x0100;
 PTPER = ( 20000000 / 20000  - 1) >> 1;
 OVDCON = 0x0000;
 DTCON1 =  (unsigned int)(0.000002 * 20000000 ) ;

 PWMCON1 = 0x0312;

 PDC1 = 850;
 PDC2 = 850;
 OVDCON = 0x0F00;
 PTCONbits.PTMOD = 0;
 PTCONbits.PTEN = 1;

 UART1_Init(9600);
 Delay_ms(100);


 do{



 PORTB.RB1 = 1;
 delay_ms(100);
 PORTB.RB1 = 0;
 delay_ms(100);
 if (UART_Data_Ready()) {
 uart_rd = UART_Read();
 vel = uart_rd*10;
 corr = vel/100;
#line 66 "C:/Users/molot/Documents/Doctorado/3.Semestre2022-1/Programas/MikroC pro for dsPIC/Prueba_00.c"
 PORTB.RB2 = 1;
 delay_ms(100);
 PORTB.RB2 = 0;
 delay_ms(100);
 }
 sprintf(txt,"VEL-1%4.3f,%4.3f", vel, corr);
 UART1_Write_Text(txt);
 delay_ms(200);
 UART1_Write_Text("\n");
 }while(1);

}

void interrupt_INT1() org 0x34
{
 IFS1bits.INT1IF = 0;
 Vdelay_ms((unsigned int)corr);
 PORTB.RB3 = 1;
 delay_us(200);
 PORTB.RB3 = 0;

}
