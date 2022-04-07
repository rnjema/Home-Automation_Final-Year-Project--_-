/*Smart Home: IOT based Effiecient Household Resource usage Project
 *Using LoRa32 Micro-Controller: an ESP32 with Built in LoRa Capabilities and OLED Display
 * 
 * i.e., Electricity and Water
 * Final Year Project: @University of Malawi
 * Ramsey Njema bsc-com-ne-10-17@unima.ac.mw
 * Haddard Nyirenda bsc-com-ne-10-17@unima.ac.mw
 */
/*========================================================================================================================================================================================
 * Include Neccessary Libraries
 */

// Wifi
char WIFI_SSID[50];
char WIFI_PASSWORD[50];
#if defined(ESP32)
#include <WiFi.h>
#include <FirebaseESP32.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#endif

// DHT
#include <Adafruit_Sensor.h>
#include <DHT.h>
#include <DHT_U.h>
#define RELAY1 22 //switch for fan
#define RELAY2 13 //switch for light
#define RELAY3 37
#define RELAY4 38
#define DHTPIN 17 
#define pirPin 21  
#define LDR 36
#define DHTTYPE DHT22
DHT_Unified dht(DHTPIN, DHTTYPE);

//Firebase Necesities
//Provide the token generation process info.
#include <addons/TokenHelper.h>
//Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

/*=========================================================================================================================================================================================
 * Fixed Variable declaration
 */
 
//For the following credentials, see examples/Authentications/SignInAsUser/EmailPassword/EmailPassword.ino
/* 2. Define the API Key */
#define API_KEY "AIzaSyCocqUsUnVBTJ40_I1BOoNamgNpSQTnDnM"
/* 3. Define the RTDB URL */
#define DATABASE_URL "https://shautom-app-test-default-rtdb.asia-southeast1.firebasedatabase.app" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app
/* 4. Define the user Email and password that alreadey registerd or added in your project */
char USER_EMAIL[50];
char USER_PASSWORD[50];

/*=========================================================================================================================================================================================
 * Variable Declration and intiation
 */
//Define Firebase objects
FirebaseJson json;
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// Root Path and child nodes
String parentPath;
String databasePath;
String databasePath1;
String temperaturePath;
String humidityPath;
String pirStatusPath;
String lightdepentresistorStatusPath;
String sensorPath = "sensor_readings";
String roomBulbStatusPath = "appliance_status/roombulb-status";
String fanStatusPath  = "appliance_status/fan-status";
String switch1Path = "appliance_control/switch1-status";
String switch2Path = "appliance_control/switch2-status";
String switch3Path = "appliance_control/switch3-status";
String switch4Path = "appliance_control/switch4-status";

// wait for readings from sensor
unsigned long sendDataPrevMillis = 0;
uint32_t delayMS;
float prev_temp;
float prev_humidity;
String uid;


//variables

//the time we give the sensor to calibrate (10-60 secs according to the datasheet)
int calibrationTime = 30;        

//the time when the sensor outputs a low impulse
long unsigned int lowIn;         

//the amount of milliseconds the sensor has to be low 
//before we assume all motion has stopped
  

boolean lockLow = true;
boolean takeLowTime;  
int lightIntesityThreshhold = 700; 
/////////////////////////////

/*=========================================================================================================================================================================================
 *  main methods
 *  
 */
 
//main setup
void setup() {
  // put your setup code here, to run once:
  
  Serial.begin(115200);
  smartFan_setup();
  smartLight_setup();
  dht22setup();
  initWifi();
  getUserid();
  // Update database path
  databasePath = "/Shautom/User/";
  pirStatusPath = sensorPath + "/MotionSensor/pir-status";
  lightdepentresistorStatusPath = sensorPath + "/LightSensor/ldr-status";
  temperaturePath = sensorPath + "/DHT22/temperature";
  humidityPath = sensorPath + "/DHT22/humidity";
  parentPath = databasePath + uid;
  }
//main loop method
void loop(){
if (Firebase.ready() && (millis() - sendDataPrevMillis > delayMS || sendDataPrevMillis == 0)){
    sendDataPrevMillis = millis();

    //database paths for sensors and appliance status
    
//    parentPath = databasePath + "/MotionSensor";
//    parentPath = databasePath + "/LightSensor";
//    parentPath = databasePath1;
 
    
    delay(delayMS);
    smartLight();
    smartFan();
    Serial.printf("Set json... %s\n", Firebase.RTDB.setJSON(&fbdo, parentPath.c_str(), &json) ? "ok" : fbdo.errorReason().c_str());
  }
}

/*======================================================================================================================================================================================//
--Funtions in the setup
--Functions that will run one time
--Probably intializing the sensors
*/

//Get the user id of the person signing in
void getUserid(){
      // Getting the user UID might take a few seconds
  Serial.println("Getting User UID");
  while ((auth.token.uid) == "") {
    Serial.print(".");
    delay(1000);
  }
  // Print user UID
  uid = auth.token.uid.c_str();
  Serial.print("User UID: ");
  Serial.println(uid);  
}

//Update Temperature and Humidity Values
void updateTemp(float temp){
  if(prev_temp != temp){
    String tempString = "";
    tempString += (int)temp;
    tempString += "C";
    prev_temp = temp;
  }
}

void updateHumidity(float humidity){
  if(prev_humidity != humidity){
    String humidityString = "";
    humidityString += (int)humidity;
    humidityString += "%";
    prev_humidity = humidity;
  }
} 

