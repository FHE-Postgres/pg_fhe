cmake_minimum_required(VERSION 3.10)
project(pg_fhe)

set(CMAKE_C_STANDARD 99)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(PostgreSQL REQUIRED)
find_package(SEAL 4.1 REQUIRED)

add_library(pg_fhe MODULE src/pg_fhe.cpp)
target_include_directories(pg_fhe PRIVATE ${PostgreSQL_INCLUDE_DIRS})
target_link_libraries(pg_fhe ${PostgreSQL_LIBRARIES})
target_link_libraries(pg_fhe SEAL::seal)
set_target_properties(pg_fhe PROPERTIES PREFIX "")

