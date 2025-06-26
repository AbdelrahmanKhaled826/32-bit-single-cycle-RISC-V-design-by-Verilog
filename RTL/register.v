`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 02:13:06 PM
// Design Name: 
// Module Name: register
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


module register(
input               clk,
input               rst_n,
input               wr_en,
input               rd_en,
input      [31:0]   D,
output     [31:0]   Q
    );
    
   reg [31:0] new_reg;
    always @(posedge clk or negedge rst_n)begin
        if(~rst_n)          new_reg<=32'b0;
        else if(wr_en)      new_reg<=D;
        else                new_reg<=new_reg;
    
    end
    
    
    assign Q = (rd_en==1'b1)?   new_reg:32'b0;
    
endmodule
