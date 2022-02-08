#include <LiquidCrystal.h>
//initialise the library with the numbers of the interface pins 
LiquidCrystal lcd(48, 49, 50, 51, 52, 53); 
 
#define POWER_PIN  23
#define SIGNAL_PIN A1
int value = 0;
void setup() { 
  pinMode(POWER_PIN, OUTPUT);   // set output pin and set to off before leading a value.
  digitalWrite(POWER_PIN, LOW); // turn the sensor OFF
  // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2); 
  Serial.begin(9600);
} 
  
void loop() { 
   
  // Print a message to the LCD. 
  lcd.print("  WATER LEVEL : "); 
  // set the cursor to column 0, line 1 
  lcd.setCursor(0, 1);  
  digitalWrite(POWER_PIN, HIGH);  // turn the sensor ON
  delay(10);                      // wait 10 milliseconds
  value = analogRead(SIGNAL_PIN); // read the analog value from sensor
  digitalWrite(POWER_PIN, LOW);   // turn the sensor OFF
  Serial.print("Water level: ");
  Serial.println(value);
  
  //decide what to do with the water level 
  if (value<=100){ lcd.println("     Empty    "); } 
  else if (value>100 && value<=300){ lcd.println("       Low      "); }
  else if (value>300 && value<=330){ lcd.println("     Medium     "); } 
  else if (value>330){ lcd.println("      High      "); }
  delay(1000); 
}
