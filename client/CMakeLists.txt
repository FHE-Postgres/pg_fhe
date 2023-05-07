cmake_minimum_required(VERSION 3.10)
project(fhe_client)

find_package(SEAL 4.1 REQUIRED)
add_executable(encrypt src/encrypt.cpp)
add_executable(decrypt src/decrypt.cpp)
target_link_libraries(encrypt SEAL::seal)
target_link_libraries(decrypt SEAL::seal)

