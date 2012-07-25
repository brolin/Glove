//https://github.com/brolin/Glove

import processing.serial.*;

int bgcolor;                 // Background color
int fgcolor;                 // Fill color
Serial myPort;                       // The serial port
int[] serialInArray = new int[20];    // Where we'll put what we receive
int serialCount = 0;                 // A count of how many bytes we receive
int xpos, ypos;                     // Starting position of the ball
boolean firstContact = false;        // Whether we've heard from the microcontroller

//mapping Class
MapValues map_values;

//define read values

float valX, valY, valZ;
float last_valX = 0;
float last_valY = 0;
float last_valZ = 0;

int time;
int last_time = 0;

boolean nuevaTrama = false;
/*Packet time_;
int tempo;*/
PFont f;
int tempo;
PrintWriter output;
void setup() {
  size(700, 700, P3D);  // Stage size
  noStroke();      // No border on the next thing drawn

//time_ = new Packet(0,0,0);

  // Set the starting position of the ball (middle of the stage)
  xpos = width/2;
  ypos = height/2;

  // Print a list of the serial ports, for debugging purposes:
  println(Serial.list());

  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  //frameRate(15);

  //initialize mapping
 
  map_values = new MapValues(width, height);
  
  f = loadFont("CourierNew36.vlw");
  textFont(f, 14);
  output = createWriter("positions.txt");
  
   output.print("Tiempo" + "," + "energiaX" + "," + "EnergiaY" + "," + "energiaZ" + ",");
   output.println("last_valX" + "," + "last_valY" + "," + "last_valZ"
   
   );
}

void draw() {
  tempo = millis() %1000;
  println(tempo);
/* usar tiempo en el futuro
  tempo= millis() %1000;
  time_.setTime(tempo);
  println(time_.getTiempo());*/

  // Draw the shape
  //ellipse(xpos, ypos, 20, 20);
  if (nuevaTrama) {
    nuevaTrama = false;
    time = (time + 1)%width;


    //calibrate adxl335 values 
    map_values.update_calib(valX,valY,valZ);
    
    map_values.setDirections();
   output.print(last_time + "," + map_values.getPosition().valX + "," + map_values.getPosition().valY + "," + map_values.getPosition().valZ + ",");
   output.println(last_valX + "," + last_valY + "," + last_valZ);
    //map_values.draw();
    //output.println();

    //linea blanca X
    stroke(255);
    line(last_time, last_valX, time, valX);
    stroke(255, 0, 0);
    //linea roja Y
    line(last_time, last_valY, time, valY);

    //lineaverde Z
    stroke(0, 255, 0);
    line(last_time, last_valZ, time, valZ);
    if((map_values.getPosition().valZ > 3)||(map_values.getPosition().valZ < -3)){
      
      fill(0);
      ellipse(last_time, last_valZ, 50,50);
      fill(255);
      text(map_values.getPosition().valZ,last_time, last_valZ);
      
    
    }else{}
    
    last_valX = valX;
    last_valY = valY;
    last_valZ = valZ;
    last_time = time;
    
    

    if (time == 1)
    {
      fill(0);
      rect(0, 0, width, height);
    }
    
    
   
  }
}
void keyPressed() { // Press a key to save the data
  output.flush(); // Write the remaining data
  output.close(); // Finish the file
  exit(); // Stop the program
}
void serialEvent(Serial myPort) {
  // read a byte from the serial port:
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A,
  // clear the serial buffer and note that you've
  // had first contact from the microcontroller. 
  // Otherwise, add the incoming byte to the array:
  if (firstContact == false) {
    if (inByte == 0x7E) { 
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from the microcontroller
      //myPort.write('A');       // ask for more
    }
  } 
  else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 3 bytes:
    if (serialCount > 19 ) {

      //      start_delimiter = serialInArray[0];
      //      msb_length = serialInArray[1];
      //      mlb_length = serialInArray[2];
      //      mlb_length = serialInArray[3];
      //      mlb_length = serialInArray[4];
      //      mlb_length = serialInArray[5];
      //      mlb_length = serialInArray[6];
      //      msb_length = serialInArray[7];
      //      mlb_length = serialInArray[8];
      //      mlb_dato4 = serialInArray[9];
      //      msb_dato4 = serialInArray[10];
      //      mlb_dato3 = serialInArray[11];
      //      msb_dato3 = serialInArray[12];
      //      mlb_dato2 = serialInArray[13];
      //      msb_dato2 = serialInArray[14];
      //      mlb_dato1 = serialInArray[15];
      //      msb_dato1 = serialInArray[16];
      //      cksum = serialInArray[17];


      // print the values (for debugging purposes only):
      /*print(serialInArray[14]*256 +  serialInArray[15] + " " );
       print(serialInArray[12]*256 + serialInArray[13] + " " );
       println(serialInArray[10]*256 + serialInArray[11] );*/
      valX = serialInArray[14]*256 +  serialInArray[15];
      valY = serialInArray[12]*256 + serialInArray[13];
      valZ = serialInArray[10]*256 + serialInArray[11];
      
      // Send a capital A to request new sensor readings:
      //myPort.write(0x7E);
      // Reset serialCount:
      serialCount = 0;
      nuevaTrama = true;
    }
  }
}


/*

 //  Serial Call and Response
 //  by Tom Igoe
 //  Language: Wiring/Arduino
 
 //  This program sends an ASCII A (byte of value 65) on startup
 //  and repeats that until it gets some data in.
 //  Then it waits for a byte in the serial port, and 
 //  sends three sensor values whenever it gets a byte in.
 
 //  Thanks to Greg Shakar for the improvements
 
 //  Created 26 Sept. 2005
 //  Updated 18 April 2008
 
 
 int firstSensor = 0;    // first analog sensor
 int secondSensor = 0;   // second analog sensor
 int thirdSensor = 0;    // digital sensor
 int inByte = 0;         // incoming serial byte
 
 void setup()
 {
 // start serial port at 9600 bps:
 Serial.begin(9600);
 pinMode(2, INPUT);   // digital sensor is on digital pin 2
 establishContact();  // send a byte to establish contact until Processing responds 
 }
 
 void loop()
 {
 // if we get a valid byte, read analog ins:
 if (Serial.available() > 0) {
 // get incoming byte:
 inByte = Serial.read();
 // read first analog input, divide by 4 to make the range 0-255:
 firstSensor = analogRead(0)/4;
 // delay 10ms to let the ADC recover:
 delay(10);
 // read second analog input, divide by 4 to make the range 0-255:
 secondSensor = analogRead(1)/4;
 // read  switch, multiply by 155 and add 100
 // so that you're sending 100 or 255:
 thirdSensor = 100 + (155 * digitalRead(2));
 // send sensor values:
 Serial.print(firstSensor, BYTE);
 Serial.print(secondSensor, BYTE);
 Serial.print(thirdSensor, BYTE);               
 }
 }
 
 void establishContact() {
 while (Serial.available() <= 0) {
 Serial.print('A', BYTE);   // send a capital A
 delay(300);
 }
 }
 
 
 */
