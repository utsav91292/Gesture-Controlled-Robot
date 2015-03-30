 /* * RX is digital pin 2 (connect to TX of other device)
 *    TX is digital pin 3 (connect to RX of other device)
 *    We have used RF transmitter and receiver for 
 *    transmitting and receiving the control signal.
 *    We have used RKI-1198 and RKI-1197
 *    for wireless communication.
 *    RKI-1197 and RKI-1198 work on 2.4 GHz frequency.
 */
 

#include <SoftwareSerial.h>

SoftwareSerial mySerial(16, 14); // RX, TX

int z;
int E1= 18;//Enable1
int IP1= 19; //Motor1 Positive
int IP2= 20; //Motor1 Negative
int E2= 21;//Enable1
int IP4= 22;//Motor1 Positive
int IP3= 23;//Motor1 Negative

int ME1= 2;
int MIP1= 1;
int MIP2= 0;
int ME2= 3;
int MIP4= 4;
int MIP3= 5;

float dutyCycle;
//int ground=0;

void setup()  
{
 // Open serial communications and wait for port to open:
  Serial.begin(9600);
    // set the data rate for the SoftwareSerial port
  mySerial.begin(9600);
  pinMode(E1, OUTPUT);
  pinMode(E2, OUTPUT);
  pinMode(IP1, OUTPUT);
  pinMode(IP2, OUTPUT);
  pinMode(IP3, OUTPUT);
  pinMode(IP4, OUTPUT);
  
  pinMode(ME1, OUTPUT);
  pinMode(ME2, OUTPUT);
  pinMode(MIP1, OUTPUT);
  pinMode(MIP2, OUTPUT);
  pinMode(MIP3, OUTPUT);
  pinMode(MIP4, OUTPUT);
//  pinMode(ground, OUTPUT);

  digitalWrite(E1,HIGH);
  digitalWrite(E2,HIGH);
  digitalWrite(IP1,LOW);
  digitalWrite(IP2,LOW);
  digitalWrite(IP3,LOW);
  digitalWrite(IP4,LOW); 
  
  digitalWrite(ME1,HIGH);
  digitalWrite(ME2,HIGH);
  digitalWrite(MIP1,LOW);
  digitalWrite(MIP2,LOW);
  digitalWrite(MIP3,LOW);
  digitalWrite(MIP4,LOW); 
//  digitalWrite(ground,LOW);
}

void loop() // run over and over
{
  if (mySerial.available())
  {
      z=mySerial.read();
 //   Serial.println(z);
    if (z==243)    //stop
    {
          mySerial.println("stop");
          Serial.println("stop");
          digitalWrite(IP1,LOW);
          digitalWrite(IP2,LOW);
          digitalWrite(IP3,LOW);
          digitalWrite(IP4,LOW);
          
          digitalWrite(MIP1,LOW);
          digitalWrite(MIP2,LOW);
          digitalWrite(MIP3,LOW);
          digitalWrite(MIP4,LOW);
          delay(200);
    }
    else if (z==230)   //Forward
    {
           mySerial.println("forward");
           Serial.println("forward");
           digitalWrite(IP1,HIGH);
           digitalWrite(IP2,LOW);
           digitalWrite(IP3,HIGH);
           digitalWrite(IP4,LOW);

           digitalWrite(MIP1,HIGH);
           digitalWrite(MIP2,LOW);
           digitalWrite(MIP3,HIGH);
           digitalWrite(MIP4,LOW);

           delay(200);
    }
    else if (z==236)  //left
    {
           mySerial.println("left");       
           Serial.println("left"); 
           digitalWrite(IP1,LOW);
           digitalWrite(IP2,HIGH);
           digitalWrite(IP3,LOW);
           digitalWrite(IP4,LOW);

           digitalWrite(MIP1,LOW);
           digitalWrite(MIP2,HIGH);
           digitalWrite(MIP3,LOW);
           digitalWrite(MIP4,LOW);

           delay(200);
    }
    else if (z==242)   //Right
    {
           mySerial.println("right");
           Serial.println("right");
           digitalWrite(IP1,LOW);
           digitalWrite(IP2,LOW);
           digitalWrite(IP3,LOW);
           digitalWrite(IP4,HIGH);

           digitalWrite(MIP1,LOW);
           digitalWrite(MIP2,LOW);
           digitalWrite(MIP3,LOW);
           digitalWrite(MIP4,HIGH);

           delay(200);
       
    }
    else
    {
      Serial.println("garbage");
    }
 
  }
}


void pwm(float dutyCycle)
{
  int state=0;
  while(1)
  {
    if(state == 0)
      {
        digitalWrite(E1, LOW); 
        digitalWrite(E2, LOW); 
        delay(1000 * (1-dutyCycle));
        state = 1;
      }
      else 
      {
        digitalWrite(E1, HIGH); 
        digitalWrite(E2, HIGH); 
        delay(1000 * dutyCycle);
        state = 0; 
      }
  }
}
