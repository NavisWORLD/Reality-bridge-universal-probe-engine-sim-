# App Installation and Packaging

## Zero-build desktop/browser path

The single-file engine can be opened directly from `REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE.html`.

For browser permission-gated features and installation, serve the repository from HTTPS or localhost.

## iPhone / iPad

The lowest-friction path is an HTTPS-hosted web app added from Safari using **Share → Add to Home Screen**. Native iOS device/TestFlight/App Store distribution requires legitimate Apple signing and provisioning credentials.

## Android

Use the hosted web app, or wrap the web source with Capacitor/Android Studio. Production Play Store distribution requires the normal Android signing/release process.

## Windows / macOS / Linux

The web engine can be wrapped with Electron/Tauri or used alongside the native C++ reference path. Production Windows signing and macOS notarization require the distributor's real platform certificates.

Do not label a package signed/notarized unless that exact artifact has actually been produced with valid credentials.
