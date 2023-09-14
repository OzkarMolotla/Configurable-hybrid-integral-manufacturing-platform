// Incluir las librerias 
#include <ESP8266WiFi.h>
#include <SoftwareSerial.h>
SoftwareSerial SerialEsp(13,15); //Rx Tx

String dato;
String data;
float ROJO = 0;
float i=0; 
//Parametros WIFI   
const char* ssid = "leai4";
const char* password = "T9Uj&8*3";
const char* host = "172.31.0.104"; //localhost IP de tu PC .65
//const char* ssid = "INFINITUM9516_2.4";
//const char* password = "4bfDdEnJ9N";
//const char* host = "192.168.1.72"; //localhost IP de tu PC .65
String numero1;
String numero2;
String numero3;
String numero4;
String numero5;
String numero6;
String numero7;

void setup() {
  Serial.begin(115200);//115200
  SerialEsp.begin(9600);
  pinMode(5, OUTPUT);
  //Serial.println();
  // Nos conectamos al WIFI;
  
  Serial.printf("Connecting to %s", ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED){
    delay(100);
    //Serial.print(".");
  }
  //Serial.println("CONNECTED");
  // final de setup
}

void loop(){
  if (SerialEsp.available() > 0){
      //Serial.println("Recibidos: ");
       String dato = SerialEsp.readStringUntil('\n');
       int index = dato.indexOf("VEL-1");
       if (index != -1){
         index += 5;
         int index2 = dato.indexOf(",", index);
         numero3 = dato.substring(index, index2);
         index2 += 1;
         int index3 = dato.indexOf(",", index2);
         numero4 = dato.substring(index2, index3);
       }

       if (numero5.toInt() == 9){
          SerialEsp.write(numero5.toInt());
          //numero7 = numero5;
       }
       if (numero5.toInt() == 2){
         SerialEsp.write(numero1.toInt());
         //numero5 = numero7;
       }
       if (numero5.toInt() == 3){
         SerialEsp.write(numero2.toInt());
         //numero5 = numero7;
       }

      
      delay(100);  
      //Serial.flush();      para limpiar el buffer 
  }    
  WiFiClient client;
 
  //Serial.printf("\n[Connecting to %s ... ", host);
  if (client.connect(host, 80)){
    //Serial.println("connected");
    
    //Serial.println("[Sending a request]");
    client.print(String("GET /ESP8266/?CON=") + numero3 + "&INC=" + numero4 + " HTTP/1.1\r\n" +
     "Host: " + host + "\r\n" + 
     "Connection: close\r\n" +
     "\r\n");

  //Serial.println("[Response:]");
  while(client.connected()){
    if(client.available()){
      String line = client.readStringUntil('\n');
      int index = line.indexOf("REF-1");
      if (index != -1){
        index += 5;
        int index2 = line.indexOf(",", index);
        numero1 = line.substring(index, index2);
        index2 += 1;
        int index3 = line.indexOf(",", index2);
        numero2 = line.substring(index2, index3);
        index3 +=1;
        int index4 = line.indexOf(",", index3);
        numero5 = line.substring(index3, index4);
        index4 +=1;
        int index5 = line.indexOf(",", index4);
        numero6 = line.substring(index4, index5);
      }
      //Serial.println(line);
      //Serial.println("Respuesta:");
      //Serial.println(numero1); 
      //Serial.println(numero2);
      //Serial.println(numero5);
      //Serial.println(numero6);
      //analogWrite(5, 0);
      //delay(100);
      //analogWrite(5, 255);
      //delay(100);
    }
  }
  client.stop();
  //Serial.println("\n[Disconnected]"); 
  }
  else{
    //Serial.println("connection failed!]");
    client.stop();
  }
  //ROJO = random(0,250);

  //Serial.println(data);
     
}
