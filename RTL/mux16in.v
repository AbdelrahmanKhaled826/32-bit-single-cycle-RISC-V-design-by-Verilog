`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 02:41:50 PM
// Design Name: 
// Module Name: mux16in
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


module mux16in(
input       [31:0] in1,
input       [31:0] in2,
input       [31:0] in3,
input       [31:0] in4,
input       [31:0] in5,

input       [3:0]  sel,

output reg  [31:0] out_data


    );
    
    always @(*)begin
        case(sel)
        4'b0000:    out_data=in1;
        4'b0001:    out_data=in2;
        4'b0010:    out_data=in3;
        4'b0100:    out_data=in4;
        4'b1000:    out_data=in5;
        default:    out_data=32'bx;
        endcase
    end
    
    
endmodule
