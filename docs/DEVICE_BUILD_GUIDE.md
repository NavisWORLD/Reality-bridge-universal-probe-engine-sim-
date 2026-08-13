# Reality Bridge Probe v0.1 Build Guide

**Status: DESIGN TARGET — physical validation not yet published.**

1. Open `hardware/blueprints/REALITY_BRIDGE_DEVICE_BLUEPRINT.html` and inspect the top/front/side/exploded/wiring views.
2. Confirm the dimensions of the exact breakout boards you purchase.
3. Modify/print the enclosure source under `hardware/cad/`.
4. Wire the modules using `hardware/electronics/pinmap.csv` and `WIRING.md`.
5. Verify the 3.3 V rail before attaching all modules.
6. Flash the ESP32-S3 reference firmware.
7. Observe JSON packets over USB before closing the enclosure.
8. Open `hardware/REALITY_BRIDGE_PROBE_DIGITAL_TWIN_ENGINE.html` and connect the compatible local WebSocket stream.
9. Run `research/protocols/04_device_latency_accuracy.md` before changing the hardware label from DESIGN TARGET.

The v0.1 reference design intentionally avoids an internal lithium battery to reduce replication and battery-safety variables.
