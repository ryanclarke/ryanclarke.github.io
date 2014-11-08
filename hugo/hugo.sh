#!/bin/bash

find . -iname "Thumbs.db" | xargs rm
rm -rf draft/
$(dirname $0)/hugo.exe -D $@
$(dirname $0)/hugo.exe $@
cp index.xml all.xml
cp post/index.xml index.xml

