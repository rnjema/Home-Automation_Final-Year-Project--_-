#define pir 22
#define relay1 23
#define relay2 24
#include <LiquidCrystal.h>

// initializing the library with the numbers of the interface pins
LiquidCrystal lcd(48, 49, 50, 51, 52, 53);

void setup(){
  Serial.begin(9600);
  pinMode(pir, OUTPUT);
  pinMode(relay1, OUTPUT);
  pinMode(relay2, OUTPUT);
  lcd.begin(16, 2);
// Print a message to the LCD.
  lcd.setCursor(1,0);
  lcd.print("Ldr out= ");
  lcd.setCursor(1,1);
  lcd.print("SHAUTOM!");
}

void loop(){
  //get value of ldr and print
 
  int ldr = analogRead(A0);
  lcd.setCursor(10,0);
  lcd.print(ldr);
  
  //control night light based on light intesity.
  //keep relay of if light is low
  if (ldr <= 100){
    digitalWrite(relay1, LOW);
    Serial.println("DAY LIGHT!!");
    delay(500);
  }
  else if (ldr > 100){
    Serial.println("");
    digitalWrite(relay1, HIGH);
    Serial.println("ITS DARK, NIGHT LIGHT ON!");
    delay(500);
  }
  
  int pir_input = digitalRead(pir);
  
  if (pir_input == LOW){
    Serial.println("ROOM IS EMPTY");
    digitalWrite(relay2,LOW); 
    delay(500);
  }
  
  else{
    Serial.println("OBJECT DETECTED, LIGHTS ON!");
    digitalWrite(relay2,HIGH);
    delay(500);
  }

}
