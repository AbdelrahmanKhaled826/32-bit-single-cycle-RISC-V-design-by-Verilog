`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2024 08:35:00 AM
// Design Name: 
// Module Name: branch_unit
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


module branch_unit(

input [4:0]    rt,
input [31:0]   srca,
input [31:0]   srcb,
input [5:0]    op_code,


output  reg      is_branch

    );
    
    wire [31:0] temp;
    wire        equal;
    
    
    assign temp=srca-32'b0;
    assign  equal=&(~(srca^srcb));  
    
    
    
    
    always@(*)begin
        case(op_code)
            6'b000100:begin //beq
                if(equal)    is_branch=1'b1;
                else    is_branch=1'b0;
            end
          
            6'b000101:begin //bneg
                 if(equal==1'b0)    is_branch=1'b1;
                 else    is_branch=1'b0;
            end
            
            6'b000001:begin //bltz or bgez
                 if((rt==5'b0) && (temp[31]==1'b1))    is_branch=1'b1; //bltz
                 else if ((rt==5'b00001) && (temp[31]==1'b0))    is_branch=1'b1; //bgez
                 else    is_branch=1'b0;
            end
            6'b000110:begin //blez
                 if((temp==32'b0) || (temp[31]==1'b1))    is_branch=1'b1; 
                 else    is_branch=1'b0;
            end            

            6'b000111:begin //bgtz
                 if(temp[31]==1'b0 && (temp!=32'b0) )    is_branch=1'b1; 
                 else    is_branch=1'b0;
            end   
            default:         is_branch=1'b0;
            
        endcase
    
    
    end
    
    
endmodule
