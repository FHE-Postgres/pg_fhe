cmake_minimum_required(VERSION 3.10)
project(pg-fhe)

set(CMAKE_C_STANDARD 99)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(PostgreSQL REQUIRED)
find_package(SEAL 4.1 REQUIRED)

add_library(pg-fhe MODULE src/pg-fhe.cpp)
target_include_directories(pg-fhe PRIVATE ${PostgreSQL_INCLUDE_DIRS})
target_link_libraries(pg-fhe ${PostgreSQL_LIBRARIES})
target_link_libraries(pg-fhe SEAL::seal)
set_target_properties(pg-fhe PROPERTIES PREFIX "")

