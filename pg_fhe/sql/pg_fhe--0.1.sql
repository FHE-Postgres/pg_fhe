\echo Use "CREATE EXTENSION pg_fhe" to load this file. \quit

\echo TODO add extra float parameter to ckks_mult \quit
CREATE FUNCTION ckks_mult(bytea, float)
RETURNS bytea LANGUAGE C STRICT AS 'MODULE_PATHNAME';
