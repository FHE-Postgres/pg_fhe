# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license.

# Exports target SEAL::seal
#
# Creates variables:
#
#   SEAL_FOUND : If either a static or a shared Microsoft SEAL was found
#   SEAL_STATIC_FOUND : If a static Microsoft SEAL library was found
#   SEAL_SHARED_FOUND : If a shared Microsoft SEAL library was found
#   SEAL_C_FOUND : If a Microsoft SEAL C export library was found
#   SEAL_VERSION : The full version number
#   SEAL_VERSION_MAJOR : The major version number
#   SEAL_VERSION_MINOR : The minor version number
#   SEAL_VERSION_PATCH : The patch version number
#   SEAL_DEBUG : Set to non-zero value if library is compiled with extra debugging code (very slow!)
#   SEAL_BUILD_TYPE : The build type (e.g., "Release" or "Debug")
#
#   SEAL_USE_CXX17 : Set to non-zero value if library is compiled as C++17 instead of C++14
#   SEAL_USE_STD_FOR_EACH_N : Set to non-zero value if library uses std::for_each_n for SEAL_ITERATE
#   SEAL_USE_STD_BYTE : Set to non-zero value if library uses seal_byte = std::byte as byte type
#   SEAL_USE_IF_CONSTEXPR : Set to non-zero value if library uses if constexpr instead of if
#   SEAL_USE_MAYBE_UNUSED : Set to non-zero value if library uses maybe_unused
#   SEAL_USE_NODISCARD : Set to non-zero value if library uses nodiscard
#
#   SEAL_THROW_ON_TRANSPARENT_CIPHERTEXT : Set to non-zero value if library is compiled with extra
#       validation code (little impact on performance)
#   SEAL_USE_GAUSSIAN_NOISE : Set to non-zero value if library is compiled to sample noise from a rounded Gaussian
#       distribution (slower) instead of a centered binomial distribution (faster)
#   SEAL_AVOID_BRANCHING : Set to non-zero value if library is compiled to eliminate branching in critical conditional move operations.
#   SEAL_DEFAULT_PRNG : The default choice of PRNG (e.g., "Blake2xb" or "Shake256")
#
#   SEAL_USE_MSGSL : Set to non-zero value if library is compiled with Microsoft GSL support
#   SEAL_USE_ZLIB : Set to non-zero value if library is compiled with ZLIB support
#   SEAL_USE_ZSTD : Set to non-zero value if library is compiled with Zstandard support
#   SEAL_USE_INTEL_HEXL: Set to non-zero value if library is compiled with Intel HEXL support
#   SEAL_CARRY_DEPS : Set to non-zero value if library is configured with SEAL_BUILD_DEPS=ON and carries dependencies


####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was SEALConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

include(CMakeFindDependencyMacro)

macro(seal_find_dependency dep)
    find_dependency(${dep})
    if(NOT ${dep}_FOUND)
        if(NOT SEAL_FIND_QUIETLY)
            message(WARNING "Could not find dependency `${dep}` required by this configuration")
        endif()
        set(SEAL_FOUND FALSE)
        return()
    endif()
endmacro()

set(SEAL_FOUND FALSE)
set(SEAL_STATIC_FOUND FALSE)
set(SEAL_SHARED_FOUND FALSE)
set(SEAL_C_FOUND FALSE)
set(SEAL_VERSION 4.1.1)
set(SEAL_VERSION_MAJOR 4)
set(SEAL_VERSION_MINOR 1)
set(SEAL_VERSION_PATCH 1)
set(SEAL_DEBUG OFF)
set(SEAL_BUILD_TYPE Release)

set(SEAL_USE_CXX17 ON)
set(SEAL_USE_STD_FOR_EACH_N ON)
set(SEAL_USE_STD_BYTE ON)
set(SEAL_USE_IF_CONSTEXPR ON)
set(SEAL_USE_MAYBE_UNUSED ON)
set(SEAL_USE_NODISCARD ON)

set(SEAL_THROW_ON_TRANSPARENT_CIPHERTEXT ON)
set(SEAL_USE_GAUSSIAN_NOISE OFF)
set(SEAL_AVOID_BRANCHING OFF)
set(SEAL_DEFAULT_PRNG Blake2xb)

set(SEAL_USE_MSGSL ON)
set(SEAL_USE_ZLIB ON)
set(SEAL_USE_ZSTD ON)
set(SEAL_USE_INTEL_HEXL OFF)
set(SEAL_CARRY_DEPS ON)

# If SEAL does not carry dependencies, we must look for them
if(NOT SEAL_CARRY_DEPS)
    if(SEAL_USE_MSGSL)
        seal_find_dependency(Microsoft.GSL)
    endif()
    if(SEAL_USE_ZLIB)
        seal_find_dependency(ZLIB)
    endif()
    if(SEAL_USE_ZSTD)
        seal_find_dependency(zstd)
        if(NOT TARGET zstd::libzstd_static)
            if(TARGET libzstd)
                get_target_property(libzstd_type libzstd TYPE)
                if(libzstd_type STREQUAL "SHARED")
                    set(zstd_static "libzstd")
                else()
                    message(FATAL_ERROR "ZSTD must be static")
                endif()
            endif()
        endif()
    endif()
    if(SEAL_USE_INTEL_HEXL)
        seal_find_dependency(HEXL)
    endif()
endif()

# Add the current directory to the module search path
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

set(CMAKE_THREAD_PREFER_PTHREAD TRUE)
set(THREADS_PREFER_PTHREAD_FLAG TRUE)
seal_find_dependency(Threads)

include(${CMAKE_CURRENT_LIST_DIR}/SEALTargets.cmake)

if(TARGET SEAL::seal)
    set(SEAL_FOUND TRUE)
    set(SEAL_STATIC_FOUND TRUE)
endif()

if(TARGET SEAL::seal_shared)
    set(SEAL_FOUND TRUE)
    set(SEAL_SHARED_FOUND TRUE)
endif()

if(TARGET SEAL::sealc)
    set(SEAL_FOUND TRUE)
    set(SEAL_C_FOUND TRUE)
endif()

if(SEAL_FOUND)
    if(NOT SEAL_FIND_QUIETLY)
        message(STATUS "Microsoft SEAL -> Version ${SEAL_VERSION} detected")
    endif()
    if(SEAL_DEBUG AND NOT SEAL_FIND_QUIETLY)
        message(STATUS "Performance warning: Microsoft SEAL compiled in debug mode")
    endif()
    set(SEAL_TARGETS_AVAILABLE "Microsoft SEAL -> Targets available:")

    if(SEAL_STATIC_FOUND)
        string(APPEND SEAL_TARGETS_AVAILABLE " SEAL::seal")
    endif()
    if(SEAL_SHARED_FOUND)
        string(APPEND SEAL_TARGETS_AVAILABLE " SEAL::seal_shared")
    endif()
    if(SEAL_C_FOUND)
        string(APPEND SEAL_TARGETS_AVAILABLE " SEAL::sealc")
    endif()
    if(NOT SEAL_FIND_QUIETLY)
        message(STATUS ${SEAL_TARGETS_AVAILABLE})
    endif()
else()
    if(NOT SEAL_FIND_QUIETLY)
        message(STATUS "Microsoft SEAL -> NOT FOUND")
    endif()
endif()
