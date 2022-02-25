#include "DHT.h"
#include <LiquidCrystal.h>
#define DHTPIN 2  
#define DHTTYPE DHT11 
#include <Servo.h>

//intializing gas and flame sensors
Servo myservo;
int flame = 30;
int smoke = 31;
int green_LED = 32;
int red_LED = 33;
int servo = 34;
int buzzer = 35 ;

// Initialize DHT sensor.
DHT dht(DHTPIN, DHTTYPE);
const int rs = 13, en = 12, d4 = 6, d5 = 5, d6 = 4, d7 = 3;
LiquidCrystal lcd(rs, en, d4, d5, d6, d7);

void setup() {

  //for flame and gas sensor
  pinMode (flame, INPUT);
  pinMode (smoke, INPUT);
  pinMode (buzzer, OUTPUT);
  pinMode(green_LED, OUTPUT);
  pinMode(red_LED, OUTPUT);
  myservo.attach(servo);
  myservo.write(0);
  //for flame and gas sensor ends here
  
  Serial.begin(9600);
  Serial.println(F("================="));
  Serial.println(F("================="));
  dht.begin();


  //apliance control relay module
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
  // Wait a few seconds between measurements.
  delay(2000);
  lcd.begin(20, 4);
  // Print a message to the LCD.
  lcd.print("Tempe & humid!");

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();
  // Read temperature as Fahrenheit (isFahrenheit = true)
  float f = dht.readTemperature(true);

  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(t) || isnan(f)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }

  // Compute heat index in Fahrenheit (the default)
  float hif = dht.computeHeatIndex(f, h);
  // Compute heat index in Celsius (isFahreheit = false)
  float hic = dht.computeHeatIndex(t, h, false);

  Serial.print(F("Humidity: "));
  Serial.print(h);
  lcd.setCursor(0, 1);
  lcd.print("Humidity: ");
  lcd.print(h);
  lcd.print("% ");
  
  
  Serial.print(F("%  Temperature: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(f);
  Serial.print(F("°F  Heat index: "));
  Serial.print(hic);
  Serial.print(F("°C "));
  Serial.print(hif);
  Serial.println(F("°F"));
  lcd.setCursor(0, 2);
  lcd.print("Tempereture:");
  lcd.print(t);
  lcd.print("°C ");

  //appliance control relay module

  Serial.println(F("switch 1 on"));
  Serial.println(F("switch 2 on"));
  Serial.println(F("switch 3 on"));
  Serial.println(F("switch 4 on"));
  Serial.println(F("switch 5 on"));
  Serial.println(F("switch 6 on"));
  Serial.println(F("switch 7 on"));
  Serial.println(F("switch 8 on"));

  digitalWrite(22, HIGH);
  digitalWrite(23, HIGH);
  digitalWrite(24, HIGH);
  digitalWrite(25, HIGH);
  digitalWrite(26, HIGH);
  digitalWrite(27, HIGH);
  digitalWrite(28, HIGH);
  digitalWrite(29, HIGH);
  delay(1000);
   Serial.println(F("switch 1 off"));
  Serial.println(F("switch 2 off"));
  Serial.println(F("switch 3 off"));
  Serial.println(F("switch 4 off"));
  Serial.println(F("switch 5 off"));
  Serial.println(F("switch 6 off"));
  Serial.println(F("switch 7 off"));
  Serial.println(F("switch 8 off"));
  digitalWrite(22, LOW);
  digitalWrite(23, LOW);
  digitalWrite(24, LOW);
  digitalWrite(25, LOW);
  digitalWrite(26, LOW);
  digitalWrite(27, LOW);
  digitalWrite(28, LOW);
  digitalWrite(29, LOW);
  delay(1000);

//for flame and gas sensor
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
