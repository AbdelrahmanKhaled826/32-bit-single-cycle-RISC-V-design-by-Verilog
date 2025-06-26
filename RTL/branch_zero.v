`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/03/2024 07:26:04 AM
// Design Name: 
// Module Name: branch_zero
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


module branch_zero(
input [31:0] rd1,
input [0:4] rt,
input bltz_bgez,
input bgtz,
input blez,
output reg less_or_greater
    );
    
    wire bltz,bgez;
    wire [31:0] out;
    assign bgez =(rt==5'b1)?1'b1:1'b0;
    assign bltz =(rt==5'b0)?1'b1:1'b0;
    
    assign out =rd1-32'b0; 
    always @(*)begin
        if  (out[31]==1'b1 && bltz && bltz_bgez ) less_or_greater=1;
        else if  (out[31]==1'b0 && bgez && bltz_bgez ) less_or_greater=1;
        else if ( ((rd1==32'b0) ||  out[31]==1'b1 ) && blez ) less_or_greater=1;
        else if ( out[31]==1'b0 && bgtz ) less_or_greater=1;
        else less_or_greater=0;
    end
    
    
endmodule
