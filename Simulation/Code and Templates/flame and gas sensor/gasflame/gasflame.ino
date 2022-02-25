int flame = 30;
int smoke = 31;
int green_LED = 32;
int red_LED = 33;
int buzzer = 34 ;

void setup ()
{
  pinMode (flame, INPUT);
  pinMode (smoke, INPUT);
  pinMode (buzzer, OUTPUT);
  pinMode(green_LED, OUTPUT);
  pinMode(red_LED, OUTPUT);
  Serial.begin(9600);
}

void loop ()
{
  int fval = digitalRead(flame);
  int sval = digitalRead(smoke);
  Serial.print("flame = ");
  Serial.println(fval);
  Serial.print("smoke = ");
  Serial.println(sval);

  if ( sval == HIGH or fval == HIGH)
  {
    Serial.println(" WARNING! ");
    digitalWrite(red_LED, HIGH);
    digitalWrite(green_LED,LOW);
    digitalWrite(buzzer, HIGH);
  }
  else
  {
    Serial.println(" SAFE ");
    digitalWrite(buzzer, LOW);
    digitalWrite(red_LED, LOW);
    digitalWrite(green_LED,HIGH);
  }
  delay(100);
}
