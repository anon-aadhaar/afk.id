BUILD_DIR=./build

mkdir -p $BUILD_DIR

circom -l ../../node_modules -l ./node_modules --wasm --sym --r1cs --output ${BUILD_DIR} ./afk.circom
circom -l ../../node_modules -l ./node_modules --wasm --sym --r1cs --output ${BUILD_DIR} ./issuers/anon-aadhaar.afk.circom
