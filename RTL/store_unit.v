`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2024 02:20:58 AM
// Design Name: 
// Module Name: store_unit
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


module store_unit(
input   [31:0]  data_in,
input   sb,
input   sh,

output reg [31:0]  data_out

    );
    
    always @(*) begin
        if(sb==1'b1)     data_out={24'b0,data_in[7:0]};
        else if(sh==1'b1)     data_out={16'b0,data_in[15:0]};
        else      data_out=data_in;
    end
    
endmodule
