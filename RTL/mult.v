`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 08:45:16 PM
// Design Name: 
// Module Name: mult
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


module mult(
input    [31:0] in1,
input    [31:0] in2,
input           un_signed,
input           mul_en,
output   [31:0] high,
output   [31:0] low
    );
    
    wire   [63:0]   res;
    
     wire    [31:0]  in1_s_un;
     wire    [31:0]  in2_s_un; 
       
       assign in1_s_un =(un_signed==1'b1)? (~in1 + 1'b1) : in1;
       assign in2_s_un =(un_signed==1'b1)? (~in2 + 1'b1) : in2;
    
    
    assign res  =   in1_s_un *  in2_s_un;
    assign high = res[63:32];
    assign low  = res[31:0]; 
    
    
endmodule
