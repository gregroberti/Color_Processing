volatile boolean update = false;
volatile int long TTtime;
volatile int next_r = 0;
volatile int next_g = 0;
volatile int next_b = 0;
volatile int curr_r = 0;
volatile int curr_g = 0;
volatile int curr_b = 0;


void setup()
{
  // declare the serial comm at 9600 baud rate
  Serial.begin(57600);

  // output pins
  pinMode(9, OUTPUT); // red
  pinMode(6, OUTPUT); // green
  pinMode(5, OUTPUT); // blue
}

void loop()
{
  // call the returned value from GetFromSerial() function
  switch(GetFromSerial())
  {
  case 'R':
    next_r = GetFromSerial();
    break;
  case 'G':
    next_g = GetFromSerial();
    break;
  case 'B':
    next_b = GetFromSerial();
    update = true;
    break;
  }
  
  if(update) {
    curr_r = next_r;
    curr_g = next_g;
    curr_b = next_b;
    update = false;
  }
  
  osmPWMSCCxyz(curr_r, curr_g, curr_b, 1);
}

// read the serial port
int GetFromSerial()
{
  while (Serial.available()<=0) {
  }
  return Serial.read();
}

// this is the light engine
void osmPWMSCCxyz(byte red, byte green, byte blue, int time)
{ // void osmPWM
	while (time > 0)
	{ // while time
		analogWrite(5, blue); // blue
		analogWrite(6, green); // green
		analogWrite(9, red); // red
		time--;
	}// elihw time
}// diov osmPWM

