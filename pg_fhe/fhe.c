// You HAVE to include postgres first, else weird errors
#include <postgres.h>
#include <fmgr.h>
#include <funcapi.h>
#include <utils/builtins.h>
#include <stdbool.h>
#include <string.h>

PG_MODULE_MAGIC; // Macro for info on Postgres Version

PG_FUNCTION_INFO_V1(encrypt_bfv);
Datum encrypt_bfv(PG_FUNCTION_ARGS) {
    // TODO Unimplemented        
    PG_RETURN_NULL();
}

PG_FUNCTION_INFO_V1(decrypt_bfv);
Datum decrypt_bfv(PG_FUNCTION_ARGS) {
    // TODO Unimplemented        
    PG_RETURN_NULL();
}
