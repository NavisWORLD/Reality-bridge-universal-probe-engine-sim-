# Mobile wrapper

This is the Capacitor source scaffold for Android/iOS packaging.

```bash
cd apps/mobile
npm install
npx cap add android
npx cap add ios
npx cap sync
```

Open the generated native projects with Android Studio or Xcode.

For production use, copy/sync the repository web app into a dedicated `www/` directory and set `webDir` accordingly. Native iPhone distribution requires legitimate Apple signing/provisioning. Android production distribution requires the normal Android signing process.

The repository does not fabricate signing credentials or call an unsigned Apple build App-Store-ready.
