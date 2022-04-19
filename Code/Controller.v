`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/04 11:41:31
// Design Name: 
// Module Name: Controller
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


module Controller ( Opcode , ALUSrc , MemtoReg , RegWrite , MemRead , MemWrite , ALUOp );
// Define the input and output signals
    input [6:0] Opcode;
    output reg ALUSrc;
    output reg MemtoReg;
    output reg RegWrite;
    output reg MemRead;
    output reg MemWrite;
    output reg [1:0] ALUOp;
// Define the Controller modules behavior
    always @(Opcode)
    begin
        case(Opcode)
        7'b0100011://SW   
            begin
                MemtoReg = 0;
                MemWrite = 1;
                MemRead = 0;
                ALUSrc = 1;
                RegWrite = 0;
                ALUOp = 2'b01;
            end      
        7'b0000011://LW
            begin
                MemtoReg = 1;
                MemWrite = 0;
                MemRead = 1;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b01;
            end
        7'b0010011://I-type
            begin
                MemtoReg = 0;
                MemWrite = 0;
                MemRead = 0;
                ALUSrc = 1;
                RegWrite = 1;
                ALUOp = 2'b00;
            end
        7'b0110011://R-type
            begin
                MemtoReg = 0;
                MemWrite = 0;
                MemRead = 0;
                ALUSrc = 0;
                RegWrite = 1;
                ALUOp = 2'b10;
            end
        endcase
    end

endmodule
