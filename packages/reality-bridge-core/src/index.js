export const PHI=(1+Math.sqrt(5))/2;
export const clamp=(x,a=0,b=1)=>Math.max(a,Math.min(b,x));
export function hash32(s){s=String(s);let h=2166136261>>>0;for(let i=0;i<s.length;i++){h^=s.charCodeAt(i);h=Math.imul(h,16777619)}return h>>>0}
export function mulberry32(seed){let a=seed>>>0;return()=>{a|=0;a=a+0x6D2B79F5|0;let t=a;t=Math.imul(t^t>>>15,t|1);t^=t+Math.imul(t^t>>>7,t|61);return((t^t>>>14)>>>0)/4294967296}}
export const seeded=(...parts)=>mulberry32(hash32(parts.join('|')));
export function universeDNA({engineVersion='0.1.0',masterSeed='',worldSeed='',fixedStep=1/60,externalSnapshotHash='',commandHash=''}){const canonical=JSON.stringify({engineVersion,masterSeed,worldSeed,fixedStep,externalSnapshotHash,commandHash});return{canonical,hash:hash32(canonical).toString(16).padStart(8,'0')}}
export function normalizeProbePacket(p={}){return{t:Number(p.t)||Date.now(),lux:Math.max(0,Number(p.lux)||0),motion:clamp(Number(p.motion)||0),audioRms:clamp(Number(p.audioRms)||0),temperatureC:Number(p.temperatureC)||0,humidityPct:clamp((Number(p.humidityPct)||0)/100)*100,pressureHpa:Number(p.pressureHpa)||0,ppgIr:Number(p.ppgIr)||0,ppgRed:Number(p.ppgRed)||0,heading:Number(p.heading)||0}}
export class ProbeSocket{constructor(onPacket=()=>{}){this.onPacket=onPacket;this.ws=null}connect(url){this.close();this.ws=new WebSocket(url);this.ws.onmessage=e=>{try{this.onPacket(normalizeProbePacket(JSON.parse(e.data)))}catch{}};return this}close(){if(this.ws){this.ws.close();this.ws=null}}}
