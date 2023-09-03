`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/04 11:42:30
// Design Name: 
// Module Name: processor
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


module processor ( input clk , reset , output [31:0] Result );
// Define the input and output signals
    wire [6:0] Funct7;
    wire [2:0] Funct3;
    wire [6:0] Opcode;
    wire [1:0] ALUOp;
    wire [3:0] Operation;
    wire ALUSrc;
    wire MemtoReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
// Define the processor modules behavior
// Data Path
    data_path dp0 (.clk(clk),.reset(reset), .reg_write(RegWrite), .mem2reg(MemtoReg), 
                    .alu_src(ALUSrc), .mem_write(MemWrite), .mem_read(MemRead), .alu_cc(Operation), 
                    .opcode(Opcode), .funct7(Funct7), .funct3(Funct3), .alu_result(Result));
// Controller
    Controller ct0 (.Opcode(Opcode), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .ALUOp(ALUOp));
// ALU Controller 
    ALUController act0 (.ALUOp(ALUOp), .Funct7(Funct7), .Funct3(Funct3), .Operation(Operation));
endmodule
