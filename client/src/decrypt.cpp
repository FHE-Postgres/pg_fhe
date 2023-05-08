#include "examples.h"
#include <iostream>
#include <sstream>
#include <fstream>

using namespace std;
using namespace seal;

int main(int argc, char** argv) {
    // load ciphertext from file
    string filename = argv[1]; 
    // option to read or not read relinearization keys
    // if the ciphertext was computed on, set this to 0
    // else 1
    int option = stoi(argv[2]);
    
    ifstream input_file(filename, ios::binary);
    stringstream data_stream;

    if (input_file.is_open()) {
        // Copy the file content to the stringstream
        data_stream << input_file.rdbuf();
        input_file.close();
        cout << "Binary data loaded from: " << filename << endl;
    } else {
        cerr << "Unable to open file for reading." << endl;
        return 1;
    }

    // load secretkey from file
    string keyfile = "sk.bin";
    ifstream key_file(keyfile, ios::binary);
    stringstream sk_stream;

    if (key_file.is_open()) {
        // Copy the file content to the stringstream
        sk_stream << key_file.rdbuf();
        key_file.close();
        cout << "Binary data loaded from: " << keyfile << endl;
    } else {
        cerr << "Unable to open file for reading." << endl;
        return 1;
    }

    // DECRYPT
    EncryptionParameters params(scheme_type::ckks); 
    size_t poly_modulus_degree = 8192;
    params.set_poly_modulus_degree(poly_modulus_degree);
    params.set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, {50, 30, 50}));
    SEALContext context(params);
    
    // get sk from stream
    SecretKey sk;
    sk.load(context, sk_stream);
    Decryptor decryptor(context, sk);
    CKKSEncoder encoder(context);

    // get ciphertext
    Ciphertext encrypted_result;
    // TESTING remove rlk keys
    if (option) {
        RelinKeys rlk;
        rlk.load(context, data_stream);
    }
    encrypted_result.load(context, data_stream);

    // load plaintext
    Plaintext plain_result;
    decryptor.decrypt(encrypted_result, plain_result);
    vector<double> result;
    encoder.decode(plain_result, result);

    // print
    print_vector(result);

    return 0;
}
