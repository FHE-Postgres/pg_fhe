\echo Use "CREATE EXTENSION pg_fhe" to load this file. \quit

CREATE FUNCTION bfv_add_one(text)
RETURNS text LANGUAGE C AS 'MODULE_PATHNAME';
