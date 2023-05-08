cmake_minimum_required(VERSION 3.10)
project(hash_cmake)

set(CMAKE_C_STANDARD 99)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(PostgreSQL REQUIRED)

add_library(hash_cmake MODULE src/hash_cmake.cpp)
target_include_directories(hash_cmake PRIVATE ${PostgreSQL_INCLUDE_DIRS})
target_link_libraries(hash_cmake ${PostgreSQL_LIBRARIES})
set_target_properties(hash_cmake PROPERTIES PREFIX "")

