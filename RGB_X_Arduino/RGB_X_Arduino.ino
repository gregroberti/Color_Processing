#include <avr/interrupt.h>
#define RED      9
#define GREEN    6
#define BLUE     5

volatile boolean rec_red = false;
volatile boolean rec_green = false;
volatile boolean rec_blue = false;
volatile int curr_red = 0;
volatile int curr_green = 0;
volatile int curr_blue = 0;
volatile int next_red = 0;
volatile int next_green = 0;
volatile int next_blue = 0;

void setup()
{
  // declare the serial comm at 9600 baud rate
  Serial.begin(115200);

  // output pins
  pinMode(9, OUTPUT); // red
  pinMode(6, OUTPUT); // green
  pinMode(5, OUTPUT); // blue
}

void loop()
{ 
  
  switch(GetFromSerial())
  {
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
  
  analogWrite(BLUE, curr_blue);
  analogWrite(GREEN, curr_green);
  analogWrite(RED, curr_red);
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
}
