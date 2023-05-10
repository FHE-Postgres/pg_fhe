// Declare c++ libraries here
#include "examples.h"
#include <sstream>
#include <string>

using namespace std;
using namespace seal;

extern "C" {
    // Declare C libraries here
    #include <postgres.h>
    #include <fmgr.h>
    #include <funcapi.h>
    #include <utils/builtins.h>

    PG_MODULE_MAGIC; // Macro for info on Postgres Version

    PG_FUNCTION_INFO_V1(ckks_mult);
    Datum ckks_mult(PG_FUNCTION_ARGS) {
        
        /* Set encryption params */
        EncryptionParameters params(scheme_type::ckks); 
        size_t poly_modulus_degree = 8192;
        params.set_poly_modulus_degree(poly_modulus_degree);
        params.set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, {50, 30, 50}));
        SEALContext context(params);
        Evaluator evaluator(context); 
        double scale = pow(2.0, 30);
        CKKSEncoder encoder(context);

        // Get bytea and put in stringstream
        stringstream data_stream;
        bytea *input;
        float8 factor;
        input = PG_GETARG_BYTEA_PP(0); 
        factor = PG_GETARG_FLOAT8(1);
        size_t input_size = VARSIZE(input) - VARHDRSZ;
        char * input_data = (char *) VARDATA(input);

        data_stream.write(input_data, input_size);

        // Load relinearization keys and ciphertext
        RelinKeys rlk;
        Ciphertext encrypted;
        rlk.load(context, data_stream);
        encrypted.load(context, data_stream);

        // Compute ciphertext * 2.0
        Ciphertext encrypted_mult;
        Plaintext coeff;
        encoder.encode(factor, scale, coeff); 
        evaluator.multiply_plain(encrypted, coeff, encrypted_mult);

        // Relinearize and Rescale
        evaluator.relinearize_inplace(encrypted_mult, rlk);
        evaluator.rescale_to_next_inplace(encrypted_mult);

        // Save Result
        stringstream output_stream;
        auto size_out = encrypted_mult.save(output_stream);
        string tmp = output_stream.str();
        const char* ctmp = tmp.c_str();
        size_t len = tmp.length();

        bytea * result = (bytea *) palloc(VARHDRSZ + len);
        SET_VARSIZE(result, VARHDRSZ + len);
        memcpy(VARDATA(result), ctmp, len);
        PG_RETURN_BYTEA_P(result);
    }
} 
