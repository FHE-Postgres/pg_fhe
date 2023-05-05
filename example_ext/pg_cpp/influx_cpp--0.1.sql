\echo Use "CREATE EXTENSION influx" to load this file. \quit

CREATE TYPE item_cpp AS (key text, value text);

CREATE FUNCTION split_pair_cpp(text)
RETURNS item_cpp LANGUAGE C AS 'MODULE_PATHNAME';
