#!/usr/bin/env python3
"""يبني طبقات خريطة الأساس (land/rivers) لمنصة الأندلس من Natural Earth (ملك عام).
يقصّها على نطاق الأندلس والمغرب [-11,29,6,45] بخوارزمية Sutherland-Hodgman ويقرّب الإحداثيات.
يحتاج شبكة (يجلب من GitHub raw). ليس في CI؛ الملفات المولَّدة مُلتزَمة. انظر README.md.
المصدر: https://github.com/nvkelso/natural-earth-vector (ne_50m_land, ne_50m_rivers_lake_centerlines)."""
import urllib.request, os
BASE="https://raw.githubusercontent.com/nvkelso/natural-earth-vector/master/geojson/"
HERE=os.path.dirname(os.path.abspath(__file__))
def fetch(name):
    dst=os.path.join("/tmp", name)
    if not os.path.exists(dst):
        urllib.request.urlretrieve(BASE+name, dst)
    return dst

import json
BBOX=(-11.0,29.0,6.0,45.0)
minx,miny,maxx,maxy=BBOX
def inter_x(a,b,x):
    t=(x-a[0])/(b[0]-a[0]); return [x, a[1]+t*(b[1]-a[1])]
def inter_y(a,b,y):
    t=(y-a[1])/(b[1]-a[1]); return [a[0]+t*(b[0]-a[0]), y]
def clip_edge(poly, inside, intersect):
    out=[]; n=len(poly)
    if n==0: return out
    for i in range(n):
        cur=poly[i]; prv=poly[i-1]
        if inside(cur):
            if not inside(prv): out.append(intersect(prv,cur))
            out.append(cur)
        elif inside(prv):
            out.append(intersect(prv,cur))
    return out
def clip_ring(ring):
    poly=ring[:]
    poly=clip_edge(poly, lambda p:p[0]>=minx, lambda a,b:inter_x(a,b,minx))
    if len(poly)<3: return []
    poly=clip_edge(poly, lambda p:p[0]<=maxx, lambda a,b:inter_x(a,b,maxx))
    if len(poly)<3: return []
    poly=clip_edge(poly, lambda p:p[1]>=miny, lambda a,b:inter_y(a,b,miny))
    if len(poly)<3: return []
    poly=clip_edge(poly, lambda p:p[1]<=maxy, lambda a,b:inter_y(a,b,maxy))
    if len(poly)<3: return []
    r=[[round(x,3),round(y,3)] for x,y in poly]
    if r[0]!=r[-1]: r.append(r[0])
    return r
def clip_polygon(rings):
    out=[]
    outer=clip_ring(rings[0])
    if not outer: return None
    out.append(outer)
    for hole in rings[1:]:
        h=clip_ring(hole)
        if h: out.append(h)
    return out
def bbox_hit(coords):
    xs=[];ys=[]
    def walk(c):
        if isinstance(c[0],(int,float)): xs.append(c[0]); ys.append(c[1])
        else:
            for cc in c: walk(cc)
    walk(coords)
    return not(max(xs)<minx or min(xs)>maxx or max(ys)<miny or min(ys)>maxy)

# ---- land (clip polygons) ----
land=json.load(open(fetch('ne_50m_land.geojson')))
feats=[]
for f in land['features']:
    g=f['geometry']; t=g['type']
    if t=='Polygon':
        if not bbox_hit(g['coordinates']): continue
        cp=clip_polygon(g['coordinates'])
        if cp: feats.append({'type':'Feature','properties':{},'geometry':{'type':'Polygon','coordinates':cp}})
    elif t=='MultiPolygon':
        polys=[]
        for poly in g['coordinates']:
            if not bbox_hit(poly): continue
            cp=clip_polygon(poly)
            if cp: polys.append(cp)
        if polys: feats.append({'type':'Feature','properties':{},'geometry':{'type':'MultiPolygon','coordinates':polys}})
json.dump({'type':'FeatureCollection','features':feats}, open(os.path.join(HERE,'land.geojson'),'w'), separators=(',',':'))

# ---- rivers & lakes (bbox filter + round) ----
def round_coords(c):
    if isinstance(c[0],(int,float)): return [round(c[0],3),round(c[1],3)]
    return [round_coords(cc) for cc in c]
for name in ['rivers']:
    d=json.load(open(fetch({'rivers':'ne_50m_rivers_lake_centerlines.geojson','lakes':'ne_50m_lakes.geojson'}[name])))
    out=[]
    for f in d['features']:
        g=f['geometry']
        try:
            if not bbox_hit(g['coordinates']): continue
        except: continue
        out.append({'type':'Feature','properties':{},'geometry':{'type':g['type'],'coordinates':round_coords(g['coordinates'])}})
    json.dump({'type':'FeatureCollection','features':out}, open(os.path.join(HERE,f'{name}.geojson'),'w'), separators=(',',':'))
