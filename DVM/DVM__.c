#include <mega8.h>      
#include <stdlib.h>                            
#include <string.h>               
#include <DELAY.h>               

//methods prototype

void PrintToSevenSegment(int number);
void delay(int n);

//global varibles
                 
int vOUT=0;
unsigned int states=0;

//Interrupts ISRs
interrupt [ADC_INT] void adc_isr(void)
{
	unsigned int adc_data = 0;
	adc_data=ADCW;           

	if(adc_data>0)
	{
        vOUT  = ((adc_data*5.00)/1023)*100;
        PrintToSevenSegment(vOUT);
        //delay_ms(2);
	}
	else
		PrintToSevenSegment(0);
	ADMUX=0x00;
	//Start Next Conversion
	ADCSRA =ADCSRA | 0x40;  
}


void main(void)
{                                           
	//make pord D as output.
	//Port D is used for 7 Segment Display
	DDRD=0xFF;
	//make pord b as output.
	//port B is used for relays control
	DDRB =0xFF;  
	//ADC Input is channel 0               
	ADMUX = 0x00;           
 	ADCSRA =0xCE;
  	//Enbale interrupts
        #asm("sei")
	while(1)
	{
		if (vOUT>=248 & states==0)
		{
		       	//PORTB.6=0x0;
                }
       	        else
              	{
		  	if(vOUT<=207)
		  	{
	       			states+=1;
	       			switch(states){
	       			case 1:
	       			{                        
	       				delay_ms(100);
	       			        PORTB=0b00000001;
	       				break;
	       			}
	       			case 2:
	       			{
	       				delay_ms(100);     
	       			        PORTB=0b00000010;
	       				break;
	       			}
	       			case 3:
	       			{     
	       				delay_ms(100);
	       			        PORTB=0b00000011;
	       				break;
	       			}
	       			case 4:
	       			{     
	       				delay_ms(100);
	       			        PORTB=0b00000100;
	       				break;
	       			}
	       			case 5:
	       			{     
	       				delay_ms(100);
	       			        PORTB=0b00000101;
	       				break;
	       			}
	       			case 6:
	       			{
	       				delay_ms(100);
	       				PORTB=0b00000110;
	       				break;
	       			}
	       			case 7:
	       			{
	       				delay_ms(100);
		       			PORTB=0b00000111;
		       			break;
	       			}	
	       			default:
	       			{
	       				delay_ms(100);
	       				PORTB = 0b00000111;
	       			}
	       			}
				
			}
  			if(vOUT>=233)
		  	{
  			  states-=1;  	
  			  switch(states){
	       			case 1:
	       			{     
	       				delay_ms(100);
	       			        PORTB=0b00000001;
	       				break;
	       			}
	       			case 2:
	       			{     
	       				delay_ms(100);
	       			        PORTB=0b00000010;
	       				break;
	       			}
	       			case 3:
	       			{     
	       				delay_ms(100);
	       			        PORTB=0b00000011;
	       				break;
	       			}
	       			case 4:
	       			{     
	       				delay_ms(100);
	       			        PORTB=0b00000100;
	       				break;
	       			}
	       			case 5:
	       			{     
	       				delay_ms(100);
	       			        PORTB=0b00000101;
	       				break;
	       			}
	       			case 6:
	       			{
	       				delay_ms(100);
	       				PORTB=0b00000110;
	       				break;
	       			}
	       			case 7:
	       			{
	       				delay_ms(100);
		       			PORTB=0b00000111;
		       			break;
	       			}	
	       			default:
	       			{
	       				PORTB = 0b00000000;
	       			}
	       			}
	  		}
	  			
  		       	//PORTC.6=0x1;
  		     }
	};
}

//Methods definations
int q=0;
void PrintToSevenSegment(int number)
{       for(q=0;q<5;q++){
	//Extract the digits from the int number
	int hund, rem, ten, one;                   
        hund = number/100;
        rem=number%100;
        ten = rem/10;
        one = rem%10;                                                      
        
        //Display the hundreds digit on Port D
	if(hund ==1)
	       	PORTD = 0x11;
	else if (hund == 2 )
		PORTD = 0x12;
	else if (hund == 3 )
		PORTD = 0x13;
	else if (hund == 4 )
		PORTD = 0x14;
	else if (hund == 5 )
		PORTD = 0x15;
	else if (hund == 6 )
		PORTD = 0x16;
	else if (hund == 7 )
		PORTD = 0x17;
	else if (hund == 8 )
		PORTD = 0x18;
	else if (hund == 9 )
		PORTD = 0x19;
	else if (hund == 0 )
		PORTD = 0x10;
	delay_ms(1);
        
        //Display the tens digit on Port D  	
        if(ten == 1 )
		PORTD = 0x21;
	else if (ten == 2 )
		PORTD = 0x22;
	else if (ten == 3 )
		PORTD = 0x23;
	else if (ten == 4 )
	 	PORTD = 0x24;
	else if (ten == 5 )
		PORTD = 0x25;
	else if (ten == 6 )
		PORTD = 0x26;
	else if (ten == 7 )
		PORTD = 0x27;
	else if (ten == 8 )
		PORTD = 0x28;
	else if (ten == 9 )
		PORTD = 0x29;
	else if (ten == 0 )
		PORTD = 0x20;
  	delay_ms(1);
                	
        //Display the Ones digit on Port D  	
   	if(one == 1 )
		PORTD = 0x41;
	else if (one == 2 )
		PORTD = 0x42;
	else if (one == 3 )
		PORTD = 0x43;
	else if (one == 4 )
		PORTD = 0x44;
	else if (one == 5 )
		PORTD = 0x45;
	else if (one == 6 )
		PORTD = 0x46;
	else if (one == 7 )
		PORTD = 0x47;
	else if (one == 8 )
		PORTD = 0x48;
	else if (one == 9 )
		PORTD = 0x49;
	else if (one == 0 )
		PORTD = 0x40;
	delay_ms(1);         
	}
}                          
