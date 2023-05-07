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
    KeyGenerator keygen(context);
    auto sk = keygen.secret_key();
    PublicKey pk;
    keygen.create_public_key(pk);
    
    stringstream data_stream;

    // Relinearization Keys
    Serializable<RelinKeys> rlk = keygen.create_relin_keys();
    auto size_rlk = rlk.save(data_stream);

    // Encrypt
    double scale = pow(2.0, 30);
    CKKSEncoder encoder(context);
    Plaintext plain1, plain2;
    encoder.encode(2.3, scale, plain1);
    encoder.encode(4.5, scale, plain2);
    Encryptor encryptor(context, pk);
    encryptor.set_secret_key(sk); // set to secret key mode for size optimization
    auto size_encrypted = encryptor.encrypt_symmetric(plain2).save(data_stream);

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
