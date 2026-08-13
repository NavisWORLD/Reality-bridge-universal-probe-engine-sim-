# Reality Bridge Universal Probe + Universe Engine

**Open simulation engine · interactive hardware digital twin · open probe reference design · reproducibility laboratory**

This repository is the public full-disclosure engineering home for the Reality Bridge / SIM EARTH / Universe Engine branch of the project.

## Start here

- **Visual project portal:** [`index.html`](index.html)
- **Working single-file Universe Engine:** [`REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE.html`](REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE.html)
- **Interactive Reality Bridge device digital twin:** [`hardware/REALITY_BRIDGE_PROBE_DIGITAL_TWIN_ENGINE.html`](hardware/REALITY_BRIDGE_PROBE_DIGITAL_TWIN_ENGINE.html)
- **Interactive fabrication blueprint lab:** [`hardware/blueprints/REALITY_BRIDGE_DEVICE_BLUEPRINT.html`](hardware/blueprints/REALITY_BRIDGE_DEVICE_BLUEPRINT.html)

The visual files are ordinary self-contained HTML/CSS/JavaScript and require no framework just to open.

## What the HTML engine contains

The repo-native engine includes deterministic procedural worlds, orbit and surface render modes, gravity-scaled movement, world folding, biosphere growth, life seeding, outposts, storms, anomalies, time warp, a live 54-channel computational state display, and an integrated Reality Bridge device mode with an explodable internal hardware model.

## Reality Bridge Probe v0.1

**Physical status: DESIGN TARGET — NOT YET PHYSICALLY VALIDATED.**

Reference envelope: **150 × 90 × 34 mm**, nominal **2.4 mm** wall, USB-C development power.

Reference modules:

- ESP32-S3 DevKitC-1 or compatible
- ICM-42688-P 6-axis IMU
- BH1750 ambient-light sensor
- BME280 temperature/humidity/pressure sensor
- optional MAX30102 optical waveform module, **not medical**
- INMP441 I²S microphone
- optional GNSS UART module

The exact breakout dimensions and electrical properties of purchased modules must be checked before fabrication.

## Evidence labels

- **IMPLEMENTED** — source/design artifact exists in this repository.
- **SOFTWARE-TESTED** — stated software path has been executed or syntax-validated.
- **DESIGN TARGET** — an engineering design is specified but has not yet been physically validated.
- **PROPOSED TEST — NOT YET RUN** — experimental protocol exists, no result is implied.
- **SIMULATION/METAPHOR** — conceptual/game representation rather than a literal physical claim.

## Scientific boundary

NASA/USGS/phone/probe observations may condition authored simulation behavior. That does **not** establish that those observations physically cause a simulated black hole, anomaly, biosphere, weather event, or other in-engine object. The project’s **12D → 42D → 54D** labels describe computational state channels, not proof of extra spacetime dimensions.

See [`docs/SCIENTIFIC_BOUNDARIES.md`](docs/SCIENTIFIC_BOUNDARIES.md) and [`research/`](research/).
