pragma circom 2.1.6;

include "@anon-aadhaar/circuits/src/aadhaar-verifier.circom";
include "circomlib/circuits/poseidon.circom";

template AFKAadhaarVerifier(n, k, maxDataLength) {
    signal input qrDataPadded[maxDataLength];
    signal input qrDataPaddedLength;
    signal input nonPaddedDataLength;
    signal input delimiterIndices[18];
    signal input signature[k];
    signal input pubKey[k];

    // Public inputs
    signal input signalHash;
    signal input secret;

    signal output pubkeyHash;
    signal output nullifier;
    signal output timestamp;
    signal output ageAbove18Hash;
    signal output genderHash;
    signal output stateHash;
    signal output pinCodeHash;
    
    signal output secretHash;

    component aadhaarVerifier = AadhaarVerifier(n, k, maxDataLength); 
    aadhaarVerifier.qrDataPadded <== qrDataPadded;
    aadhaarVerifier.qrDataPaddedLength <== qrDataPaddedLength;
    aadhaarVerifier.nonPaddedDataLength <== nonPaddedDataLength;
    aadhaarVerifier.delimiterIndices <== delimiterIndices;
    aadhaarVerifier.signature <== signature;
    aadhaarVerifier.pubKey <== pubKey;
    aadhaarVerifier.nullifierSeed <== 999111;
    aadhaarVerifier.signalHash <== signalHash;
    aadhaarVerifier.revealAgeAbove18 <== 1;
    aadhaarVerifier.revealGender <== 1;
    aadhaarVerifier.revealState <== 1;
    aadhaarVerifier.revealPinCode <== 1;

    pubkeyHash <== aadhaarVerifier.pubkeyHash;
    nullifier <== aadhaarVerifier.nullifier;
    timestamp <== aadhaarVerifier.timestamp;
    ageAbove18Hash <== Poseidon(2)([aadhaarVerifier.ageAbove18, secret]);
    genderHash <== Poseidon(2)([aadhaarVerifier.gender, secret]);
    stateHash <== Poseidon(2)([aadhaarVerifier.state, secret]);
    pinCodeHash <== Poseidon(2)([aadhaarVerifier.pinCode, secret]);

    secretHash <== Poseidon(1)([secret]);

}

component main { public [signalHash] } = AFKAadhaarVerifier(121, 17, 512 * 3);
