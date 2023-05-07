cmake_minimum_required(VERSION 3.10)
project(fhe_client)

find_package(SEAL 4.1 REQUIRED)
add_executable(fhe_client src/fhe_client.cpp)
target_link_libraries(fhe_client SEAL::seal)

