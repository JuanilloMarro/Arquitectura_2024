const five = require("johnny-five");
const Raspi = require("raspi-io");
const board = new five.Board({
  io: new Raspi()
});

board.on("ready", () => {
  const tempSensor = new five.Thermometer({
    controller: "LM35",
    pin: "P1-11",
    freq: 5000
  });

  const cooler = new five.Relay("P1-15");
  const heater = new five.Relay("P1-16");

  const tempTarget = 25.0;
  const tolerance = 2.0;

  tempSensor.on("data", () => {
    const currentTemp = tempSensor.celsius;
    console.log(`Temperatura actual: ${currentTemp}°C`);

    if (currentTemp > tempTarget + tolerance) {
      cooler.on();
      heater.off();
      console.log("Enfriando...");
    } else if (currentTemp < tempTarget - tolerance) {
      cooler.off();
      heater.on();
      console.log("Calentando...");
    } else {
      cooler.off();
      heater.off();
      console.log("Temperatura dentro del rango");
    }
  });
});