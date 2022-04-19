`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/23 00:43:24
// Design Name: 
// Module Name: DataMem
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


module DataMem ( MemRead , MemWrite , addr , write_data , read_data );

    input [8:0]addr;
    input MemRead;
    input MemWrite;
    input [31:0]write_data;
    output reg [31:0]read_data;
    
    wire read_addr = addr[8:2];
    wire write_addr = addr[8:2];
    reg [31:0]DataMem[127:0]; //Define a 128X32 DataMemory
    
    integer i; //Initial the data in DataMemory
            initial
            begin
                for (i = 0; i < 128; i = i + 1)
                begin
                    DataMem[i] = i;
                end
            end

    always @(*)
    begin
        if (MemWrite == 1)
        begin
            DataMem[write_addr] = write_data; //write the data into DataMemory
        end
        if (MemRead == 1)
            read_data = DataMem[read_addr]; //read the data from DataMemory
        begin
        end
    end

endmodule
