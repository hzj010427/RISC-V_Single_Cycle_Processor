`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/23 00:43:24
// Design Name: 
// Module Name: MUX21
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


module MUX21 (
        D1 , D2 , S , Y
);
 
input  S;
input  [31:0]D1;
input  [31:0]D2;

output reg [31:0]Y;

// Write your code 
always @(*)
begin
    if (S==0)
    begin
        Y = D1;
    end
    else
    begin
        Y = D2;
    end
end

endmodule 
