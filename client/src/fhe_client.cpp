#include "examples.h"

using namespace std;
using namespace seal;

int main() {
    // Create encryption params and keys
    EncryptionParameters params(scheme_type::ckks); 
    size_t poly_modulus_degree = 8192;
    params.set_poly_modulus_degree(poly_modulus_degree);
    params.set_coeff_modulus(CoeffModulus::Create(poly_modulus_degree, {50, 30, 50}));

    SEALContext context(params);
    print_parameters(context);
    cout << endl;

    return 0;
}
