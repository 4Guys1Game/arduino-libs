#!/bin/bash

for i in libs/* ; do
	if [ -d "$i" ]; then
		cd "$i" # We're inside the folder now
		rm -rf build
		cmake -B build
		cmake --build build
		cmake --install build
		cd "../.." # We're back at the root
	fi
done
