CREATE TABLE test_ckks_mult as 
    SELECT id, ckks_mult(data) as data FROM test;
