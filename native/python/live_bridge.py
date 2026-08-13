#!/usr/bin/env python3
"""Reality Bridge live context adapter.

Fetches NASA APOD / NEO context and USGS earthquake context and writes one
atomic JSON snapshot. External observations are context inputs to authored
simulation behavior, not evidence of physical causation.
"""
from __future__ import annotations
import json, os, tempfile, time, urllib.parse, urllib.request
from pathlib import Path

NASA='https://api.nasa.gov'
USGS='https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_day.geojson'

def get_json(url, timeout=15):
    req=urllib.request.Request(url,headers={'User-Agent':'RealityBridge/0.1'})
    with urllib.request.urlopen(req,timeout=timeout) as r:
        return json.loads(r.read().decode('utf-8'))

def nasa(path, **params):
    params['api_key']=os.environ.get('NASA_API_KEY','DEMO_KEY')
    return get_json(f"{NASA}{path}?{urllib.parse.urlencode(params)}")

def snapshot():
    out={'updated_ms':int(time.time()*1000),'errors':[]}
    try:
        a=nasa('/planetary/apod')
        out['apod']={'title':a.get('title',''),'media_type':a.get('media_type',''),'url':a.get('url',''),'date':a.get('date','')}
    except Exception as e: out['errors'].append(f'apod:{e}')
    try:
        n=nasa('/neo/rest/v1/feed',start_date=time.strftime('%Y-%m-%d'))
        out['neo_count']=sum(len(v) for v in n.get('near_earth_objects',{}).values())
    except Exception as e: out['errors'].append(f'neo:{e}')
    try:
        q=get_json(USGS)
        feats=q.get('features',[])
        out['latest_quake_magnitude']=float(feats[0].get('properties',{}).get('mag') or 0) if feats else 0
    except Exception as e: out['errors'].append(f'usgs:{e}')
    return out

def atomic_write(path:Path,data):
    path.parent.mkdir(parents=True,exist_ok=True)
    fd,tmp=tempfile.mkstemp(prefix=path.name+'.',dir=path.parent)
    try:
        with os.fdopen(fd,'w',encoding='utf-8') as f: json.dump(data,f,indent=2,sort_keys=True)
        os.replace(tmp,path)
    finally:
        if os.path.exists(tmp): os.unlink(tmp)

if __name__=='__main__':
    target=Path(os.environ.get('REALITY_BRIDGE_LIVE_JSON','runtime/live_context.json'))
    data=snapshot();atomic_write(target,data);print(json.dumps(data,indent=2))
