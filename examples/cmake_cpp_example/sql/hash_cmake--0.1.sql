\echo Use "CREATE EXTENSION hash_cmake" to load this file. \quit

CREATE FUNCTION hash_cmake(text)
RETURNS text LANGUAGE C AS 'MODULE_PATHNAME';
