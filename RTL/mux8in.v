`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 03:35:21 PM
// Design Name: 
// Module Name: mux8in
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


module mux8in(
input       [31:0]  in1,
input       [31:0]  in2,
input       [31:0]  in3,
input       [2:0]  sel,

output reg  [31:0]  out_data
    );
    always @(*)begin
    case(sel)
        3'b001:out_data<=in1;
        3'b011:out_data<=in2;
        3'b101:out_data<=in3;
        default:out_data<=32'bx;
    
    endcase
    end
endmodule
