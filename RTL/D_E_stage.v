`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2024 05:56:30 AM
// Design Name: 
// Module Name: D_E_stage
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


module D_E_stage(
input                   clk,
input                   rst_n,
input                   clear,
input         [31:0]    da,
input         [31:0]    db,
input         [31:0]    dimm,
input         [4:0]     drn,
input         [31:0]    dpc4,
input                   djal,
input                   daluimm,
input                   dwreg,
input                   dm2reg,
input                   dwmem,
input         [3:0]     daluc,
input         [5:0]     dop,
input         [4:0]     dshamt,

output  reg   [4:0]     eshamt,
output  reg   [5:0]     eop,
output  reg   [31:0]    ea,
output  reg   [31:0]    eb,
output  reg   [31:0]    eimm,
output  reg   [4:0]     ern,
output  reg   [31:0]    epc4,
output  reg             ejal,
output  reg             ealuimm,
output  reg             ewreg,
output  reg             em2reg,
output  reg             ewmem,
output  reg   [3:0]     ealuc

    );

always @(posedge clk or negedge rst_n)begin
    if(~rst_n || clear==1'b1) begin
        ea<=32'b0;
        //eb<=32'b0;
        eimm<=32'b0;
        ern<=5'b0;
        epc4<=32'b0;
        ejal<=1'b0;
        ealuimm<=1'b0;
        ewreg<=1'b0;
        em2reg<=1'b0;
        ewmem<=1'b0;
        ealuc<=4'b0;
        eop<=6'b0;
        eshamt<=5'b0;
    end else begin
        ea<=da;
        eb<=db;
        eimm<=dimm;
        ern<=drn;
        epc4<=dpc4;
        ejal<=djal;
        ealuimm<=daluimm;
        ewreg<=dwreg;
        em2reg<=dm2reg;
        ewmem<=dwmem;
        ealuc<=daluc;
        eop<=dop;
        eshamt<=dshamt;
    end

end    
    
    
endmodule
