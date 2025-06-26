/*module inst_mem(
input [31:0] A,
output  [31:0] RD

);
reg [31:0] mem [0:1023];

initial

begin
#30
    $readmemh("Test1.txt.mem",mem);
end




assign RD=mem[A];
 

endmodule
*/

`timescale 1ns / 1ps
module inst_mem(
input [31:0] A,
output  [31:0] RD

);
reg [7:0] mem_ins [0:1268];

initial

begin
    $readmemh("Test1.txt.mem",mem_ins);
end

assign RD={mem_ins[A+3],mem_ins[A+2],mem_ins[A+1],mem_ins[A]};



endmodule