//setup dhtt22 sensor
void dht22setup(){
  dht.begin();
  
  // Print temperature sensor details.
  sensor_t sensor;
  dht.temperature().getSensor(&sensor);

  // Print humidity sensor details.
  dht.humidity().getSensor(&sensor);
  
  // Set delay between sensor readings based on sensor details.
  delayMS = sensor.min_delay / 1000;
}

//Initialize WiFi and reconnect when disconnected
void initWifi(){
 
  Serial.println();
  delay(calibrationTime);
  Serial.print("Enter your WiFi credentials.\n");
  Serial.print("SSID: ");
  while (Serial.available() == 0) {
    // wait
  }
  Serial.readBytesUntil(10, WIFI_SSID, 50);
  Serial.print(WIFI_SSID);
  Serial.print("SSID RECEIVED");

  Serial.print("PASSWORD: ");
  while (Serial.available() == 0) {
    // wait
  }
  Serial.readBytesUntil(10, WIFI_PASSWORD, 50);
  Serial.print(WIFI_PASSWORD);
  Serial.println("PASSWORD RECEIVED");
  Serial.println();
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  //get email credentials
  Serial.print("Enter you MAIL credentials: \n");
  Serial.print("EMAIL: ");
  while (Serial.available() == 0) {
    // wait
  }
  Serial.readBytesUntil(10, USER_EMAIL, 50);
  Serial.print(USER_EMAIL);
  Serial.println("EMAIL RECEIVED");

  Serial.print("PASSWORD: ");
  while (Serial.available() == 0) {
    // wait
  }
  Serial.readBytesUntil(10, USER_PASSWORD, 50);
  Serial.print(USER_PASSWORD);
  Serial.print("USER-PASSWORD RECEIVED");
  
  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; //see addons/TokenHelper.h
  
  //Or use legacy authenticate method
  //config.database_url = DATABASE_URL;
  //config.signer.tokens.legacy_token = "<database secret>";
  //To connect without auth in Test Mode, see Authentications/TestMode/TestMode.ino
  
  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void temperature(){
    sensors_event_t event;
    dht.temperature().getEvent(&event);
    if (isnan(event.temperature)) {
      Serial.println(F("Error reading temperature!"));
    }
    else {
      Serial.print(F("Temperature: "));
      Serial.print(event.temperature);
      Serial.println(F("°C"));
      
      json.set(temperaturePath.c_str(), float(event.temperature));
      updateTemp(event.temperature);
    }
}
void humidity(){
    sensors_event_t event;
  // Get humidity event and print its value.
    dht.humidity().getEvent(&event);
    if (isnan(event.relative_humidity)) {
      Serial.println(F("Error reading humidity!"));
    }
    else {
      Serial.print(F("Humidity: "));
      Serial.print(event.relative_humidity);
      Serial.println(F("%"));
      json.set(humidityPath.c_str(), float(event.relative_humidity));
      updateHumidity(event.relative_humidity);
    }
}
//SMARTLIGHT SETUP
void smartLight_setup(){
  pinMode(RELAY2, OUTPUT);
  pinMode(pirPin, INPUT);
  pinMode(LDR, INPUT);
  
  //give the sensor some time to calibrate
  Serial.print("calibrating sensor ");
    for(int i = 0; i < calibrationTime; i++){
      Serial.print(".");
      delay(1000);
      }
    Serial.println(" done");
    Serial.println("SENSOR ACTIVE");
    delay(50);
 }
void smartLight(){
long unsigned int pause = 5000;
Serial.println("Light Intersity: ");
Serial.println(analogRead(LDR));
   if((digitalRead(pirPin) == HIGH)  && (analogRead(LDR)<= lightIntesityThreshhold)){
     digitalWrite(RELAY2, HIGH);
     json.set(lightdepentresistorStatusPath.c_str(),String(analogRead(LDR)));
     json.set(pirStatusPath.c_str(), 1);
     json.set(switch2Path.c_str(), 1);
     json.set(roomBulbStatusPath.c_str(), 1);
        
     delay(pause);
     
     if(lockLow){  
       //makes sure we wait for a transition to LOW before any further output is made:
       lockLow = false;            
       Serial.println("---");
       Serial.print("motion detected at ");
       Serial.print(millis()/1000);
       Serial.println(" sec"); 
       delay(50);
       }         
       takeLowTime = true;
     }
   else { 
     digitalWrite(RELAY2, LOW);
     json.set(lightdepentresistorStatusPath.c_str(),String(analogRead(LDR)));
     json.set(pirStatusPath.c_str(), 0);
     json.set(switch2Path.c_str(), 0);
     json.set(roomBulbStatusPath.c_str(), 0);
     
     if(takeLowTime){
      lowIn = millis();          //save the time of the transition from high to LOW
      takeLowTime = false;       //make sure this is only done at the start of a LOW phase
      }
     //if the sensor is low for more than the given pause, 
     //we assume that no more motion is going to happen
     if(!lockLow && millis() - lowIn > pause){  
         //makes sure this block of code is only executed again after 
         //a new motion sequence has been detected
         lockLow = true;                        
         Serial.print("motion ended at ");      //output
         Serial.print((millis() - pause)/1000);
         Serial.println(" sec");
         delay(50);
         }
     }
}
void smartFan_setup(){
  pinMode(RELAY1, OUTPUT);
}
void smartFan(){
  sensors_event_t event;
  temperature();
  humidity();
  if(event.temperature > 27 && event.relative_humidity > 50){
    digitalWrite(RELAY1, HIGH);
    json.set(switch1Path.c_str(), 1);
    json.set(fanStatusPath.c_str(), 1);
    
  }
  else{
    digitalWrite(RELAY1, LOW);
    json.set(switch1Path.c_str(), 0);
    json.set(fanStatusPath.c_str(), 0);
    }
  }
