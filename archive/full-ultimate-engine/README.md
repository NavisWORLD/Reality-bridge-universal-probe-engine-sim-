# Full Ultimate Engine Archive

This folder preserves the **larger 96,939-byte experimental Reality Bridge Universe Engine** created during the original engineering session, alongside the smaller repo-native playable edition at the repository root.

The full source is stored as gzip+base64 parts only to keep individual GitHub writes manageable. It is lossless.

## Reconstruct

```bash
python archive/full-ultimate-engine/materialize.py
```

Expected output:

- `REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE_FULL.html`
- bytes: `96939`
- SHA-256: `591bdbb931264e26b583747099bcc251b8161a4b62b02ed44e88b077eea2b7bc`

CI runs this reconstruction and verifies the checksum before syntax-checking the embedded JavaScript.

## Which engine should I open?

- Open `/REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE.html` for the compact, directly playable repo edition.
- Materialize this archive when you want the complete larger experimental source lineage from the original build session.
