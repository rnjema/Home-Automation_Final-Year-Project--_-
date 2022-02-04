/*  DHT11/ DHT22 Sensor Temperature and Humidity Tutorial
 *  Program made by Dejan Nedelkovski,
 *  www.HowToMechatronics.com 
 */
/*
 * You can find the DHT Library from Arduino official website
 * https://playground.arduino.cc/Main/DHTLib
 */

#include <LiquidCrystal.h> // includes the LiquidCrystal Library
#include <DHT.h>


#define dataPin 8
LiquidCrystal lcd(7,6,5,4,3,2); // Creates an LCD object. Parameters: (rs, enable, d4, d5, d6, d7)

DHT dht(dataPin, DHT22);

void setup() {
  lcd.begin(16,2); // Initializes the interface to the LCD screen, and specifies the dimensions (width and height) of the display
  dht.begin()
}


void loop() {
  float readData = dht.read(dataPin);
  float t = dht.readTemperature();
  float h = dht.readHumidity();
  lcd.setCursor(0,0); // Sets the location at which subsequent text written to the LCD will be displayed
  lcd.print("Temp.: "); // Prints string "Temp." on the LCD
  lcd.print(t); // Prints the temperature value from the sensor
  lcd.print(" C");
  lcd.setCursor(0,1);
  lcd.print("Humi.: ");
  lcd.print(h);
  lcd.print(" %");
  delay(2000);
}