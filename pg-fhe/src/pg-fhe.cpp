// Declare c++ libraries here
#include "seal/seal.h"


extern "C" {
    // Declare C libraries here
    #include <postgres.h>
    #include <fmgr.h>
    #include <funcapi.h>
    #include <utils/builtins.h>

    PG_MODULE_MAGIC; // Macro for info on Postgres Version
    PG_FUNCTION_INFO_V1(bfv_add_one);
    Datum bfv_add_one(PG_FUNCTION_ARGS) {
        // TODO unimplemented
        PG_RETURN_NULL();
    }
} 
