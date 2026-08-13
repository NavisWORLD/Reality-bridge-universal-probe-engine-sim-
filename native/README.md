# Native Reality Bridge Reference

This directory contains a compact reproducible native path alongside the browser engine.

## C++20 deterministic headless simulation

```bash
cmake -S native -B native/build
cmake --build native/build --config Release
./native/build/reality_bridge_headless
```

The smoke executable runs a fixed 60 Hz world update, deterministic named-world generation, gravity movement and a 54-channel state update. It prints `REALITY BRIDGE HEADLESS OK` on success.

## Python live-data bridge

```bash
export NASA_API_KEY=YOUR_KEY   # optional; DEMO_KEY is used otherwise
python native/python/live_bridge.py
```

It writes an atomic `runtime/live_context.json` snapshot containing NASA APOD/NEO and USGS context when available.

External public data is treated as a timestamped/context input to authored software behavior, not physical causation.
