
const byte numChars = 32;
char receivedChars[numChars];

bool newCmd = false;

  
void setup() {
  // start serial port at 9600 bps:
  Serial.begin(9600);
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_BUILTIN, OUTPUT);
  while (!Serial) {
    ; // wait for serial port to connect.
  }
  Serial.println("Con");



}

void loop() {
  recvInt16();
  //executeCmd();
  //Serial.println("!");


}

void recvData() {
  static byte index = 0;
  char endMarker = '\n';
  char recv;

  while (Serial.available() > 0 && !newCmd) {
    recv = Serial.read();
    if (recv != endMarker) {
      receivedChars[index] = recv;
      index++;
      if (index >= numChars) {
        index = numChars - 1;
      }
    }
    else {
      // End marker recieved
      receivedChars[index] = '\0'; // Terminate string
      index = 0;
      newCmd = true;
    }
  }
}

void recvInt16() {
  byte highB;
  byte lowB;
  bool highFilled = false;
  bool lowFilled = false;

  while (Serial.available() > 0 && !highFilled && !lowFilled) {
    highB = Serial.read();
    lowB = Serial.read();
    uint16_t value = (highB << 8) | lowB;
    Serial.write(value);
    Serial.println(".");
    Serial.println(value);
    Serial.println("--");
  }
}

void executeCmd() {
  if (newCmd) {
    if (strcmp(receivedChars, "on") == 0) {
      digitalWrite(LED_BUILTIN, HIGH);
      Serial.println("LED on");
    }
    else if (strcmp(receivedChars, "off") == 0) {
      digitalWrite(LED_BUILTIN, LOW);
      Serial.println("LED off");
    }
    else {
      Serial.println("ERR");
    }
    newCmd = false;
  }
}
