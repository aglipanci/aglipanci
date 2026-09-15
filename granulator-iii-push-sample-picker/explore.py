import json, sys, re
def walk(patcher, path=""):
    """yield (path, patcher) for a patcher and all nested subpatchers."""
    yield path, patcher
    for b in patcher["boxes"]:
        bx=b["box"]
        if "patcher" in bx:
            yield from walk(bx["patcher"], path+"/"+(bx.get("text") or bx["maxclass"])+f"[{bx['id']}]")
def desc(bx):
    t=bx.get("text") or bx["maxclass"]
    v=bx.get("saved_attribute_attributes",{}).get("valueof",{}).get("parameter_longname")
    vn=bx.get("varname")
    return f"{t}" + (f" <param {v}>" if v else "") + (f" @{vn}" if vn else "")
def neighborhood(patcher, path, pat):
    boxes={b["box"]["id"]:b["box"] for b in patcher["boxes"]}
    hits=[i for i,bx in boxes.items() if re.search(pat, desc(bx))]
    for h in hits:
        print(f"\n### {path} :: {h} = {desc(boxes[h])}")
        for l in patcher["lines"]:
            (s,so),(d,di)=l["patchline"]["source"],l["patchline"]["destination"]
            if d==h: print(f"   IN  [{di}] <- {s} {desc(boxes[s])} [{so}]")
        for l in patcher["lines"]:
            (s,so),(d,di)=l["patchline"]["source"],l["patchline"]["destination"]
            if s==h: print(f"   OUT [{so}] -> {d} {desc(boxes[d])} [{di}]")
if __name__=="__main__":
    doc=json.load(open(sys.argv[1])); pat=sys.argv[2]
    for path,p in walk(doc["patcher"]): neighborhood(p,path,pat)
