`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2024 03:21:51 AM
// Design Name: 
// Module Name: writeback_stage
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


module writeback_stage(
input           wm2reg,
input   [31:0]  wmo,walu,
output  [31:0]  wdi

    );
    assign wdi=(wm2reg==1'b1)?wmo:walu;
    
    
endmodule
