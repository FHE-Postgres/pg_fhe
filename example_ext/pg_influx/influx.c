// You HAVE to include postgres first, else weird errors
#include <postgres.h>
#include <fmgr.h>
#include <funcapi.h>
#include <utils/builtins.h>
#include <stdbool.h>
#include <string.h>

// TODO Add comments

PG_MODULE_MAGIC; // Macro for info on Postgres Version

PG_FUNCTION_INFO_V1(split_pair);
Datum split_pair(PG_FUNCTION_ARGS) {
    TupleDesc tupdesc;
    char *key, *val;

    // get the return type of split_pair as declared in influx-0.1.sql 
    if (get_call_result_type(fcinfo, NULL, &tupdesc) != TYPEFUNC_COMPOSITE)
        ereport(ERROR, (errcode(ERRCODE_FEATURE_NOT_SUPPORTED),
        errmsg("function returning record called in context" "that cannot accept type record")));

        // get first arg to the function (index 0)
        // the arg is a TEXT type
        // no need to free any memory, handled for you
        key = text_to_cstring(PG_GETARG_TEXT_PP(0));
        val = strchr(key, '=');
        if (val) {
            // Datum types are used in Postgress
            // Can contain values that can be passed by value
            // or a pointer 
            Datum values[2];
            bool nulls[2] = {0};
            HeapTuple tuple;

            *val++ = '\0';
            // convert our c-strings to TEXT datum type
            values[0] = CStringGetTextDatum(key);
            values[1] = CStringGetTextDatum(val);
            // construct the tuple from its TEXT parts
            tuple = heap_form_tuple(tupdesc, values, nulls);
            PG_RETURN_DATUM(HeapTupleGetDatum(tuple));
        }
        PG_RETURN_NULL();
}
