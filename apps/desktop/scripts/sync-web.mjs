import {cp,mkdir,rm} from 'node:fs/promises';
import {resolve} from 'node:path';
const app=resolve(import.meta.dirname,'..');
const repo=resolve(app,'../..');
const dst=resolve(app,'www');
await rm(dst,{recursive:true,force:true});
await mkdir(dst,{recursive:true});
for(const rel of ['index.html','REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE.html','hardware']) await cp(resolve(repo,rel),resolve(dst,rel),{recursive:true});
console.log('Synced Reality Bridge web app to desktop/www');
