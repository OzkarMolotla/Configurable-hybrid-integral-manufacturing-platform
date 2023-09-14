#line 1 "C:/Users/molot/Documents/Doctorado/5.Semestre2023-1/Microstepping/MikroC @ dsPIC/DriverMA_01/DriverMA_01.c"


int Vo, i, j=0;
int E = 0, D = 0;
float Tem, logR1, R1, Temperatura, R2 = 100;





float c1=0.7976028588e-3, c2=2.017136122e-4, c3=1.104162098e-7;


float error, mkt, pkt, qkt, ukt, pkt_ant, error_ant, ref, kp=160, kd=40, ki=0;
unsigned uart_rd;
char txt[15]= {0};
char txt0[15]= {0};
char txt1[10]= {0};
char txt2[10]= {0};
char txt3[10]= {0};
char txt4[10]= {0};



void config_INT_TMR1(void);
void config_MCPWM(void);
void interrupt_T1(void);



void main(){

ADPCFG = 0x01FE;
TRISB = 0x0001;
TRISE = 0x0100;
config_INT_TMR1();
config_MCPWM();
UART2_Init(9600);
Delay_ms(100);
UART1_Init(9600);
Delay_ms(100);

ref = 230.0;

do{

 PORTB.RB1 = 1;
 Delay_ms(50);
 PORTB.RB1 = 0;
 Delay_ms(50);

 if (UART1_Data_Ready()== 1) {
 uart_rd = UART1_Read();
 if (uart_rd == 1){
 PORTB.RB8 = 1;
 PORTB.RB6 = 0;
 for(i=1; i<=10000000; i++){
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
 for(i=1; i<=50; i++){
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

 PORTB.RB6 = 0;
 }
 uart_rd = 9;



 }

 sprintf(txt,"VEL-1%4.3f,%4.3f", Temperatura, error);
 UART1_Write_Text(txt);
 Delay_ms(10);
 UART1_Write_Text("\n");

}while(1);

}

void config_INT_TMR1(void){

 T1CON = 0x0000;
 TMR1 = 0;
 PR1 = 0x9362;
 IPC0bits.T1IP0 = 1;
 IPC0bits.T1IP1 = 0;
 IPC0bits.T1IP2 = 0;
 IFS0bits.T1IF = 0;
 IEC0bits.T1IE = 1;
 T1CONbits.TON = 1;


}

void config_MCPWM(void){
 PTPER = 24991;
 OVDCON = 0x0000;
 DTCON1 = 0x0000;
 PWMCON1 = 0x0111;
 PDC1 = 50000;
 OVDCON = 0x0F00;
 PTCONbits.PTMOD = 0;
 PTCONbits.PTEN = 1;
}

void interrupt_T1() org 0x1A
{
 IFS0bits.T1IF = 0;
 Vo = ADC1_Read(0);
 R1 = R2 * (1023.0 / (float)Vo - 1.0);
 logR1 = log(R1);
 Temperatura = (1.0 / (c1 + c2*logR1 + c3*logR1*logR1*logR1));

 Temperatura = Temperatura - 273.15;

 error = ref - Temperatura;
 error = abs(error);

 mkt = error*kp;
 pkt = error*ki + pkt_ant;
 qkt = error*kd - error_ant*kd;
 ukt = (int)floor(mkt + pkt + qkt);


 error_ant = error;
 pkt_ant = pkt;


 if(ukt <= 0){
 ukt= 0;
 }
 if(ukt >= 30000){
 ukt= 30000;
 }

 PDC1 = 30000 - ukt;

}
