`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/23 00:43:24
// Design Name: 
// Module Name: FlipFlop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FlipFlop (clk , reset , d, q); // FlipFlop module
    input clk;
    input reset;
    input [7:0]d;
    output [7:0]q;
    reg [7:0]q;

    always @ (posedge clk) // behaviour of flip-flop
        begin
            if (reset == 1)
            begin
                q = 0;
            end
            else if (reset == 0)
            begin
                q = d;
            end
         end
endmodule
