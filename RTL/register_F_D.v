`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 09:15:24 AM
// Design Name: 
// Module Name: register_F_D
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


module register_F_D(
input clk,
input rst_n,
input   [31:0] instruction,
input   [31:0] pcplus4,
output reg [31:0] instruction_f_d,
output reg [31:0] pcplus4_f_d

    );
    
    
    always @(posedge clk or negedge rst_n)begin
        if(~rst_n) begin
            instruction_f_d<=32'b0;
            pcplus4_f_d<=32'b0;
        end 
        else begin
            instruction_f_d<=instruction;
            pcplus4_f_d<=pcplus4;
        end
    
    end
    
    
    
endmodule
