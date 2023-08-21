pragma circom 2.0.0;

template AND() {
    signal input a;
    signal input b;
    signal output out;

    out <== a * b;// AND gate: Output is 1 if both inputs are 1, otherwise 0
}

template OR() {
    signal input a;
    signal input b;
    signal output out;

    out <== a + b - a * b;// OR gate: Output is 1 if at least one input is 1, otherwise 0
}

template NOT() {
    signal input in;
    signal output out;

    out <== 1 + in - 2 * in;// NOT gate: Output is the negation of the input (1 if input is 0, and 0 if input is 1)
}

template Zksnark1() {
    // Input signals
    signal input a;
    signal input b;

    // Intermediate signals
    signal x; // Intermediate signal to store orGate1's output
    signal y; // Intermediate signal to store notGate1's output

    // Output signal
    signal output q; // Final output signal

    // Create gates
    component andGate = AND();
    component notGate = NOT();
    component orGate = OR();

    // Connect circuit logic
    andGate.a <== a;
    andGate.b <== b;
    x <== andGate.out; //Stores andGate output in 'x'

    notGate.in <== b;
    y <== notGate.out; //Stores notGate output in 'y'

    orGate.a <== x;
    orGate.b <== y;
    q <== orGate.out * notGate.out; //Stores orGate output in 'q'
}

component main = Zksnark1(); // Instantiate the ZkSnark1 circuit