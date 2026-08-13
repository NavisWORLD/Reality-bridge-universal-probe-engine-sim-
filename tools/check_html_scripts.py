#!/usr/bin/env python3
from __future__ import annotations
import re, subprocess, tempfile
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
FILES=[
    ROOT/'index.html',
    ROOT/'REALITY_BRIDGE_UNIVERSE_ENGINE_ULTIMATE.html',
    ROOT/'hardware/REALITY_BRIDGE_PROBE_DIGITAL_TWIN_ENGINE.html',
    ROOT/'hardware/blueprints/REALITY_BRIDGE_DEVICE_BLUEPRINT.html',
]

for html in FILES:
    text=html.read_text(encoding='utf-8')
    scripts=re.findall(r'<script(?:\s[^>]*)?>(.*?)</script>',text,re.I|re.S)
    for i,script in enumerate(scripts):
        with tempfile.NamedTemporaryFile('w',suffix='.js',delete=False,encoding='utf-8') as f:
            f.write(script)
            name=f.name
        p=subprocess.run(['node','--check',name],capture_output=True,text=True)
        if p.returncode:
            raise SystemExit(f'{html.relative_to(ROOT)} script {i} failed:\n{p.stderr}')
    print(f'OK {html.relative_to(ROOT)} ({len(scripts)} inline scripts)')
