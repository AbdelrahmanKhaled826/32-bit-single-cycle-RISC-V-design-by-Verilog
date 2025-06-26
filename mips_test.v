`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2024 01:00:37 PM
// Design Name: 
// Module Name: mips_test
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


module mips_test;
	
reg clk;
reg rst_n;
reg interrput;
//wire [31:0] pc;
//wire [31:0] alu_reslt;
//wire mem_write;
//wire [31:0] write_data;
wire [3:0] write_data;

MIPS mips_INS(
.clk(clk),
.rst_n(rst_n),
.interrput(interrput),
//.pc(pc),
//.alu_reslt(alu_reslt),
//.mem_write(mem_write),
.write_data(write_data)
);



initial begin
	clk=0;
	
	//rst_n=1;
	//#3
	rst_n=0;
	interrput=0;
	#7 
	rst_n=1;
	#1000;
	$finish;
end

always #5 clk=~clk;

endmodule