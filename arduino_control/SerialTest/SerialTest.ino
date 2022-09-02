

int led = 13;

int i = 0;

void setup() {
 Serial1.begin(115200); 
 pinMode(led, OUTPUT);
}

void loop() {
  digitalWrite(led, !digitalRead(led));
  Serial1.println(i);
  i++;
  delay(500);
}
