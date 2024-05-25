const five = require("johnny-five");
const board = new five.Board();

board.on("ready", () => {
  const bluetooth = new five.Bluetooth({
    uuid: "LENOVO01",
    token: "acb123def456"
  });

  bluetooth.on("data", (data) => {
    const temperature = parseFloat(data.toString().split(":")[1]);
    console.log(`Temperatura: ${temperature} °C`);
  });
});