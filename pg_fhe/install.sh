#!/bin/bash

cd build

cmake ..

make

cd ..

sudo cp ./build/pg_fhe.so $(pg_config --pkglibdir)

sudo cp ./sql/pg_fhe--0.1.sql $(pg_config --sharedir)/extension/

sudo cp ./sql/pg_fhe.control $(pg_config --sharedir)/extension/

echo " "
echo "--- --- --- --- ---"
echo "Successfully Installed pg_fhe to Postgres..."
echo "To use in your database: 'CREATE EXTENSION pg_fhe;'"
