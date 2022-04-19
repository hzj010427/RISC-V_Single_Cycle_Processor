`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/23 00:41:05
// Design Name: 
// Module Name: data_path
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


////   Data Path /////
module data_path #(
    parameter PC_W = 8,       // Program Counter
    parameter INS_W = 32,     // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32,    // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4    // ALU Control Code Width
 )(
    input                  clk ,    // CLK in datapath figure
    input                  reset,   // Reset in datapath figure      
    input                  reg_write,   // RegWrite in datapath figure
    input                  mem2reg,     // MemtoReg in datapath figure
    input                  alu_src,     // ALUSrc in datapath figure 
    input                  mem_write,   // MemWrite in datapath figure  
    input                  mem_read,    // MemRead in datapath figure          
    input  [ALU_CC_W-1:0]  alu_cc,      // ALUCC in datapath figure
    output          [6:0]  opcode,      // opcode in dataptah figure
    output          [6:0]  funct7,      // Funct7 in datapath figure
    output          [2:0]  funct3,      // Funct3 in datapath figure
    output   [DATA_W-1:0]  alu_result   // Datapath_Result in datapath figure
 );


// Write your code here

//FilpFlop
    wire [PC_W-1:0] PC;
    wire [PC_W-1:0] PCPlus4;
    
    assign PCPlus4 = PC + 4; //Next PC

    FlipFlop ff0 (.clk(clk), .reset(reset), .d(PCPlus4), .q(PC));
//Instruction Memory
    wire [INS_W-1:0] Instr;
    
    InstMem im0 (.addr(PC), .instruction(Instr));
    
    assign opcode = Instr [6:0];
    assign funct7 = Instr [31:25];
    assign funct3 = Instr [14:12];

//RegFile
    wire [DATA_W-1:0] Reg1;
    wire [DATA_W-1:0] Reg2;
    wire [DATA_W-1:0] WriteBack_Data;
    
    RegFile rf0 (.clk(clk), .reset(reset), .rg_wrt_en(reg_write), .rg_wrt_addr(Instr[11:7]), .rg_rd_addr1(Instr[19:15]), .rg_rd_addr2(Instr[24:20]),
                 .rg_wrt_data(WriteBack_Data), .rg_rd_data1(Reg1), .rg_rd_data2(Reg2));
 //Immediate Generator
    wire [INS_W-1:0] ExImm;
    
    ImmGen ig0 (.InstCode(Instr), .ImmOut(ExImm));
 //Mux0
    wire [DATA_W-1:0] SreB;
    
    MUX21 mux0 (.D1(Reg2), .D2(ExImm), .S(alu_src), .Y(SreB));
//ALU
    wire Carry_Out;
    wire Zero;
    wire Overflow;
    
    alu_32 alu0 (.A_in(Reg1), .B_in(SreB), .ALU_Sel(alu_cc), .ALU_Out(alu_result), .Carry_Out(Carry_Out), .Zero(Zero), .Overflow(Overflow));      
//Data Memory
    wire [DATA_W-1:0] DataMem_read;
    
    DataMem dm0 (.MemRead(mem_read), .MemWrite(mem_write), .addr(alu_result[8:0]) , .write_data(Reg2), .read_data(DataMem_read));
//Mux1
    MUX21 mux1 (.D1(alu_result), .D2(DataMem_read), .S(mem2reg), .Y(WriteBack_Data));
endmodule
