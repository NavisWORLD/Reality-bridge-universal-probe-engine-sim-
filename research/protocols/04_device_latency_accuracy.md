# Protocol 04 — Reality Bridge Probe hardware qualification

**Status: PROPOSED TEST — NOT YET RUN**

## Goal

Determine whether physically assembled v0.1 probes meet declared electrical, thermal, packet-delivery and sensor-response criteria.

## Units

Build at least three independent assemblies if possible.

## Tests

1. Measure idle and active-stream supply current.
2. Run a 60-minute thermal test and record MCU/regulator/sensor temperatures where measurable.
3. Measure packet rate and loss over USB serial and local WebSocket.
4. Measure end-to-end latency from stimulus timestamp to simulator receipt.
5. Compare BH1750 lux response against a reference meter across multiple levels.
6. Compare BME280 environmental values against a reference instrument.
7. Measure IMU static noise and repeated-motion response.
8. Measure microphone response to a repeatable acoustic stimulus once the I²S RMS adapter is implemented.
9. Measure MAX30102 raw optical-waveform repeatability only; do not infer medical accuracy.

## Before collecting final data

Predeclare latency target, packet-loss target and calibration acceptance bands. Preserve failures and null results.
