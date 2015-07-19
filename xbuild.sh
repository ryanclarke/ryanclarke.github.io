#!/bin/bash

cd /c/dev/GOPATH/src/github.com/spf13/hugo

go build -o hugo.exe
cp hugo.exe /c/dev/ryanclarke.github.io/xhugo.exe

