#include <avr/interrupt.h>
#define MAX_PREVIEW 255
#define BUTTON   2
#define RED      9
#define GREEN    6
#define BLUE     5

#define LIGHT_ON  200
#define LIGHT_OFF 1000

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
volatile int live_preview[MAX_PREVIEW];

unsigned long prevMillis = 0;

void setup()
{
  // declare the serial comm at 9600 baud rate
  Serial.begin(115200);

  // output pins
  pinMode(RED, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLUE, OUTPUT);
  
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
      lp_size = index/3;
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

ISR(TIMER2_COMPA_vect)
{
  if (digitalRead (BUTTON) == LOW) {
    curr_red = 0;
    curr_green = 0;
    curr_blue = 0;
  }
  
  unsigned long currMillis = millis();
  if (lp_enabled) {
    if((light_on && ((currMillis - prevMillis) >= LIGHT_ON)) || (!light_on && ((currMillis - prevMillis) >= LIGHT_OFF))) {
      light_on = !light_on;
      prevMillis = currMillis;
    }
    
    if (light_on) {
      if (lp_index >= lp_size) {
        lp_index = 0;
      }
      analogWrite(RED, live_preview[(lp_index*3)+0]);
      analogWrite(GREEN, live_preview[(lp_index*3)+1]);
      analogWrite(BLUE, live_preview[(lp_index*3)+2]);
      lp_index++;
    }
    else {
      analogWrite(RED, 0);
      analogWrite(GREEN, 0);
      analogWrite(BLUE, 0);
    }
  }
}

void TimerMax(void)
{
  TCCR0B = TCCR0B & B11111000 | B00000001;

  //SET TIMER2 INTERRUPT 16.40ms
  TCCR2A = 0;// TCCR2A REG
  TCCR2B = 0;// TCCR2B REG
  TCNT2  = 0;// INITIALIZE TO ZERO

  // 1024 pre-scaler
  TCCR2B |= (1 << CS22);
  TCCR2B |= (1 << CS21);
//  TCCR2B |= (1 << CS20);

  TIMSK2 |= (1 << OCIE2A); // TIMER2 INTERRUPT ENABLE
}
