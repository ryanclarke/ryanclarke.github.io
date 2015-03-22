#!/bin/bash

outputdir=gh-pages

find . -iname "Thumbs.db" | xargs rm
find gh-pages/* \( ! -path "gh-pages/.git/*" ! -path "gh-pages/.git" \) | xargs rm -rf
hugo.exe -D $@
hugo.exe $@
cp $outputdir/index.xml $outputdir/all.xml
cp $outputdir/post/index.xml $outputdir/index.xml

