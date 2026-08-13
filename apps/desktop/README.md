# Desktop Packaging

The desktop wrapper uses Electron and copies the visual web app into a self-contained `www/` directory before launch or packaging.

```bash
cd apps/desktop
npm install
npm start
```

Build local packages:

```bash
npm run dist
```

Configured targets:

- Windows: NSIS installer + portable executable
- macOS: DMG + ZIP application bundle
- Linux: AppImage

Production code signing/notarization is not fabricated by this repository. Distributors should configure their legitimate Windows/macOS certificates for trusted public distribution.
