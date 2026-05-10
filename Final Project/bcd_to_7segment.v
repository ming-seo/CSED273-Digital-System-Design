// 0(0000), 1(0001), 2(0010), 3(0011), 4(0100), 5/S(0101), 6(0110), 7(0111)
// 8(1000), 9(1001), A(1010), b(1011), E(1100), r(1101), t(1110), U/V(1111)

module bcd_to_7segment (
    input [3:0] bcd, // Input -> 4-Bit number
    output reg [7:0] seg // Output -> 7segment's bit number
);

  always @(*) begin
    // dot, center, tl, bl, b, br, tr, t
    case (bcd)
      4'b0000: seg = 8'b11000000;  // 0
      4'b0001: seg = 8'b11111001;  // 1
      4'b0010: seg = 8'b10100100;  // 2
      4'b0011: seg = 8'b10110000;  // 3
      4'b0100: seg = 8'b10011001;  // 4
      4'b0101: seg = 8'b10010010;  // 5(S)
      4'b0110: seg = 8'b10000010;  // 6
      4'b0111: seg = 8'b11111000;  // 7
      4'b1000: seg = 8'b10000000;  // 8
      4'b1001: seg = 8'b10010000;  // 9
      4'b1010: seg = 8'b10001000;  // A
      4'b1011: seg = 8'b10000011;  // b
      4'b1100: seg = 8'b10000110;  // E
      4'b1101: seg = 8'b10101111;  // r
      4'b1110: seg = 8'b10000111;  // t
      4'b1111: seg = 8'b11000001;  // V(U)
      default: seg = 8'b11111111;  // off
    endcase
  end
endmodule