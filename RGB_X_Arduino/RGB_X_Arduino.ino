#include <avr/interrupt.h>
#define RED      9
#define GREEN    6
#define BLUE     5

volatile byte inByte;
volatile boolean light_on = false;
volatile boolean rec_red = false;
volatile boolean rec_green = false;
volatile boolean rec_blue = false;
volatile boolean lp_enabled = false;

volatile int lp_size = 0;
volatile int lp_index = 0;
volatile int index = 0;
volatile int curr_red = 0;
volatile int curr_green = 0;
volatile int curr_blue = 0;
volatile int next_red = 0;
volatile int next_green = 0;
volatile int next_blue = 0;
volatile int live_preview[255];

void setup()
{
  // declare the serial comm at 9600 baud rate
  Serial.begin(115200);

  // output pins
  pinMode(9, OUTPUT); // red
  pinMode(6, OUTPUT); // green
  pinMode(5, OUTPUT); // blue
  
  TimerMax();
}

void loop()
{ 
  
  switch(GetFromSerial())
  {
    case 'L':
      index = 0;
      inByte = GetFromSerial();
      while(inByte != 'P') {
        live_preview[index] = inByte;
        inByte = GetFromSerial();
        index++;
      }
      lp_size = lp_index + 1;
      lp_index = 0;
      lp_enabled = true;
      break;
    case 'R':
      next_red = GetFromSerial();
      rec_red = true;
      break;
    case 'G':
      next_green = GetFromSerial();
      rec_green = true;
      break;
    case 'B':
      next_blue = GetFromSerial();
      rec_blue = true;
      break;
  }
  
  if(rec_red && rec_green && rec_blue) {
    curr_red = next_red;
    curr_green = next_green;
    curr_blue = next_blue;
    reset_rec();
  }
  
  if (!lp_enabled) {
    analogWrite(RED, curr_red);  
    analogWrite(GREEN, curr_green);
    analogWrite(BLUE, curr_blue);
  }
}

int GetFromSerial()
{
  while (Serial.available()<=0) {
  }
  return Serial.read();
}

void reset_rec() {
  rec_red = false;
  rec_green = false;
  rec_blue = false;
  lp_enabled = false;
}

// this is the light engine
void osmPWM(byte red, byte green, byte blue, int time)
{ // void osmPWM
  time = time * 19;
  while (time > 0)
  {
    analogWrite(RED, red);
    analogWrite(GREEN, green);
    analogWrite(BLUE, blue);
    time--;
  }
}

ISR(TIMER2_COMPA_vect) // TIMER2 INTERRUPT @ 61HZ / 16.40ms
{ // TIMER2 ISR
  if (lp_enabled) {
    if (light_on) {
      if (lp_index > lp_size) {
        lp_index = 0;
      }
      osmPWM(live_preview[(lp_index*3)+0], live_preview[(lp_index*3)+1], live_preview[(lp_index*3)+2], 1);
      lp_index++;
    }
    else {
      osmPWM(0, 0, 0, 3);
    }
  }
  light_on = !light_on;
}

void TimerMax(void)
{
	// SET TIMER0 AND TIMER1
	TCCR0B = (TCCR0B & 0b11111000) | 0x01; // Timer 0 for pin 5 & 6
	TCCR1B = (TCCR1B & 0b11111000) | 0x01; // Timer 1 for pin 9 & 10

	//SET TIMER2 INTERRUPT 16.40ms
	TCCR2A = 0;// TCCR2A REG
	TCCR2B = 0;// TCCR2B REG
	TCNT2  = 0;// INITIALIZE TO ZERO
	// 1024 pre-scaler
	TCCR2B |= (1 << CS22);
	TCCR2B |= (1 << CS21);
	TCCR2B |= (1 << CS20);

	TIMSK2 |= (1 << OCIE2A); // TIMER2 INTERRUPT ENABLE
}
