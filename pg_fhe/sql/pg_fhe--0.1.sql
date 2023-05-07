\echo Use "CREATE EXTENSION pg_fhe" to load this file. \quit

CREATE FUNCTION ckks_square(bytea)
RETURNS bytea LANGUAGE C AS 'MODULE_PATHNAME';
