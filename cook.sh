#!/bin/sh
rm -rf out/redbean
mkdir -p out/redbean
cp blobs/redbean-unsecure out/muscipula-1.0.com
mkdir -p out/redbean/.lua
cp src/chaingen.lua src/core.lua out/redbean/.lua
cp src/redbean.lua out/redbean/.init.lua
cd out/redbean
cp ../data .
zip -r ../muscipula-1.0.com .lua .init.lua data
cd ..
