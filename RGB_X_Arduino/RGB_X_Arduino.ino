volatile boolean update = false;
volatile int long TTtime;
volatile int red = 0;
volatile int green = 0;
volatile int blue = 0;

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
  // call the returned value from GetFromSerial() function
  switch(GetFromSerial())
  {
  case 'R':
    red = GetFromSerial();
    break;
  case 'G':
    green = GetFromSerial();
    break;
  case 'B':
    blue = GetFromSerial();
    update = true;
    break;
  }
  
  if(update) {
    update = false;
    analogWrite(5, blue);
    analogWrite(6, green);
    analogWrite(9, red);
  }
}

// read the serial port
int GetFromSerial()
{
  while (Serial.available()<=0) {
  }
  return Serial.read();
}
