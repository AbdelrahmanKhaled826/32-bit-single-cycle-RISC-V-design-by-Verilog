/*module data_mem #(
parameter WIDTH=8,
parameter DEPTH=3*1024
)(
input clk,
input wr_en,
input [$clog2(DEPTH)-1:0] addr,
input [WIDTH-1:0] wr_data,
output [WIDTH-1:0] rd_data

);
reg [WIDTH-1:0] mem[0:DEPTH-1];
integer i;
initial begin
    for(i=0;i<DEPTH;i=i+1)begin
        mem[i]<=0;
    end
end

always@(negedge clk)begin
    if(wr_en) {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}<=wr_data;
    else mem[addr]<=mem[addr];
end

assign rd_data={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};

endmodule
*/


module data_mem(
input clk,
input rst_n,
input wr_en,
input [9:0] addr,
input [31:0] wr_data,
output [31:0] rd_data

);
//reg [31:0] mem[0:1023];

reg [7:0] mem[0:1023];
//reg [7:0] mem[0:1267];

integer i;


always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        for(i=0;i<1024;i=i+1)begin
            mem[i]<=32'b0;
        end
    end
     else if(wr_en==1'b0)begin
        mem[addr]<=mem[addr];
          
       end
    //else if(wr_en)begin
      //  {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}<=wr_data;
       
    //end
    else begin
      {mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}<=wr_data;
    end
end


assign rd_data={mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]};


endmodule
