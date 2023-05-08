#!/bin/bash

sudo cp ./build/hash_cmake.so $(pg_config --pkglibdir)

sudo cp ./sql/hash_cmake--0.1.sql $(pg_config --sharedir)/extension/

sudo cp ./sql/hash_cmake.control $(pg_config --sharedir)/extension/

