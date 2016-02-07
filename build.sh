#!/bin/bash

outputdir=public-site
app=hugo_15.exe

find . -iname "Thumbs.db" | xargs rm
(cd $outputdir; find * \( ! -path ".git/*" ! -path ".git" \) | xargs rm -rf --) 
./$app -D $@
./$app $@
cp $outputdir/index.xml $outputdir/all.xml
cp $outputdir/post/index.xml $outputdir/index.xml

