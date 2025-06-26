`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 08:44:34 PM
// Design Name: 
// Module Name: div
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


module div(
input     [31:0]  in1,
input     [31:0]  in2,
input             un_signed,
input             div_en,
output    [31:0]  high,
output    [31:0]  low,
output     div_by_zero
    );
    
    wire    [31:0]  in1_s_un;
    wire    [31:0]  in2_s_un; 
    
    assign in1_s_un =(un_signed==1'b1)? (~in1 + 1'b1) : in1;
    assign in2_s_un =(un_signed==1'b1)? (~in2 + 1'b1) : in2;
    
    assign div_by_zero=(div_en==1'b1 & in2_s_un==32'b0)?1'b1:1'b0;
    
    assign low =(div_by_zero==1'b1)? 32'bx: in1_s_un / in2_s_un;
    assign high=(div_by_zero==1'b1)? 32'bx: in1_s_un % in2_s_un;
    
endmodule
