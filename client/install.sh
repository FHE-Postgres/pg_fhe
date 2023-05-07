#!/bin/bash

mkdir build
cd build
cmake ..
make
mv encrypt decrypt ..
cd ..
rm -rf build
