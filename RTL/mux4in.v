`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2024 03:16:01 AM
// Design Name: 
// Module Name: mux4in
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


module mux4in(
input [31:0] in1,
input [31:0] in2,
input [31:0] in3,
input [31:0] in4,
input [1:0] sel,
output reg [31:0] data_out
    );
    
    
    always @(*)begin
    case(sel)
        2'b00:data_out=in1;
        2'b01:data_out=in2;
        2'b10:data_out=in3;
        2'b11:data_out=in4;
    endcase
    end
    
    
    
endmodule
