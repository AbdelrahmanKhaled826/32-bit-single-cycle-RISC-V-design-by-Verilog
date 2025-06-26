`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2024 11:43:33 PM
// Design Name: 
// Module Name: load_from_mem
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


module load_from_mem(
input       [31:0]  read_data,
input               lb,  //load byte
input               lbu, //unsigned
input               lh,  //load half word
input               lhu,
output  reg [31:0]  data_out_from_mem   
    );
    
    always @(*)begin
        if(lb==1'b1)            data_out_from_mem={{24{read_data[7]}},read_data[7:0]};
        else if(lbu==1'b1)      data_out_from_mem={24'b0,read_data[7:0]};
        else if(lh==1'b1)       data_out_from_mem={{16{read_data[15]}},read_data[15:0]};
        else if(lhu==1'b1)      data_out_from_mem={16'b0,read_data[15:0]};
        else                    data_out_from_mem=read_data;
    end
    
    
endmodule
