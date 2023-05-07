// Declare c++ libraries here
#include "seal/seal.h"

using namespace std;
using namespace seal;

extern "C" {
    // Declare C libraries here
    #include <postgres.h>
    #include <fmgr.h>
    #include <funcapi.h>
    #include <utils/builtins.h>

    PG_MODULE_MAGIC; // Macro for info on Postgres Version

    PG_FUNCTION_INFO_V1(bfv_add_one);
    Datum bfv_add_one(PG_FUNCTION_ARGS) {
        
        /* Set encryption params */
        EncryptionParameters params(scheme_type::bfv);
        size_t poly_modulus_degree = 4096;
        params.set_poly_modulus_degree(poly_modulus_degree);
        params.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));
        params.set_plain_modulus(1024);
        SEALContext context(params);
        
        // TODO unimplemented
        PG_RETURN_NULL();
    }
} 
