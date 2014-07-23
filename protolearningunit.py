#!/usr/bin/env python


import subprocess
from subprocess import call
import sys
import json

def generateIgnoreFile():
    ignored = []
    with open(".gitignore") as f:
        ignored = [l[:-1] for l in f.readlines()]
    with open("bower.json") as f:
        bowerJson = json.load(f)
        for name,v in iter(sorted(bowerJson["dependencies"].items())):
            if not( name in ignored or (name+"/") in ignored):
                print("Adding: "+name)
                with open(".gitignore", "a") as ignoreFile:
                    ignoreFile.write(name+"/\n")

import os
import os.path
def moveAway(f):
    assert os.path.exists(f)
    to = f+".old"
    if os.path.exists(to):
        moveAway(to)
    os.rename(f, to)

def bowerJson():
    with open("bower.json") as f:
        return json.load(f)

def bowerList():
    p = subprocess.Popen(['bower', 'list', '-json'], stdout=subprocess.PIPE)
    output = p.communicate()[0]
    return json.loads(output)

def startEditing(args):
    assert len(args) == 1
    what = args[0]
    ok = False
    bJson = bowerJson()
    if not what in bJson["dependencies"]:
        print(what+" is not a dependency (according to bower.json)")
        return
    name = what
    bList = bowerList()
    url = bList["dependencies"][what]["pkgMeta"]["_source"]
    del bJson["dependencies"][what]
    with open("bower.json", "w") as fo:
        json.dump(bJson, fo, indent=2, sort_keys=True)
    moveAway(what)
    call(["git", "clone", url, name])

### 

if len(sys.argv) == 1:
    print("USAGE: TODO")
    exit(0)

c=sys.argv[1]
if c == "build":
    call("jekyll build --plugins template/_plugins --layouts template/_layouts --config template/_config.yml".split(" "))
elif c == "ignore":
    generateIgnoreFile()
elif c == "edit":
    startEditing(sys.argv[2:])
else:
    call(["bower"] + sys.argv[1:])
