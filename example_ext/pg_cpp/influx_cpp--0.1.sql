\echo "this is a comment" \quit
\echo Use "CREATE EXTENSION influx" to load this file. \quit

CREATE TYPE item_cpp AS (key text, value text);

CREATE FUNCTION split_pair_cpp(text)
RETURNS item_cpp LANGUAGE C AS 'MODULE_PATHNAME';

\echo "Lets try to make a function which takes some text and outputs the SHA256 hash" \quit

CREATE FUNCTION influx_sha(text)
RETURNS text LANGUAGE C AS 'MODULE_PATHNAME';
