#!/bin/bash

mkdir build
cd build
cmake ..
make
mv fhe_client ..
cd ..
rm -rf build
