`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2024 11:49:08 AM
// Design Name: 
// Module Name: adder
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


module adder #(
parameter N=32
)(
input wire  [N-1:0] A,B,
input wire  cin,
output wire [N-1:0] sum,
output wire carry
   );
   
   
  /*
  g(i)=A(i) . B(i) //generate 
  p(i)=A(i) ^ B(i) //propagate
  
  S(i)=c(i) ^ p(i)
  
  c(i+1) =g(i) + p(i).c(i)
  
  */ 
   reg [N:0] c;
   reg [N-1:0] p,g,s; 
   integer i;
  
   always @(*)begin
       c[0]=cin;
       for(i=0;i<N;i=i+1)begin
           g[i]=A[i] & B[i];
           p[i]=A[i] ^ B[i];
           s[i]=c[i] ^ p[i];
           c[i+1]=g[i]| (p[i] & c[i] ); 
          
       end
   
   end
   assign sum= s;
   assign carry=c[N];
endmodule
