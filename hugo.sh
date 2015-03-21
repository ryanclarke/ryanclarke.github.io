#!/bin/bash

find . -iname "Thumbs.db" | xargs rm
rm -rf draft/
hugo.exe -D $@
hugo.exe $@
cp public/index.xml public/all.xml
cp public/post/index.xml public/index.xml

