#include <Arduino.h>
#include <Wire.h>
#include <WiFi.h>
#include <WebSocketsServer.h>
#include <ArduinoJson.h>
#include <BH1750.h>
#include <Adafruit_BME280.h>
#include <Adafruit_ICM42688.h>
#include <SparkFun_MAX3010x.h>

// Reality Bridge Probe v0.1 reference firmware
// DESIGN TARGET — physical hardware qualification is not yet published.

static constexpr int SDA_PIN = 8;
static constexpr int SCL_PIN = 9;
static constexpr uint32_t PACKET_MS = 100;
const char* AP_SSID = "RealityBridge-Probe";
const char* AP_PASS = "change-this-password";

WebSocketsServer ws(81);
BH1750 luxSensor;
Adafruit_BME280 bme;
Adafruit_ICM42688 imu;
MAX30105 ppg;
bool hasLux=false, hasBme=false, hasImu=false, hasPpg=false;
uint32_t lastPacket=0;

void setup(){
  Serial.begin(115200);
  delay(300);
  Wire.begin(SDA_PIN,SCL_PIN);
  hasLux = luxSensor.begin(BH1750::CONTINUOUS_HIGH_RES_MODE);
  hasBme = bme.begin(0x76) || bme.begin(0x77);
  hasImu = imu.begin_I2C(0x68,&Wire) || imu.begin_I2C(0x69,&Wire);
  hasPpg = ppg.begin(Wire,I2C_SPEED_FAST);
  if(hasPpg) ppg.setup(60,4,2,100,411,4096);
  WiFi.mode(WIFI_AP);
  WiFi.softAP(AP_SSID,AP_PASS);
  ws.begin();
  Serial.printf("Reality Bridge Probe IP %s websocket :81\n",WiFi.softAPIP().toString().c_str());
}

void loop(){
  ws.loop();
  uint32_t now=millis();
  if(now-lastPacket<PACKET_MS) return;
  lastPacket=now;
  float lux = hasLux ? luxSensor.readLightLevel() : 0;
  float tempC = hasBme ? bme.readTemperature() : 0;
  float humidity = hasBme ? bme.readHumidity() : 0;
  float pressure = hasBme ? bme.readPressure()/100.0f : 0;
  float motion=0, heading=0;
  if(hasImu){
    sensors_event_t accel, gyro, temp;
    imu.getEvent(&accel,&gyro,&temp);
    motion = min(1.0f, sqrtf(accel.acceleration.x*accel.acceleration.x + accel.acceleration.y*accel.acceleration.y + accel.acceleration.z*accel.acceleration.z)/30.0f);
    heading = fmodf(atan2f(accel.acceleration.y,accel.acceleration.x)*180.0f/PI+360.0f,360.0f);
  }
  uint32_t ir = hasPpg ? ppg.getIR() : 0;
  uint32_t red = hasPpg ? ppg.getRed() : 0;

  StaticJsonDocument<512> d;
  d["t"]=now;
  d["lux"]=lux;
  d["motion"]=motion;
  d["audioRms"]=0.0; // INMP441 I2S RMS adapter is the next firmware extension.
  d["temperatureC"]=tempC;
  d["humidityPct"]=humidity;
  d["pressureHpa"]=pressure;
  d["ppgIr"]=ir;
  d["ppgRed"]=red;
  d["heading"]=heading;
  d["firmware"]="0.1.0";
  String out;
  serializeJson(d,out);
  Serial.println(out);
  ws.broadcastTXT(out);
}
