\echo Use "CREATE EXTENSION pg_fhe" to load this file. \quit

\echo TODO add extra integer parameter to ckks_mult \quit
CREATE FUNCTION ckks_mult(bytea)
RETURNS bytea LANGUAGE C AS 'MODULE_PATHNAME';
