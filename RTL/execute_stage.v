`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2024 03:20:27 AM
// Design Name: 
// Module Name: execute_stage
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


module execute_stage(
input       [31:0]  ea,eb,eimm,             
input       [4:0]   ern0,                    
input       [31:0]  epc4,                   
input               ejal,ealuimm,
input       [3:0]   ealuc,
input       [5:0]   eop,
input       [4:0]   eshamt,

output      [4:0]   ern, // dest reg
output      [31:0]  ealu                   

    );
    
    wire            [31:0]  epc8;
    wire            [31:0]  in2alu;
    wire    signed  [31:0]  alu_out; 
    
   
//    adder #(32) PC8_INST(.A(epc4),.B(32'd4),.cin(1'b0),.sum(epc8),.carry());

    mux srcB_MUX(.A(eb),.B(eimm),.SEL(ealuimm),.OUT(in2alu));

alu ALU_INS(
        .op_code(ealuc),
        .srca(ea),
        .srcb(in2alu),
        .shamt(eshamt),
        .alu_res(alu_out)
        );
        
mux JALR(.A(alu_out),.B(epc4),.SEL(ejal),.OUT(ealu));
 
 assign   ern   =   (ejal==1'b1)?   5'b11111:ern0;
        
        
endmodule
