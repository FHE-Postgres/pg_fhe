#!/bin/bash

sudo cp ./build/pg-fhe.so $(pg_config --pkglibdir)

sudo cp ./sql/pg-fhe--0.1.sql $(pg_config --sharedir)/extension/

sudo cp ./sql/pg-fhe.control $(pg_config --sharedir)/extension/

