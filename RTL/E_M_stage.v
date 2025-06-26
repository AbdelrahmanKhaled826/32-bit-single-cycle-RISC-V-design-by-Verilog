`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2024 03:20:58 AM
// Design Name: 
// Module Name: E_M_stage
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


module E_M_stage(
input           clk,rst_n,
input           [4:0]   ern,
input           [31:0]  eb,ealu,
input           ewmem,em2reg,ewreg,        

output  reg      [4:0]   mrn,
output  reg      [31:0]  mb,malu,
output  reg      mwmem,mm2reg,mwreg 
    );
    
    
    
    
    always @(posedge clk or negedge rst_n)begin
        if(~rst_n) begin
            malu<=32'b0;
            mb<=32'b0;
            mrn<=5'b0;
            mwmem<=1'b0;
            mm2reg<=1'b0;
            mwreg<=1'b0;

        end else begin
            malu    <=ealu  ;
            mb      <=eb    ;
            mrn     <=ern   ; 
            mwmem   <=ewmem ;
            mm2reg  <=em2reg;
            mwreg   <=ewreg ;

        end
    
    end    
        
    
    
endmodule
