`timescale 1ns / 1ps
module exception_unit (

input			clk,
input			rst_n,

input			overflow,
input			intrupt,
input 			syscall,
input 			div_by_zero,
input 			undefine_instraction,
input   		break,

input 			mtco,

input 	[31:0]	pc,
input   [31:0]	pc_plus4,
input   [31:0]	data_in, //from rd2 reg file

input   [4:0]	rd, //15:11

output	[31:0]	co

	);

reg 	[31:0]	cause;
reg		[31:0]	EPC;
reg 	[31:0]	exc_mem	[0:31]; //[13] cause,[14] EPC
integer i;
always @(posedge clk or negedge rst_n) begin
	
	if(~rst_n) begin	
		for(i=0;i<32;i=i+1)begin
			exc_mem[i]<=32'b0;
		end
	end
	else if (mtco) begin
				if (intrupt) begin
						exc_mem[13]<=8'h00000000;
						exc_mem[14]<=pc_plus4;
				end
				else if (syscall) begin
						exc_mem[13]<=8'h00000020;
						exc_mem[14]<=pc;
				end
				else if (break | div_by_zero)begin 
						exc_mem[13]<=8'h00000024;
						exc_mem[14]<=pc;
				end
				else if (undefine_instraction)begin 
						exc_mem[13]<=8'h00000028;
						exc_mem[14]<=pc;
				end
				else if (overflow)begin 
						exc_mem[13]<=8'h00000030;
						exc_mem[14] <=pc;
				end
				else begin
						exc_mem[13]<=data_in;
				end
	end
	else begin
		exc_mem[13]<=8'h00000000;
		exc_mem[14]<=8'h0;
		end
end
assign co = exc_mem[rd]; 



endmodule