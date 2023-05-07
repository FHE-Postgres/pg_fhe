#include "examples.h"
#include <iostream>
#include <sstream>
#include <fstream>

using namespace std;
using namespace seal;

int main() {
    // Create encryption params and keys
    EncryptionParameters params(scheme_type::ckks); 
    size_t poly_modulus_degree = 8192;
    params.set_poly_modulus_degree(poly_modulus_degree);
    params.set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, {50, 30, 50}));
    SEALContext context(params);
    /*
    print_parameters(context);
    cout << endl;
    */
    stringstream sk_stream;

    KeyGenerator keygen(context);
    auto sk = keygen.secret_key();
    PublicKey pk;
    keygen.create_public_key(pk);

    sk.save(sk_stream);
    
    string keyfile = "sk.bin";
    ofstream key_file(keyfile, ios::binary);

    if (key_file.is_open()) {
        // Copy the stringstream content to the file
        key_file << sk_stream.rdbuf();
        key_file.close();

        cout << "Secret Key data saved to: " << keyfile << endl;
    } else {
        cerr << "Unable to open file for writing." << endl;
        return 1;
    }

    stringstream data_stream;
    // Relinearization Keys
    Serializable<RelinKeys> rlk = keygen.create_relin_keys();
    auto size_rlk = rlk.save(data_stream);

    // Encrypt
    double scale = pow(2.0, 30);
    CKKSEncoder encoder(context);
    Plaintext plain;
    encoder.encode(4.5, scale, plain);
    Encryptor encryptor(context, pk);
    encryptor.set_secret_key(sk); // set to secret key mode for size optimization
    auto size_encrypted = encryptor.encrypt_symmetric(plain).save(data_stream);

    // save datastream to file
    // Now, save the stringstream to a file
    string filename = "ciphertext.bin";
    ofstream output_file(filename, ios::binary);

    if (output_file.is_open()) {
        // Copy the stringstream content to the file
        output_file << data_stream.rdbuf();
        output_file.close();

        cout << "Binary data saved to: " << filename << endl;
    } else {
        cerr << "Unable to open file for writing." << endl;
        return 1;
    }

    return 0;
}
