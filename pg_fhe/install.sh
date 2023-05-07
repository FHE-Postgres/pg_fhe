#!/bin/bash

# cmake and build
mkdir build
cd build
cmake ..
make
cd ..

# installing to postgres
sudo cp ./build/pg_fhe.so $(pg_config --pkglibdir)
sudo cp ./sql/pg_fhe--0.1.sql $(pg_config --sharedir)/extension/
sudo cp ./sql/pg_fhe.control $(pg_config --sharedir)/extension/

# cleanup
rm -rf build

echo " "
echo "--- --- --- --- ---"
echo "Successfully Installed pg_fhe to Postgres..."
echo "To use in your database: 'CREATE EXTENSION pg_fhe;'"
