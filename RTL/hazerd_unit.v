`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2024 11:00:15 PM
// Design Name: 
// Module Name: hazerd_unit
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


module hazerd_unit(
//forwarding input
input           reg_write_m,
input           reg_write_w,
input   [4:0]   rs_e,
input   [4:0]   rt_e,
input   [4:0]   writereg_m,
input   [4:0]   writereg_w,
//stalling input 
input           memtoreg_e,
input   [4:0]  rs_d,
input   [4:0]  rt_d,
//control input
input   branch_d,
input   reg_write_e,
input   memtoreg_m,
input   [4:0]   writereg_e,



//forwarding output
output  reg  [1:0]   forwardAE,
output  reg  [1:0]   forwardBE,

//stelling
output       stallf,
output       stalld,
output       flushe,
//control
output     forwardAD,
output      forwardBD
 );
    
    reg lwstall;
    
always @(*)begin
        if((rs_e!=0) && (rs_e==writereg_m) && reg_write_m )          forwardAE=2'b10;
        else if((rs_e!=0) && (rs_e==writereg_w) && reg_write_w)      forwardAE=2'b01;
        else    forwardAE=2'b00;
   end
    
always @(*)begin    
        if((rt_e!=0) && (rt_e==writereg_m) && reg_write_m )          forwardBE=2'b10;
        else if((rt_e!=0) && (rt_e==writereg_w) && reg_write_w)      forwardBE=2'b01; //else if((rt_e!=0) && (rt_e==writereg_e) && reg_write_e)      forwardBE=2'b01;
        else    forwardBE=2'b00;
    end



always @(*)begin
        if(((rs_d==rt_e) || (rt_d==rt_e)) && memtoreg_e )   lwstall=1'b1;
        else       lwstall=1'b0;
    end
    

      

   wire branchstall_cond1,branchstall_cond2,branchstall;
   
    
    assign branchstall_cond1 = ((branch_d && reg_write_e &&((writereg_e == rs_d) || (writereg_e == rt_d))));
   assign branchstall_cond2 =  ((branch_d&& memtoreg_m&&((writereg_m == rs_d) ||(writereg_m == rt_d))));
   assign branchstall = branchstall_cond1 || branchstall_cond2;
    
    assign stallf= branchstall || lwstall;
    assign stalld= branchstall || lwstall;
    assign flushe= branchstall || lwstall;
    
    
   assign forwardAD=   (rs_d != 5'b0) && (rs_d==writereg_m) && reg_write_m ;
//   assign forwardBD=   (rt_d != 5'b0) && (rt_d==writereg_m) && reg_write_m ;

assign forwardBD=   (rt_d != 5'b0) && (rt_d==writereg_e) && reg_write_e  ;


    
endmodule
