#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "SEAL::seal" for configuration "Release"
set_property(TARGET SEAL::seal APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(SEAL::seal PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "C;CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libseal-4.1.a"
  )

list(APPEND _cmake_import_check_targets SEAL::seal )
list(APPEND _cmake_import_check_files_for_SEAL::seal "${_IMPORT_PREFIX}/lib/libseal-4.1.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
