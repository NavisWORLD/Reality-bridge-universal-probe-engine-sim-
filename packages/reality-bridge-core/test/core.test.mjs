import test from 'node:test';
import assert from 'node:assert/strict';
import {seeded,universeDNA,normalizeProbePacket} from '../src/index.js';

test('seeded generator is deterministic',()=>{const a=seeded('x','y'),b=seeded('x','y');for(let i=0;i<20;i++)assert.equal(a(),b())});
test('universe DNA changes with world seed',()=>assert.notEqual(universeDNA({worldSeed:'a'}).hash,universeDNA({worldSeed:'b'}).hash));
test('probe normalization clamps normalized channels',()=>{const p=normalizeProbePacket({motion:2,audioRms:-3,humidityPct:120});assert.equal(p.motion,1);assert.equal(p.audioRms,0);assert.equal(p.humidityPct,100)});
