`timescale 1ns / 1ps

// edge trigger JKFF
module JKFF(input j, input k, input clk, input resetn, output reg q, output reg q_);  
    
    initial begin
      q = 0;
      q_ = ~q;
    end
       
    always @(posedge clk or negedge resetn) begin
        if(!resetn) begin
            q = 0;
            q_ = 1;
        end
        else begin
            q = (j&~q | ~k&q);
            q_ = ~q;
        end
    end
    
endmodule

// edge trigger DFF
module DFF(input d, input clk, output q, output q_);   
    
    JKFF DFF (d, ~d, clk, 1, q, q_);

endmodule

// 4-bit register module
module four_bit_register(input [3:0] in, input clk, output [3:0] q);
    DFF DFF0(in[0], clk, q[0]);
    DFF DFF1(in[1], clk, q[1]);
    DFF DFF2(in[2], clk, q[2]);
    DFF DFF3(in[3], clk, q[3]);
endmodule