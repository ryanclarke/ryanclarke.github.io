#!/bin/bash

outputdir=public-site

find . -iname "Thumbs.db" | xargs rm
find public-site/* \( ! -path "public-site/.git/*" ! -path "public-site/.git" \) | xargs rm -rf
# xhugo.exe -D $@
xhugo.exe $@
cp $outputdir/index.xml $outputdir/all.xml
cp $outputdir/post/index.xml $outputdir/index.xml

