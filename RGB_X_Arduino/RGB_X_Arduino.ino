void setup()
{
  // declare the serial comm at 9600 baud rate
  Serial.begin(57600);

  // output pins
  pinMode(9, OUTPUT); // red
  pinMode(6, OUTPUT); // green
  pinMode(5, OUTPUT); // blue

  // another output pin o be used as GROUND 
  //pinMode(8, OUTPUT); // ground
  //digitalWrite(8, LOW);
}

void loop()
{
  // call the returned value from GetFromSerial() function
  switch(GetFromSerial())
  {
  case 'R':
    analogWrite(9, GetFromSerial());
    break;
  case 'G':
    analogWrite(6, GetFromSerial());
    break;
  case 'B':
    analogWrite(5, GetFromSerial());
    break;
//  case 'C':
//    analogWrite(5,0);
//    analogWrite(9,0);
//    analogWrite(6,0);
//    delayMicroseconds(GetFromSerial());
//    break;

  }
}

// read the serial port
int GetFromSerial()
{
  while (Serial.available()<=0) {
  }
  return Serial.read();
}
