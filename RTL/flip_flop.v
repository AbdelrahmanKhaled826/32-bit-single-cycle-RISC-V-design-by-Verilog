`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 06:05:51 PM
// Design Name: 
// Module Name: flip_flop
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


module flip_flop(

input   clk,
input   rst_n,
input   en,
input   clear,
input   in1,
output  reg out1

    );
    
    always @(posedge clk or negedge rst_n)begin
        if(~rst_n)  out1<=1'b0;
        else if(clear==1'b1)  out1<=1'b0;
        else if(en==1'b1) out1<=in1;
        else        out1<=out1;
    
    end
    
    
endmodule
