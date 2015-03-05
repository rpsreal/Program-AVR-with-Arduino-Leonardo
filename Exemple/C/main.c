#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB |= (1 << PD0);

    while(1){ 
	PORTB ^= (1 << PB0);
	_delay_ms(1000);
    }

return 0;
}
