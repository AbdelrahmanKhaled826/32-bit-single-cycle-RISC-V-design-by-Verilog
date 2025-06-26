`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2024 08:58:06 AM
// Design Name: 
// Module Name: sign_ext
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


module sign_ext(
input [15:0] instruction_mem,
input [5:0] code,
output reg [31:0] sign_imm
    );
    always @(*)begin
        if(/* code ==6'b001001 ||*/ code ==6'b001100 ||code==6'b001101 || code==6'b001110) begin // addiu andi  ori xori
            sign_imm = {16'b0,instruction_mem};
        end
        else if(code==6'b001111) begin //lui
            sign_imm = {instruction_mem,16'b0}; 
        end
        else begin
            sign_imm = {{16{instruction_mem[15]}},instruction_mem};
        end
    end
    
    
endmodule
