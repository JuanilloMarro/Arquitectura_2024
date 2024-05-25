#include <SoftwareSerial.h>

SoftwareSerial bluetooth(2, 3);

const int sensorTempPin = A0;
float temperature;

void setup() {
  Serial.begin(9600);
  bluetooth.begin(9600);
}

void loop() {
  int sensorValue = analogRead(sensorTempPin);
  temperature = (sensorValue * 500.0) / 1024.0;

  // Enviar datos a través de Bluetooth
  bluetooth.print("Temperatura: ");
  bluetooth.print(temperature);
  bluetooth.println(" °C");

  delay(1000);
}