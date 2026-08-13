# Reality Bridge Reference Probe v0.1

**Status: DESIGN TARGET — NOT YET PHYSICALLY VALIDATED.**

Visualize the device first:

- [`REALITY_BRIDGE_PROBE_DIGITAL_TWIN_ENGINE.html`](REALITY_BRIDGE_PROBE_DIGITAL_TWIN_ENGINE.html)
- [`blueprints/REALITY_BRIDGE_DEVICE_BLUEPRINT.html`](blueprints/REALITY_BRIDGE_DEVICE_BLUEPRINT.html)

Reference modules:

- ESP32-S3 controller / Wi-Fi / USB
- ICM-42688-P 6-axis IMU
- BH1750 ambient-light sensor
- BME280 temperature/humidity/pressure sensor
- optional MAX30102 optical waveform module
- INMP441 I²S microphone
- optional GNSS UART module

Reference data path:

```text
sensors → ESP32-S3 → normalized JSON
                    ├─ USB serial
                    └─ local WebSocket :81
                             ↓
                      Reality Bridge
                             ↓
                      Universe Engine
```

The optical channel is not a medical diagnostic device.
