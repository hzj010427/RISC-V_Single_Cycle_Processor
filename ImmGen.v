`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/23 00:43:24
// Design Name: 
// Module Name: ImmGen
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


module ImmGen ( InstCode , ImmOut ); //ImmediateGenerator behaviour

    input [31:0] InstCode ; 
    output reg [31:0] ImmOut ;
    
    always @(InstCode) 
    begin
        case ( InstCode [6:0])
            7'b0000011 : ImmOut = { InstCode [31]? {20{1 'b1 }}:20 'b0 , InstCode [31:20]}; // I- type - Load
            7'b0010011 : ImmOut = { InstCode [31]? {20{1 'b1 }}:20 'b0 , InstCode [31:20]}; // I- type - non - Load
            7'b0100011 : ImmOut = { InstCode [31]? {20{1 'b1 }}:20 'b0 , InstCode [31:25] , InstCode [11:7]}; // S- type - Store
            7'b0010111 : ImmOut = { InstCode [31:12] , 12 'b0 }; // U- type
            default : ImmOut = {32 'b0 };
        endcase
    end
    
endmodule
