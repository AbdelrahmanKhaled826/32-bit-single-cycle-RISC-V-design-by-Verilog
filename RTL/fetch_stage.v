`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2024 03:18:48 AM
// Design Name: 
// Module Name: fetch_stage
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

module fetch_stage(
input   [31:0]  pc,
input   [31:0]  pc_branch,  //for  B type  beq,bnq,bgez,blez,bgtz
input   [31:0]  pc_jump,    //for  J type  j,jal
input   [31:0]  pc_jump_RT, //for  R type  jr,jalr
input   [1:0]   pc_sel,     // selector for pc

output  [31:0]  next_pc,
output  [31:0]  pc_plus4,
output  [31:0]  instra      //instruction from mem
    );
   
     mux4in select_pc_INS(
       .in1(pc_plus4),
       .in2(pc_branch),
       .in3(pc_jump_RT),
       .in4(pc_jump),
       .sel(pc_sel),
       .data_out(next_pc)
       );
       
       inst_mem inst_mem_INST(
           .A(pc),
           .RD(instra)
           );
           
      adder #(32) PC4(.A(pc),.B(32'd4),.cin(1'b0),.sum(pc_plus4),.carry());
           
     
    
endmodule
