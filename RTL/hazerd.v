`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2024 12:19:58 PM
// Design Name: 
// Module Name: hazerd
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


module hazerd(
input       [4:0]   mrn,
input       [4:0]   ern,
input               ewreg,
input               mwreg,
input               em2reg,
input               mm2reg,
input       [4:0]   rs,
input       [4:0]   rt,
input               bne,
input               branch,
input               bgtz,
input               bgez,

output              stall, //wpcir
output              flush,
output  reg [1:0]   fwda,
output  reg [1:0]   fwdb
    );
    
    
    wire stall_T;
    wire stall_n1,stall_n2,stall_n3;   
    
    
    always @(ewreg, mwreg, ern, mrn, em2reg, mm2reg, rs, rt)begin
        fwda = 2'b00; // default: no hazards
        if (ewreg & (ern != 0) & (ern == rs ) ) begin
            fwda = 2'b01; // select exe_alu
        end 
        else 
        begin
            if (mwreg & (mrn != 0) & (mrn == rs) & ~mm2reg) begin
                fwda = 2'b10; // select mem_alu
            end
            else
            begin
                if (mwreg & (mrn != 0) & (mrn == rs) & mm2reg) begin
                    fwda = 2'b11; // select mem_lw
                end
            end
         end
    
        fwdb = 2'b00; // default: no hazards
        if (ewreg & (ern != 0) & (ern == rt) & ~em2reg) begin
            fwdb = 2'b01; // select exe_alu
        end 
        else 
        begin
            if (mwreg & (mrn != 0) & (mrn == rt) & ~mm2reg) begin
                fwdb = 2'b10; // select mem_alu
            end
            else
            begin
                if (mwreg & (mrn != 0) & (mrn == rt) & mm2reg) begin
                    fwdb = 2'b11; // select mem_lw
                end
            end
        end
    end
    

    
    
    
    assign stall_n1 = (ewreg&   branch  & (ern != 0) & (  (ern == rs) | (ern == rt)));//beq 
    assign stall_n2 = (~bgez & ~bgtz& mwreg&   branch  & (mrn != 0) & (  (mrn == rs) | (mrn == rt)));//beq
    assign stall_n3 = (em2reg   & (  (ern == rs) | (ern == rt)));//lw stall
    
    
    
    assign  stall_T = (stall_n1 | stall_n2 | stall_n3) & ~bne ;
    
    
  
  
    assign flush=stall_T;
    assign stall=~stall_T;
    
    
    
    
    
    
    
endmodule
