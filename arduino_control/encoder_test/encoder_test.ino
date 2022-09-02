#define MotFwd  4  // Motor Forward pin
#define MotRev  5 // Motor Reverse pin

  //MOTOR PIN OUTPUTS
    //Yellow: Ground
    //Orange: B
    //Red:A
    //Purple: VCC
    //Blue: M2
    //Black: M1

    //to change speed use PWM (Look it up)
    //certain pins have PWM enabled and you give it a percent of how fast you want it to go.

int encoderPin1 = 2; //Encoder Output 'A' must connected with intreput pin of arduino.
int encoderPin2 = 3; //Encoder Otput 'B' must connected with intreput pin of arduino.
volatile int lastEncoded = 0; // Here updated value of encoder store.
volatile long encoderValue = 100; // Raw encoder value


void setup() {

  pinMode(MotFwd, OUTPUT); 
  pinMode(MotRev, OUTPUT); 
  Serial.begin(9600); //initialize serial comunication

   pinMode(encoderPin1, INPUT_PULLUP); 
  pinMode(encoderPin2, INPUT_PULLUP);

  digitalWrite(encoderPin1, HIGH); //turn pullup resistor on
  digitalWrite(encoderPin2, HIGH); //turn pullup resistor on

  //call updateEncoder() when any high/low changed seen
  //on interrupt 0 (pin 2), or interrupt 1 (pin 3) 
  attachInterrupt(0, updateEncoder, CHANGE); 
  attachInterrupt(1, updateEncoder, CHANGE);


}

void loop() {
  


//delay(100);

while (encoderValue <= 20000){
digitalWrite(MotFwd, LOW); 
 digitalWrite(MotRev, HIGH);
 Serial.print("Forward  "); 
 Serial.println(encoderValue);
 delay(10);
}

while (encoderValue > 0){
 digitalWrite(MotFwd, HIGH); 
 digitalWrite(MotRev, LOW);
 Serial.print("Reverse  ");
 Serial.println(encoderValue);
 delay(10);
}
delay(500);



//delay(500);

} 

void updateEncoder(){
  int MSB = digitalRead(encoderPin1); //MSB = most significant bit
  int LSB = digitalRead(encoderPin2); //LSB = least significant bit

  int encoded = (MSB << 1) |LSB; //converting the 2 pin value to single number
  int sum  = (lastEncoded << 2) | encoded; //adding it to the previous encoded value

  if(sum == 0b1101 || sum == 0b0100 || sum == 0b0010 || sum == 0b1011) encoderValue --;
  if(sum == 0b1110 || sum == 0b0111 || sum == 0b0001 || sum == 0b1000) encoderValue ++;

  lastEncoded = encoded; //store this value for next time

}
/*
int distanceControl(){
  const d = 0; //total distance to travel
  int p = 1; //speed control multplier (between 0 and 255)
  int error = 0; //distance yet to be traveled

  p = 

  if(
  */

