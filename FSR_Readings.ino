int fsrLFPin = 0;    //Left Front   
int fsrRFPin = 1;    //Right Front
int fsrLBPin = 4;    //Left Back
int fsrRBPin = 5;    //Right Back
int fsrLFReading;
int fsrRFReading;
int fsrLBReading;  
int fsrRBReading; 
bool sent=false;
bool recieved=false;
#include <SPI.h>
#include "Adafruit_BLE_UART.h"

// Connect CLK/MISO/MOSI to hardware SPI
// e.g. On UNO & compatible: CLK = 13, MISO = 12, MOSI = 11
#define ADAFRUITBLE_REQ 10
#define ADAFRUITBLE_RDY 2     // This should be an interrupt pin, on Uno thats #2 or #3
#define ADAFRUITBLE_RST 9

Adafruit_BLE_UART BTLEserial = Adafruit_BLE_UART(ADAFRUITBLE_REQ, ADAFRUITBLE_RDY, ADAFRUITBLE_RST);
void setup(void) {
  Serial.begin(9600);   
  BTLEserial.begin();
  Serial.println("Started");
}
void loop(void) {
fsrLFReading = analogRead(fsrLFPin); 
fsrRFReading   = analogRead(fsrRFPin);
fsrLBReading = analogRead(fsrLBPin);
fsrRBReading = analogRead(fsrRBPin);
 BTLEserial.pollACI();
 String s="";
 aci_evt_opcode_t status = BTLEserial.getState();
   if (status == ACI_EVT_CONNECTED) {
    Serial.print("LF: ");
    Serial.print(fsrLFReading);
    Serial.print("   LB: ");
    Serial.print(fsrLBReading);
    Serial.print("   RF: ");
    Serial.print(fsrRFReading);
    Serial.print("   RB: ");
    Serial.println(fsrRBReading);
   if (fsrLFReading>200 && fsrLBReading>200 && fsrRBReading>200 && fsrRFReading>200) {
    s="Swipe Up";
  } 
  else if (fsrLFReading<200 && fsrLBReading<200 && fsrRBReading>200 && fsrRFReading>200) {
    s="Swipe Right";
  } 
  else if (fsrLFReading>200 && fsrLBReading>200 && fsrRBReading<200 && fsrRFReading<200) {
    s="Swipe Left";
  } 
  else if (fsrLFReading>200 && fsrLBReading<200 && fsrRBReading<200 && fsrRFReading>200) {
    s="Swipe Down";
  }
  else{
    s="No Swipe";
  }
   uint8_t sendbuffer[20];
   s.getBytes(sendbuffer, 20);
   char sendbuffersize = min(20, s.length());
   Serial.println((char *)sendbuffer);
   BTLEserial.write(sendbuffer, sendbuffersize);
   delay(1000);
  }
}
/* 
while (BTLEserial.available()) {
      char c = BTLEserial.read();
      Serial.print(c);
      recieved=true;
    }
    if(recieved==true){
      Serial.println();
      recieved=false;
    }
    if (Serial.available()) {
      // Read a line from Serial
      Serial.setTimeout(100); // 100 millisecond timeout
      String s = Serial.readString();

      // We need to convert the line to bytes, no more than 20 at this time
      uint8_t sendbuffer[20];
      s.getBytes(sendbuffer, 20);
      char sendbuffersize = min(20, s.length());

      Serial.println((char *)sendbuffer);
     BTLEserial.write(sendbuffer, sendbuffersize);
     sent=true;
    }
    if(sent==true){
      sent=false;
      Serial.println();
    }
   }

 */
