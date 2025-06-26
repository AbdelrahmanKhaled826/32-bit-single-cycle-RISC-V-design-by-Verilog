`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2024 03:21:12 AM
// Design Name: 
// Module Name: memory_stage
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


module memory_stage(
input           clk,
input           rst_n,
input           mwmem,
input   [31:0]  malu,
input   [31:0]  mb,
output  [31:0]  mmo

    );
 data_mem data_mem_INS(
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(mwmem),
        .addr(malu),
        .wr_data(mb),//.wr_data(writedata_m),
        .rd_data(mmo)
        );
    
    
endmodule
