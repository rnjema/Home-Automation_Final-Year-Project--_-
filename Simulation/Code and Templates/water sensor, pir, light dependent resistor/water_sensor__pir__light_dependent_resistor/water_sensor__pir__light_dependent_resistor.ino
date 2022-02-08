#define pir 22
#include <LiquidCrystal.h>

// initializing the library with the numbers of the interface pins
LiquidCrystal lcd(48, 49, 50, 51, 52, 53);

void setup(){
  Serial.begin(9600);
  pinMode(pir, OUTPUT);
  lcd.begin(16, 2);
// Print a message to the LCD.
  lcd.setCursor(1,0);
  lcd.print("Ldr out= ");
  lcd.setCursor(1,1);
  lcd.print("SHAUTOM!");
}

void loop(){
  int pir_input = digitalRead(pir);
  if (pir_input == HIGH){
    Serial.println("motion detected!"); 
    delay(500);
  }
  
  else{
    Serial.println("No Motion detected!");
    delay(500);
  }
 
  int ldr = analogRead(A0);
  lcd.setCursor(10,0);
  lcd.print(ldr);
}
