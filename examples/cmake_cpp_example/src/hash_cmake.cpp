// Declare c++ libraries here
#include <openssl/sha.h>
#include <iostream>
#include <cstdio>

extern "C" {
    // Declare C libraries here
    #include <postgres.h>
    #include <fmgr.h>
    #include <funcapi.h>
    #include <utils/builtins.h>

    PG_MODULE_MAGIC; // Macro for info on Postgres Version
    // takes text and returns the SHA256 digest as text
    PG_FUNCTION_INFO_V1(hash_cmake);

    Datum hash_cmake(PG_FUNCTION_ARGS) {
        unsigned char *ptext; // plaintext input
        unsigned char ctext[SHA256_DIGEST_LENGTH]; // ciphertext (hashed) output
        char ctext_str[SHA256_DIGEST_LENGTH * 2];

        // should be \0 terminated... i think
        ptext = (unsigned char *) text_to_cstring(PG_GETARG_TEXT_PP(0));
        SHA256(ptext, strlen((const char *)ptext), ctext);
        
        // convert to readable str
        for (int i = 0; i < SHA256_DIGEST_LENGTH; i++){
            sprintf(ctext_str + 2 * i, "%02x", ctext[i]);
        }
        // return pointer to ciphertext
        PG_RETURN_TEXT_P(cstring_to_text(&ctext_str[0]));
    }
} 
