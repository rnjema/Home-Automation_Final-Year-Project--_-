#include <Servo.h>
Servo myservo;
int flame = 30;
int smoke = 31;
int red = 32;
int green = 33 ;
int servo = 34;
int buzzer = 35 ;
void setup ()
{
  pinMode (flame, INPUT) ;
  pinMode (smoke, INPUT) ;
  pinMode (red, OUTPUT) ;
  pinMode (green, OUTPUT) ;
  pinMode (buzzer, OUTPUT) ;
  Serial.begin(9600);
  myservo.attach(servo);
  myservo.write(0);
}

void loop ()
{
  int fval = digitalRead(flame);
  int sval = digitalRead(smoke);
  Serial.print("fval = ");
  Serial.println(fval);
  Serial.print("sval = ");
  Serial.println(sval);

  if ( sval == HIGH or fval == HIGH)
  {
    Serial.println(" WARNING! ");
    digitalWrite(red, HIGH);
    digitalWrite(buzzer, HIGH);
    digitalWrite(green, LOW);
    myservo.write(180);
  }
  else
  {
    Serial.println(" SAFE ");
    digitalWrite(red, LOW);
    digitalWrite(green, HIGH);
    digitalWrite(buzzer, LOW);
    myservo.write(0);
  }
  delay(100);
}
