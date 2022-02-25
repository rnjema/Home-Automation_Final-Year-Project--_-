


void setup() {
  // put your setup code here, to run once:

pinMode(22, OUTPUT);
pinMode(23, OUTPUT);
pinMode(24, OUTPUT);
pinMode(25, OUTPUT);
pinMode(26, OUTPUT);
pinMode(27, OUTPUT);
pinMode(28, OUTPUT);
pinMode(29, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  
  //appliance control relay module
  digitalWrite(22, HIGH);
  delay(4000);
  digitalWrite(22, LOW);
  
  digitalWrite(23, HIGH);
  delay(4000);
  digitalWrite(23, LOW);
  
  digitalWrite(24, HIGH);
  delay(4000);
  digitalWrite(24, LOW);
  
  digitalWrite(25, HIGH);
  delay(4000);
  digitalWrite(25, LOW);
  
  digitalWrite(26, HIGH);
  delay(4000);
  digitalWrite(26, LOW);
  
  digitalWrite(27, HIGH);
  delay(4000);
  digitalWrite(27, LOW);
  
  digitalWrite(28, HIGH);
  delay(4000);
  digitalWrite(29, LOW);
  
  digitalWrite(29, HIGH);
  delay(4000);

}
