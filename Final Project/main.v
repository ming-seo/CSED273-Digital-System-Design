`timescale 1ns / 1ps

// Main module
module main(
    input btnCenter,    // idle state
    input btnTop, // print_save state
    input btnBottom, // print_res state
    input btnLeft,            // set state
    input btnRight,           // play state
    input clk,
    input wire [11:0] sw, // switch
    output [3:0] ssSel,
    output [7:0] ssDisp
);
    
    // State parameters
   parameter idle = 3'b000;
   parameter set = 3'b001;
   parameter print_save = 3'b010;
   parameter play = 3'b011;
   parameter print_res = 3'b100;
       
    wire fsm_clk;
    reg [2:0] state;
    reg [3:0] bcd;
    wire [3:0] num1, num2, num3;
    wire [3:0] user1, user2, user3;
    wire [3:0] ssSel0, ssSel1, ssSel2, ssSel3, ssSel4;
    wire [7:0] ssDisp0 ,ssDisp1, ssDisp2, ssDisp3, ssDisp4;
        
    // Generate fsm_clk signal based on switches
    assign fsm_clk = sw[0]|sw[1]|sw[2]|sw[3]|sw[4]|sw[5]|sw[6]|sw[7]|sw[8]|sw[9]|sw[10]|sw[11];
    
    // Generate ssSel and ssDisp based on the current state
    assign ssSel[3] = ~((state==idle)&~ssSel0[3] | (state==set)&~ssSel1[3] | (state==print_save)&~ssSel2[3] | (state==play)&~ssSel3[3] | (state==print_res)&~ssSel4[3]);
    assign ssSel[2] = ~((state==idle)&~ssSel0[2] | (state==set)&~ssSel1[2] | (state==print_save)&~ssSel2[2] | (state==play)&~ssSel3[2] | (state==print_res)&~ssSel4[2]);
    assign ssSel[1] = ~((state==idle)&~ssSel0[1] | (state==set)&~ssSel1[1] | (state==print_save)&~ssSel2[1] | (state==play)&~ssSel3[1] | (state==print_res)&~ssSel4[1]);
    assign ssSel[0] = ~((state==idle)&~ssSel0[0] | (state==set)&~ssSel1[0] | (state==print_save)&~ssSel2[0] | (state==play)&~ssSel3[0] | (state==print_res)&~ssSel4[0]);
    assign ssDisp[7] = ~((state==idle)&~ssDisp0[7] | (state==set)&~ssDisp1[7] | (state==print_save)&~ssDisp2[7] | (state==play)&~ssDisp3[7] | (state==print_res)&~ssDisp4[7]);
    assign ssDisp[6] = ~((state==idle)&~ssDisp0[6] | (state==set)&~ssDisp1[6] | (state==print_save)&~ssDisp2[6] | (state==play)&~ssDisp3[6] | (state==print_res)&~ssDisp4[6]);
    assign ssDisp[5] = ~((state==idle)&~ssDisp0[5] | (state==set)&~ssDisp1[5] | (state==print_save)&~ssDisp2[5] | (state==play)&~ssDisp3[5] | (state==print_res)&~ssDisp4[5]);
    assign ssDisp[4] = ~((state==idle)&~ssDisp0[4] | (state==set)&~ssDisp1[4] | (state==print_save)&~ssDisp2[4] | (state==play)&~ssDisp3[4] | (state==print_res)&~ssDisp4[4]);
    assign ssDisp[3] = ~((state==idle)&~ssDisp0[3] | (state==set)&~ssDisp1[3] | (state==print_save)&~ssDisp2[3] | (state==play)&~ssDisp3[3] | (state==print_res)&~ssDisp4[3]);
    assign ssDisp[2] = ~((state==idle)&~ssDisp0[2] | (state==set)&~ssDisp1[2] | (state==print_save)&~ssDisp2[2] | (state==play)&~ssDisp3[2] | (state==print_res)&~ssDisp4[2]);
    assign ssDisp[1] = ~((state==idle)&~ssDisp0[1] | (state==set)&~ssDisp1[1] | (state==print_save)&~ssDisp2[1] | (state==play)&~ssDisp3[1] | (state==print_res)&~ssDisp4[1]);
    assign ssDisp[0] = ~((state==idle)&~ssDisp0[0] | (state==set)&~ssDisp1[0] | (state==print_save)&~ssDisp2[0] | (state==play)&~ssDisp3[0] | (state==print_res)&~ssDisp4[0]);
   
    // Module
    idle state0( // instantiate idle state
        .clk(clk&(state == idle)),
        .sel(ssSel0),
        .disp(ssDisp0)      
        );
    
    set state1( // instantiate set state
        .sw_clk(fsm_clk&(state == set)),
        .clk(clk&(state == set)),
        .sw(sw),
        .num1(num1),
        .num2(num2),
        .num3(num3),
        .sel(ssSel1),
        .disp(ssDisp1)
    );
    
    print_save state2( // instantiate print_save state
        .clk(clk&(state==print_save)),
        .sel(ssSel2),
        .disp(ssDisp2)
    );
    
    play state3( // instantiate play state
        .sw_clk(fsm_clk&(state == play)),
        .clk(clk&(state == play)),
        .sw(sw),
        .user1(user1),
        .user2(user2),
        .user3(user3),
        .sel(ssSel3),
        .disp(ssDisp3)
    );
    
    print_res state4( // instantiate print_res state
        .clk(clk&(state==print_res)),
        .num1(num1),
        .num2(num2),
        .num3(num3),
        .user1(user1),
        .user2(user2),
        .user3(user3),
        .sel(ssSel4),
        .disp(ssDisp4)
    );
    
    
    // Initialization
    initial begin
        state <= idle;
    end
    
    // FSM
    always @(posedge clk) begin
        case (state)
            idle: begin
                if (btnLeft) // btnLeft -> set state
                    state <= set;
                else if (btnRight) // btnLeft -> play state
                    state <= play;
            end
            set: begin // At set state
                if(btnTop) // btnTop -> print_save state
                    state <= print_save;
            end
            print_save: begin // At print_save state
                if (btnCenter) // btnCenter -> idle state
                    state <= idle;
            end
            play: begin // At play state
                if(btnBottom) // btnBottom -> print_res state
                    state <= print_res;
            end
            print_res: begin
                if (btnCenter)
                    state <= idle;
            end
        endcase
    end

endmodule

// IDLE State module
module idle(input clk, output reg [3:0] sel, output reg [7:0] disp);
    
    integer counter;
    wire [7:0] res1, res2, res3, res4;
 
    bcd_to_7segment sel0( // Display 0 to 7segment
        .bcd(4'b0000),
        .seg(res1)
    );
    
    bcd_to_7segment sel1( // Display 0 to 7segment
        .bcd(4'b0000),
        .seg(res2)
    );
    
    bcd_to_7segment sel2( // Display 0 to 7segment
        .bcd(4'b0000),
        .seg(res3)
    );
    
    bcd_to_7segment sel3( // Display 0 to 7segment
        .bcd(4'b0000),
        .seg(res4)
    );
    
    initial begin
        counter <= 0;
        sel <= 14;
        disp <= 7'b1111111;
     end
     
    always @(posedge clk) begin // Display res1, res2, res3, res4 to FPGA's 7segment module
        counter <= counter + 1;
        if (counter == 100000) begin
          counter <= 0;
          case (sel)
            14: begin
              sel <= 13;
              disp <= res2;
            end
            13: begin
              sel <= 11;
              disp <= res3;
            end
            11: begin
              sel <= 7;
              disp <= res4;
            end
            7: begin
              sel <= 14;
              disp <= res1;
            end
          endcase
        end
      end
endmodule 

// SET state module
module set(
    input sw_clk,
    input clk, 
    input [11:0] sw,
    output [3:0] num1, num2, num3,
    output reg [3:0] sel, 
    output reg [7:0] disp
    );
    
    reg [3:0] digit1, digit2, digit3;
    
    integer counter;
    
    wire [7:0] res1, res2, res3, res4;
    
    // Update digits based on switch input
    always @(posedge clk) begin
        digit1 = sw[3:0]; 
        digit2 = sw[7:4];
        digit3 = sw[11:8];
    end

    bcd_to_7segment sel0( 
        .bcd(digit1),
        .seg(res1)
    );
    
    bcd_to_7segment sel1(
        .bcd(digit2),
        .seg(res2)
    );
    
    bcd_to_7segment sel2(
        .bcd(digit3),
        .seg(res3)
    );
    
    assign res4 = 8'b11111111;
    
    initial begin
        counter <= 0;
        sel <= 14;
        disp <= 8'b00000000;
     end
     
    always @(posedge clk) begin // Display res1, res2, res3, res4 to FPGA's 7segment module
        counter <= counter + 1;
        if (counter == 100000) begin
          counter <= 0;
          case (sel)
            14: begin
              sel <= 13;
              disp <= res2;
            end
            13: begin
              sel <= 11;
              disp <= res3;
            end
            11: begin
              sel <= 7;
              disp <= res4;
            end
            7: begin
              sel <= 14;
              disp <= res1;
            end
          endcase
        end
      end

    // Store digits in registers
    four_bit_register ans1(digit1, clk, num1);
    four_bit_register ans2(digit2, clk, num2);
    four_bit_register ans3(digit3, clk, num3);

endmodule


// PRINT_SAVE state module
module print_save(input clk, output reg [3:0] sel, output reg [7:0] disp);
    
    integer counter;
    wire [7:0] res1, res2, res3, res4;
 
    bcd_to_7segment sel0( // Display 'S' 
        .bcd(4'b0101),
        .seg(res1)
    );
    
    bcd_to_7segment sel1( // Display 'A'
        .bcd(4'b1010),
        .seg(res2)
    );
    
    bcd_to_7segment sel2( // Display 'V'
        .bcd(4'b1111),
        .seg(res3)
    );
    
    bcd_to_7segment sel3( // Display 'E'
        .bcd(4'b1100),
        .seg(res4)
    );
    
    initial begin
        counter <= 0;
        sel <= 14;
        disp <= 7'b1111111;
     end
     
     // Display res1, res2, res3, res4 to FPGA's 7segment module
    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == 100000) begin
          counter <= 0;
          case (sel)
            14: begin
              sel <= 13;
              disp <= res2;
            end
            13: begin
              sel <= 11;
              disp <= res3;
            end
            11: begin
              sel <= 7;
              disp <= res4;
            end
            7: begin
              sel <= 14;
              disp <= res1;
            end
          endcase
        end
      end
endmodule

// PLAY state module
module play(
    input sw_clk,
    input clk, 
    input [11:0] sw,
    output [3:0] user1, user2, user3,
    output reg [3:0] sel, 
    output reg [7:0] disp
    );
    
    reg [3:0] digit1, digit2, digit3;
    
    integer counter;
    
    wire [7:0] res1, res2, res3, res4;
    
    // Update digits based on switch input
    always @(posedge clk) begin
        digit1 = sw[3:0];
        digit2 = sw[7:4];
        digit3 = sw[11:8];
    end

    bcd_to_7segment sel0(
        .bcd(digit1),
        .seg(res1)
    );
    
    bcd_to_7segment sel1(
        .bcd(digit2),
        .seg(res2)
    );
    
    bcd_to_7segment sel2(
        .bcd(digit3),
        .seg(res3)
    );
    
    assign res4 = 8'b11111111;
    
    initial begin
        counter <= 0;
        sel <= 14;
        disp <= 8'b00000000;
     end
     
    // Display res1, res2, res3, res4 to FPGA's 7segment module
    always @(posedge clk) begin
        counter <= counter + 1;
        if (counter == 100000) begin
          counter <= 0;
          case (sel)
            14: begin
              sel <= 13;
              disp <= res2;
            end
            13: begin
              sel <= 11;
              disp <= res3;
            end
            11: begin
              sel <= 7;
              disp <= res4;
            end
            7: begin
              sel <= 14;
              disp <= res1;
            end
          endcase
        end
      end

    // Store digits in registers
    four_bit_register userin1(digit1, clk, user1);
    four_bit_register userin2(digit2, clk, user2);
    four_bit_register userin3(digit3, clk, user3);

endmodule

// PRINT_RES state module
module print_res(
    input [3:0] num1, num2, num3,
    input [3:0] user1, user2, user3,
    input clk, 
    output reg [3:0] sel, 
    output reg [7:0] disp
    );
    
    integer counter;
    wire [2:0] strike_same;
    wire [5:0] ball_same;
    wire [2:0] ball_count;
    
    // If numi == useri, assign strike_same[i] = 1 (determine STRIKE)
    Comparator s_comp1(num1, user1, strike_same[0]); 
    Comparator s_comp2(num2, user2, strike_same[1]);
    Comparator s_comp3(num3, user3, strike_same[2]);
    
   // If numi == userj, assign ball_count[i-1] = 1 (determine BALL)
    Comparator b_comp1(num1, user2, ball_same[0]);
    Comparator b_comp2(num1, user3, ball_same[1]);
    Comparator b_comp3(num2, user1, ball_same[2]);
    Comparator b_comp4(num2, user3, ball_same[3]);
    Comparator b_comp5(num3, user1, ball_same[4]);
    Comparator b_comp6(num3, user2, ball_same[5]);
    
    or(ball_count[0], ball_same[0], ball_same[1]);
    or(ball_count[1], ball_same[2], ball_same[3]);
    or(ball_count[2], ball_same[4], ball_same[5]);
    
    // Count the number of strike
    wire [1:0] strike;
    fullAdder add1(strike_same[0], strike_same[1], strike_same[2], strike[0], strike[1]);
    
    // Count the number of ball
    wire [1:0] ball;
    fullAdder add2(ball_count[0], ball_count[1], ball_count[2], ball[0], ball[1]);
    
    reg [7:0] res1, res2, res3, res4;

    // Determine the result based on strikes and balls
    always @(*) begin
        if (strike == 2'b11 && ball == 2'b00) begin // 3 strike
            res1 = 8'b11111111; // Display blank
            res2 = 8'b11111111; // Display blank
            res3 = 8'b10110000; // Display '3'
            res4 = 8'b10010010; // Display 'S' 
        end else if (strike == 2'b10 && ball == 2'b00) begin // 2s0b
            res1 = 8'b11111111; // Display blank
            res2 = 8'b11111111; // Display blank
            res3 = 8'b10100100; // Display '2'
            res4 = 8'b10010010; // Display 'S'
        end else if (strike == 2'b01 && ball == 2'b00) begin // 1s0b
            res1 = 8'b11111111; // Display blank
            res2 = 8'b11111111; // Display blank
            res3 = 8'b11111001; // Display '1'
            res4 = 8'b10010010; // Display 'S'
        end else if (strike == 2'b01 && ball == 2'b01) begin // 1s1b
            res1 = 8'b11111001; // Display '1'
            res2 = 8'b10000011;  // Display 'b'
            res3 = 8'b11111001; // Display '1'
            res4 = 8'b10010010; // Display 'S'
        end else if (strike == 2'b01 && ball == 2'b10) begin // 1s2b
            res1 = 8'b10100100; // Display '2'
            res2 = 8'b10000011;  // Display 'b'
            res3 = 8'b11111001; // Display '1'
            res4 = 8'b10010010; // Display 'S'
        end else if (strike == 2'b00 && ball == 2'b11) begin // 0s3b
            res1 = 8'b11111111; // Display blank
            res2 = 8'b11111111; // Display blank
            res3 = 8'b10110000; // Display '3'
            res4 = 8'b10000011;  // Display 'b'
        end else if (strike == 2'b00 && ball == 2'b10) begin // 0s2b
            res1 = 8'b11111111; // Display blank
            res2 = 8'b11111111; // Display blank
            res3 = 8'b10100100; // Display '2'
            res4 = 8'b10000011;  // Display 'b'
        end else if (strike == 2'b00 && ball == 2'b01) begin // 0s1b
            res1 = 8'b11111111; // Display blank
            res2 = 8'b11111111; // Display blank
            res3 = 8'b11111001; // Display '1'
            res4 = 8'b10000011;  // Display 'b'
        end else begin // out
            res1 = 8'b11111111; // Display blank
            res2 = 8'b11000000; // Display '0'
            res3 = 8'b11000001; // Display 'U'
            res4 = 8'b10000111; // Display 't'
        end
    end
    
    
    initial begin
        counter <= 0;
        sel <= 14;
        disp <= 7'b1111111;
     end
     
    always @(posedge clk) begin // Display res1, res2, res3, res4 to FPGA's 7segment module
        counter <= counter + 1;
        if (counter == 100000) begin
          counter <= 0;
          case (sel)
            14: begin
              sel <= 13;
              disp <= res2;
            end
            13: begin
              sel <= 11;
              disp <= res3;
            end
            11: begin
              sel <= 7;
              disp <= res4;
            end
            7: begin
              sel <= 14;
              disp <= res1;
            end
          endcase
        end
      end
endmodule