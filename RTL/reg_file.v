module reg_file (
	input	wire	clk,
	input	wire	wr_en,
	input   wire    rst_n,
	input 	wire	[4:0]	rd_addr1,
	input 	wire	[4:0]	rd_addr2,
	input 	wire	[4:0]	wr_addr3,
	input 	wire	[31:0]	wr_data3,
	output 		    [31:0]	rd_data1,
	output 	       	[31:0]	rd_data2
	);

	// MIPS has 32 registers with 32 bits

	reg [31:0] register_file	[0:31]; //little endian
	integer i;
	
	always @(posedge  clk or negedge rst_n)
	begin
	   if(~rst_n) begin
	       for(i=0;i<32;i=i+1) begin
	           register_file[i]<=32'b0;
	       end 
	   end 
	   else if(wr_en==1'b1) begin
	          register_file[wr_addr3]<=wr_data3; 
	   end
	   else begin
	       register_file[wr_addr3]<=register_file[wr_addr3];
	   end	   
	end


	assign  rd_data1=register_file[rd_addr1];
    assign rd_data2=register_file[rd_addr2];
	
	
	 
endmodule