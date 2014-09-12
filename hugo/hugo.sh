#!/bin/bash

find . -iname "Thumbs.db" | xargs rm
$(dirname $0)/hugo.exe $@
cp index.xml all.xml
cp post/index.xml index.xml

