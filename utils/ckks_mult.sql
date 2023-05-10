CREATE TABLE test_ckks_mult as 
    SELECT id, ckks_mult(data, 2.0) as data FROM test;
