`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2024 03:21:34 AM
// Design Name: 
// Module Name: M_W_stage
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


module M_W_stage(
input               clk,
input               rst_n,
input               mm2reg,
input               mwreg,
input       [31:0]  mmo,
input       [31:0]  malu,
input       [4:0]   mrn,

output reg          wm2reg,
output reg          wwreg,
output reg  [31:0]  wmo,
output reg  [31:0]  walu,
output reg  [4:0]   wrn
    );
    
    always @(posedge clk or negedge rst_n)begin
            if(~rst_n) begin
                walu    <=32'b0;
                wmo     <=32'b0;
                wrn     <=5'b0;
                wm2reg  <=1'b0;
                wwreg   <=1'b0;
    
            end else begin
                walu    <=malu;
                wmo     <=mmo;
                wrn     <=mrn; 
                wm2reg  <=mm2reg;
                wwreg   <=mwreg;
              
    
            end
  end
    
    
endmodule
