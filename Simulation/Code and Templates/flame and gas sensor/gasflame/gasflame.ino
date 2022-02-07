#include <Servo.h>
Servo myservo;
int flame = 30;
int smoke = 31;
int green_LED = 32;
int red_LED = 33;
int servo = 34;
int buzzer = 35 ;

void setup ()
{
  pinMode (flame, INPUT);
  pinMode (smoke, INPUT);
  pinMode (buzzer, OUTPUT);
  pinMode(green_LED, OUTPUT);
  pinMode(red_LED, OUTPUT);
  Serial.begin(9600);
  myservo.attach(servo);
  myservo.write(0);
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
    myservo.write(180);
  }
  else
  {
    Serial.println(" SAFE ");
    digitalWrite(buzzer, LOW);
    digitalWrite(red_LED, LOW);
    digitalWrite(green_LED,HIGH);
    myservo.write(0);
  }
  delay(100);
}
