\echo Use "CREATE EXTENSION influx" to load this file. \quit

CREATE TYPE item AS (key text, value text);

CREATE FUNCTION split_pair(text)
RETURNS item LANGUAGE C AS 'MODULE_PATHNAME';
