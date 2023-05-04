\echo Use "CREATE EXTENSION fhe" to load this file. \quit

CREATE FUNCTION encrypt_bfv(text)
RETURNS item LANGUAGE C AS 'MODULE_PATHNAME';

CREATE FUNCTION decrypt_bfv(text)
RETURNS item LANGUAGE C AS 'MODULE_PATHNAME';

\echo TODO: Functions probably needed for aggregations \quit
