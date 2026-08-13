const CACHE='reality-bridge-v0.1';
const SHELL=['./','./index.html','./REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE.html','./hardware/REALITY_BRIDGE_PROBE_DIGITAL_TWIN_ENGINE.html','./hardware/blueprints/REALITY_BRIDGE_DEVICE_BLUEPRINT.html','./manifest.webmanifest','./icons/reality-bridge.svg'];
self.addEventListener('install',e=>e.waitUntil(caches.open(CACHE).then(c=>c.addAll(SHELL)).then(()=>self.skipWaiting())));
self.addEventListener('activate',e=>e.waitUntil(caches.keys().then(keys=>Promise.all(keys.filter(k=>k!==CACHE).map(k=>caches.delete(k)))).then(()=>self.clients.claim())));
self.addEventListener('fetch',e=>{if(e.request.method!=='GET')return;const u=new URL(e.request.url);if(u.origin!==location.origin)return;e.respondWith(caches.match(e.request).then(hit=>hit||fetch(e.request).then(r=>{const copy=r.clone();caches.open(CACHE).then(c=>c.put(e.request,copy));return r}))) });
