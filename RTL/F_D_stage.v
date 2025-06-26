`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2024 03:19:24 AM
// Design Name: 
// Module Name: F_D_stage
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


module F_D_stage(
input               clk,
input               clear,
input               rst_n,
input               en,
input       [31:0]  pc_plus4, //fetch pc
input       [31:0]  instra,   //fetch instraction

output  reg [31:0]  instra_d, //decode pc
output  reg [31:0]  pc_plus4d //decode pc  
    );
    
    always @(posedge clk or negedge rst_n)
    begin
        if(rst_n==1'b0 || clear==1'b1)  begin  
            instra_d<=32'b0;
            pc_plus4d<=32'b0;
        end
        else if(en==1'b0)begin  //for stall
            instra_d<=instra_d;
            pc_plus4d<=pc_plus4d;
          end
        else begin
              instra_d<=instra;
              pc_plus4d<=pc_plus4;
           end
    end
    
    
endmodule
