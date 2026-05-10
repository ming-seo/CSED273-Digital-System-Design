`timescale 1ns / 1ps

module fullAdder(
    input in_a,
    input in_b,
    input in_c, // carry-in
    output out_s,
    output out_c
    );
    
    assign out_s = in_a ^ in_b ^ in_c; // sum
    assign out_c = (in_a & in_b) | ((in_a ^ in_b) & in_c); // carry-out

endmodule

// 4-Bit Comparator. If A == B, then EQ = 1 / If A != B, then EQ = 0
module Comparator(input wire [3:0] inA, input wire [3:0] inB, output wire outEQ);
    
    wire xnor_0;
    wire xnor_1;
    wire xnor_2;
    wire xnor_3;
    
    xnor(xnor_0, inA[0], inB[0]);
    xnor(xnor_1, inA[1], inB[1]);
    xnor(xnor_2, inA[2], inB[2]);
    xnor(xnor_3, inA[3], inB[3]);
    and(outEQ, xnor_0, xnor_1, xnor_2, xnor_3);
    
endmodule
