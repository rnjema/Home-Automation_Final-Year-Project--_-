#include "DHT.h"
#define DHTPIN 2  
#define DHTTYPE DHT11 
#define pir 36
#define relay1 37
#define relay2 38

//intializing gas and flame sensors
int flame = 30;
int smoke = 31;
int green_LED = 32;
int red_LED = 33;
int buzzer = 34 ;
int roomaircon = 35;

// Initialize DHT sensor.
DHT dht(DHTPIN, DHTTYPE);
void setup() {

  //for flame and gas sensor
  pinMode (flame, INPUT);
  pinMode (smoke, INPUT);
  pinMode (buzzer, OUTPUT);
  pinMode(green_LED, OUTPUT);
  pinMode(red_LED, OUTPUT);
  pinMode(roomaircon, OUTPUT);
  //for flame and gas sensor ends here
  
  Serial.begin(9600);
  Serial.println(F("================="));
  Serial.println(F("================="));
  dht.begin();

  //setup for object detector and night light
  pinMode(pir, OUTPUT);
  pinMode(relay1, OUTPUT);
  pinMode(relay2, OUTPUT);
}

void loop() {
  // Wait a few seconds between measurements.
  delay(1000);

  // Reading temperature or humidity takes about 250 milliseconds!
  // Sensor readings may also be up to 2 seconds 'old' (its a very slow sensor)
  float h = dht.readHumidity();
  // Read temperature as Celsius (the default)
  float t = dht.readTemperature();

  //aircon control
  if(h > 50 && t >= 20){
    Serial.println("TURNING ROOM FAN ON");
    digitalWrite(roomaircon, HIGH);
  }
  else{
    digitalWrite(roomaircon, LOW);
  }

  // Check if any reads failed and exit early (to try again).
  if (isnan(h) || isnan(t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }
  // Compute heat index in Celsius (isFahreheit = false)
  float hic = dht.computeHeatIndex(t, h, false);

  Serial.print(F("Humidity: "));
  Serial.print(h);  
  Serial.print(F("%  Temperature: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(F("°F  Heat index: "));
  Serial.print(hic);
  Serial.println(F("°C "));
  
//for flame and gas sensor
  int fval = digitalRead(flame);
  int sval = digitalRead(smoke);
  Serial.println("flame = ");
  Serial.println(fval);
  Serial.println("smoke = ");
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

  //for object detector and light security lights
    //get value of ldr and print
  int ldr = analogRead(A0);
  Serial.print("LIGHT INTESITY IS: ");
  Serial.println(ldr);
  //control night light based on light intesity.
  //keep relay on if light is low
  if (ldr >= 100){
    digitalWrite(relay1, LOW);
    Serial.println("DAY LIGHT!!");
    delay(500);
  }
 
  //turn on bulb
  else if (ldr < 100){
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
