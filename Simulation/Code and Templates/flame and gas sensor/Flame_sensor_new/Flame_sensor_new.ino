#include <LiquidCrystal.h>

LiquidCrystal lcd(13, 12, 11, 10, 9, 8);
int buzzer = 8;

int Flame = 7;

void setup() {
  Serial.begin(9600);
  pinMode(Flame, INPUT_PULLUP);
  pinMode (buzzer, OUTPUT);
  lcd.begin(20, 4);
  lcd.setCursor(0,0);
  lcd.print("Flame : ");
  lcd.setCursor(1,2);
  lcd.print("Electronics is Fun");
  lcd.setCursor(4,3);
  lcd.print("by SOHAIL");
}

void loop() {
  if(digitalRead(Flame) == HIGH){lcd.setCursor(8,0);lcd.print("Detected    ");
 digitalWrite(buzzer, HIGH);}
  if(digitalRead(Flame) == LOW ){lcd.setCursor(8,0);lcd.print("Not Detected");
    digitalWrite(buzzer, LOW);   }
  
}
