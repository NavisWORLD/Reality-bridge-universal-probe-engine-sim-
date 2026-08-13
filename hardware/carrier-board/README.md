# Reality Bridge Carrier Board v0.1

**Status: electrical/mechanical design source — not yet fabricated or bench validated.**

This custom carrier/control board keeps the ESP32-S3 DevKitC-1 as the compute, USB, RF and regulated-power module for the first physical revision. The carrier makes sensor wiring repeatable and provides I2C, I2S microphone, optional GNSS UART, optional I2C pull-ups, decoupling, test points and mounting.

Reference carrier envelope: **120 x 70 mm** with four M3 mounting holes, intended to fit inside the 150 x 90 x 34 mm reference enclosure.

The electrical contract in this folder matches firmware v0.2 exactly. Before any physical order, exact connector footprints and DevKit mechanical spacing must be confirmed in an EDA tool, design-rule checks must pass, and a small first article should be bench tested.
