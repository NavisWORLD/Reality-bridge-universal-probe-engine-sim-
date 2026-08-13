#!/usr/bin/env python3
from __future__ import annotations
import base64, gzip, hashlib
from pathlib import Path

HERE=Path(__file__).resolve().parent
EXPECTED='591bdbb931264e26b583747099bcc251b8161a4b62b02ed44e88b077eea2b7bc'
parts=sorted(HERE.glob('part-*.b64'))
if not parts:
    raise SystemExit('No payload parts found')
b64=''.join(p.read_text(encoding='ascii').strip() for p in parts)
data=gzip.decompress(base64.b64decode(b64))
sha=hashlib.sha256(data).hexdigest()
if sha!=EXPECTED:
    raise SystemExit(f'SHA-256 mismatch: {sha} != {EXPECTED}')
out=HERE/'REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE_FULL.html'
out.write_bytes(data)
print(f'OK {out} bytes={len(data)} sha256={sha}')
