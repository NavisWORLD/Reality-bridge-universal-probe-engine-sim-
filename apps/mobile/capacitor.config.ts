import type { CapacitorConfig } from '@capacitor/cli';
const config: CapacitorConfig = {
  appId: 'world.navis.realitybridge',
  appName: 'Reality Bridge Universe',
  webDir: 'www',
  bundledWebRuntime: false,
  server: { androidScheme: 'https' }
};
export default config;
