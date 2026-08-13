# Reality Bridge Probe v0.1 Wiring

**Status: DESIGN TARGET — bench validation pending.**

## Shared I²C bus

Use ESP32-S3 GPIO 8 for SDA and GPIO 9 for SCL to the ICM-42688-P, BH1750, BME280 and optional MAX30102 breakout modules.

Connect all grounds. Use the board's 3.3 V rail only where the selected breakout supports 3.3 V operation. Verify the actual breakout's onboard regulator and pull-ups before wiring.

## I²S microphone

- GPIO 12 → INMP441 SCK/BCLK
- GPIO 13 → INMP441 WS/LRCLK
- GPIO 14 ← INMP441 SD
- shared 3.3 V and GND

## Optional GNSS

- GPIO 17 RX ← GNSS TX
- GPIO 18 TX → GNSS RX

## Power

The reference v0.1 design uses USB-C 5 V through the ESP32-S3 development board and intentionally omits a built-in battery.

## Safety boundary

This is low-voltage prototype electronics. It is not certified medical, automotive, aerospace, life-support or mains equipment. The optical waveform path is not for diagnosis or emergency decisions.
