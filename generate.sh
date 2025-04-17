#!/bin/sh
rm -f out/data
mkdir -p dataset
mkdir -p out
for i in dataset/*; do
	cat $i >> out/data
done
