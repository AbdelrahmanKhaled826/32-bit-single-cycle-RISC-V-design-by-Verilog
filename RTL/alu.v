
module alu (
	input 	wire 		     [3:0]	op_code,
	input 	wire    signed	 [31:0]	srca,
	input	wire 	signed   [31:0]	srcb,
	input   wire             [4:0]  shamt,
	input   wire             overflow_check,
	output	reg     signed   [31:0] alu_res,
	output  overflow,
	output zero_flag
	);


wire   [31:0]	srca_unsigned;
wire   [31:0]	srcb_unsigned;
wire   [31:0]   alu_res_temp; 
wire   [31:0]   srca_2s,srcb_2s,alu_sum;


adder #(32) srca_2s_INS(.A(~srca),.B(32'd1),.cin(1'b0),.sum(srca_2s),.carry());
adder #(32) srcb_2s_INS(.A(~srcb),.B(32'd1),.cin(1'b0),.sum(srcb_2s),.carry());
adder #(32) sum_INS(.A(srca),.B(srcb),.cin(1'b0),.sum(alu_sum),.carry());



assign srca_unsigned=(srca[31]==1'b1)? srca_2s:srca;
assign srcb_unsigned=(srcb[31]==1'b1)? srcb_2s:srcb;

assign alu_res_temp= srca - 	srcb;

	always @(*)begin
		case(op_code)
		4'b0000:	alu_res=	srca & 	srcb;
		4'b0001:	alu_res=	srca | 	srcb;
		4'b0010:	alu_res=	alu_sum;
		4'b0011:                             ;
		4'b0100:	alu_res=	srca ^  srcb;
		4'b0101:	alu_res=  ~(srca |  srcb);
		4'b0110:	alu_res=   alu_res_temp;  //sub
		4'b0111:begin//slt
			         alu_res=	alu_res_temp;
			         alu_res={{31{1'b0}},alu_res[31]};
			     end
		4'b1000: begin //sltu
		             alu_res= srca_unsigned - srcb_unsigned	;  
		             alu_res={{31{1'b0}},alu_res[31]};
		          end               
		4'b1001:     alu_res= srcb << shamt  ;//sll 
		4'b1010:     alu_res= srcb >> shamt   ;//srl
		4'b1011:     alu_res= srcb >>> shamt  ;//sra //alu_res={ {12{srcb[31]}}, srcb[31:12] };
		4'b1100:     alu_res= srcb << srca[4:0]    ; //sllv
		4'b1101:     alu_res= srcb >> srca[4:0]    ;//srlv
		4'b1110:     alu_res= srcb >>> srca[4:0]  ;//srav
		4'b1111:                             ;
		default:alu_res=	srca ;
       endcase
	end

	assign zero_flag =(alu_res==32'b0)?1'b1:1'b0;
	assign overflow=(overflow_check)? srca[31] & srcb[31] & ~alu_sum[31] | ~srca[31] & ~srcb[31] & alu_sum[31] | ~srca[31] & srcb[31] & alu_res_temp[31] | srca[31] & ~srcb[31] & ~alu_res_temp[31] :1'b0;
	
	
endmodule