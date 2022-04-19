`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/23 00:43:24
// Design Name: 
// Module Name: RegFile
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


module RegFile(
  input clk, reset, rg_wrt_en,
  input [4:0] rg_wrt_addr, 
  input [4:0] rg_rd_addr1,
  input [4:0] rg_rd_addr2, 
  input [31:0] rg_wrt_data,
  output wire [31:0] rg_rd_data1,
  output wire [31:0] rg_rd_data2
);
    
    reg [31:0]RegFile[31:0]; //32X32 RegisterFile
    
    assign rg_rd_data1 = RegFile[rg_rd_addr1]; //asynchronous reading from a register file
    assign rg_rd_data2 = RegFile[rg_rd_addr2];
    
    integer i; //synchronous writing from a register file
            always @(posedge clk or posedge reset)
            begin
                if (reset == 1)
                begin
                    for (i = 0; i < 32; i = i + 1)
                    begin
                        RegFile[i] = 32'b00000000;
                    end
                end
                else
                begin
                    if (rg_wrt_en == 1)
                    begin
                        RegFile[rg_wrt_addr] = rg_wrt_data;
                    end
                end
            end 


endmodule
