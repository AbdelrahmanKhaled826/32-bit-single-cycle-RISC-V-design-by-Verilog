`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 06:27:02 PM
// Design Name: 
// Module Name: flip_flop_var
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


module flip_flop_var#(
parameter N=32
)(
input       clk,
input       rst_n,
input       clear,
input       en,
input  [N-1:0]  d,
output  reg [N-1:0] q
    );
    
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) q<='b0;//{{N{1'b0}}};
        else if(clear==1'b1)  q<='b0;//q<={{N{1'b0}}};
        else if(en==1'b1)   q<=d;
        else        q<=q;
        
    end
    
    
endmodule
