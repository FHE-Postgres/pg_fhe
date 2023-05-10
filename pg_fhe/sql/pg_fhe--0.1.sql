\echo Use "CREATE EXTENSION pg_fhe" to load this file. \quit

CREATE FUNCTION ckks_mult(bytea, float)
RETURNS bytea LANGUAGE C STRICT AS 'MODULE_PATHNAME';
