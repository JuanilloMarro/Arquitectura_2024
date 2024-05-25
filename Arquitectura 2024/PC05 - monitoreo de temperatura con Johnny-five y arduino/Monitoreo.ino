#include <SoftwareSerial.h>

SoftwareSerial bluetooth(2, 3);

const int sensorTempPin = A0;
float temperature;
float tempMax = 25.0; // Temperatura máxima
float tempMin = 20.0; // Temperatura mínima

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

  // Monitorear la temperatura
  if (temperature > tempMax) {
    bluetooth.println("Temperatura fuera de rango (alta)");
  } else if (temperature < tempMin) {
    bluetooth.println("Temperatura fuera de rango (baja)");
  } else {
    bluetooth.println("Temperatura dentro del rango");
  }

  delay(1000);
}