#!/usr/bin/env python


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

if len(sys.argv) == 1:
    print("USAGE: TODO")
    exit(0)

c=sys.argv[1]
if c == "build":
    call("jekyll build --plugins template/_plugins --layouts template/_layouts --config template/_config.yml".split(" "))
elif c == "ignore":
    generateIgnoreFile()
else:
    call(["bower"] + sys.argv[1:])
