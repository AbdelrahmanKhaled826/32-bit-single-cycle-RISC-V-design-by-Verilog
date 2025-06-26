`timescale 1ns / 1ps
module MIPS(
input clk,
input rst_n,
input interrput,

output wire [3:0] write_data
    );
    
    
     wire 		    [31:0]      pc_out;
     wire 		    [31:0]      pc_jumb;
     wire 		    [31:0]      pc_dash;
     wire 		    [31:0]  	pcplus4; 
     wire 		    [31:0]      pcbranch;
     wire 		    [31:0]      pc_dash_dash;
     wire 		    [31:0]      pc_dash_dash_dash;
     wire 		    [31:0]      instra;
     wire 		    [27:0]      instra_shift;
     wire 		    [4:0]  		des_add;
     wire 		    [4:0]  		wr_addr3_wire;
     wire 		    [31:0]  	result;
     wire 		    [31:0]  	write_data3_wire;
     wire 		    [31:0]  	srcA;
     wire 		    [31:0]  	srcA_s_or_us;
     wire 		    [31:0]  	read_data2_regfile;
     wire 		    [31:0]  	sign_imm;
     wire 		    [33:0]  	sign_imm_shift;
     wire 		    [31:0]  	srcB;
     wire signed 	[31:0]		alu_res;
     wire 						pcsrc;
     wire 		    [31:0]  	read_data_mem;
     wire           [31:0]      hi_out;
     wire           [31:0]      lo_out;
     wire           [31:0]      div_high;
     wire           [31:0]      div_low;
     wire           [31:0]      mul_high;
     wire           [31:0]      mul_low;
     wire           [31:0]      mux_high_out;
     wire           [31:0]      mux_low_out;
     wire           [31:0]      data_out_from_mem;
     wire           [31:0]      co;
     wire           [31:0]      write_data3;
     wire           [31:0]      write_data_to_mem;


     wire 		reg_write;
     wire 		reg_dst;
     wire 		alusrc;
     wire [3:0] alu_control;
     wire 		zero;
     wire 		memtoreg;
     wire 		memwrite;
     wire 		branch;
     wire       jump;
     wire       is_branch;
     wire       jump_RT;
     wire       is_jump;
     wire       mfhi;
     wire       mflo;
     wire       mtlo;
     wire       mthi;
     wire       mult;
     wire       multu;
     wire       div;
     wire       divu;
     wire       lb;
     wire       lbu;
     wire       lh;
     wire       lhu;
     wire       break;
     wire       syscall;
     wire       mtco;
     wire       mfco;
     wire       undefine_instruction;
     wire       overflow;
     wire       div_by_zero;
     wire       overflow_check;
     wire       sb;
     wire       sh;
/*****************************************************************
                              data_path    
/*****************************************************************/
  
  
    mux4in select_pc_INS(
    .in1(pcplus4),
    .in2(pc_jumb),
    .in3(pcbranch),
    .in4(32'bx),
    .sel({pcsrc,jump}),
    .data_out(pc_dash)
    );
    
 assign pc_dash_dash=(jump_RT==1'b1)? srcA:pc_dash;
 assign pc_dash_dash_dash=(interrput|syscall|break|div_by_zero|overflow|undefine_instruction)? 32'b10000000000000000000000110000000:pc_dash_dash; //***********  
    
    pc_reg PC_INST (
    .clk(clk),
    .rst_n(rst_n),
    .pc_next(pc_dash_dash_dash),
    .pc(pc_out)
   	);
 
    inst_mem inst_mem_INST(
	.A(pc_out),
	.RD(instra)
	);
	
	
    exception_unit EXP_INS (  //***************
    .clk(clk),
    .rst_n(rst_n),
    .overflow(overflow),//**********************
    .intrupt(interrput),//**************************
    .syscall(syscall), //**********************
    .div_by_zero(div_by_zero),   //************************
    .undefine_instraction(undefine_instruction), 
    .break(break),
    .mtco(mtco),
    .pc(pc_out),
    .pc_plus4(pcplus4),
    .data_in(read_data2_regfile), //from rd2 reg file
    .rd(instra[15:11]), //15:11
    .co(co)
       );

    mux RD_MUX( 
    .A(instra[20:16]),
    .B(instra[15:11]),  
    .SEL(reg_dst),
    .OUT(des_add)
     );
     

    assign is_jump= jump_RT | jump; 
    assign wr_addr3_wire = (is_jump==1'b1)? 5'b11111:des_add;


    reg_file reg_file_INST(
	.clk(clk),
	.rst_n(rst_n),
	.wr_en(reg_write),
	.rd_addr1(instra[25:21]),
	.rd_addr2(instra[20:16]),
	.wr_addr3(wr_addr3_wire),
	.wr_data3(write_data3),
	.rd_data1(srcA),
	.rd_data2(read_data2_regfile)
	);
 assign write_data3 =(mfco)? co:write_data3_wire;  //**********************

    sign_ext sign_INS(
	.instruction_mem(instra[15:0]),
	.code(instra[31:26]),
	.sign_imm(sign_imm)
    );

    mux srcB_MUX(  
    .A(read_data2_regfile),
    .B(sign_imm),  
    .SEL(alusrc),
    .OUT(srcB)
    );

  
    alu ALU_INS(
	.op_code(alu_control),
	.srca(srcA),
	.srcb(srcB),
	.shamt(instra[10:6]),
	.alu_res(alu_res),
	.zero_flag(zero),
	.overflow_check(overflow_check),
	.overflow(overflow)
	);
	
	
	store_unit STOR_INS(
    .data_in(read_data2_regfile),
    .sb(sb),
    .sh(sh),
    .data_out(write_data_to_mem)
        );

	data_mem data_mem_INS(
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(memwrite),
    .addr(alu_res),
    .wr_data(write_data_to_mem),
    .rd_data(read_data_mem)
    );
        
        
    load_from_mem load_mem_INS(
    .read_data(read_data_mem),
    .lb(lb),  //load byte
    .lbu(lbu), //unsigned
    .lh(lh),
    .lhu(lhu),
    .data_out_from_mem(data_out_from_mem)   
    );


          

	branch_unit branch_unit_INS(
   	.rt(instra[20:16]),
   	.srca(srcA),
   	.srcb(srcB),
   	.op_code(instra[31:26]),
  	//.zero_flag(zero),
 	.is_branch(is_branch)
     );


	mult mul_INS(
	.in1(srcA),
	.in2(read_data2_regfile),
	.un_signed(multu),
	.mul_en(mult|multu),
	.high(mul_high),
	.low(mul_low)
	);
	
	div div_INS(
	.in1(srcA),
	.in2(read_data2_regfile),
	.un_signed(divu),
	.div_en(div | divu),
	.high(div_high),
	.low(div_low),
	.div_by_zero(div_by_zero)
	);
    

	mux8in sel_hi_INS(
	.in1(srcA),
	.in2(mul_high),
	.in3(div_high),
	.sel({div|divu,mult|multu,mtlo}),
	.out_data(mux_high_out)
	);
	
	
	mux8in sel_lo_INS(
	.in1(srcA),
	.in2(mul_low),
	.in3(div_low),
	.sel({div|divu,mult|multu,mthi}),
	.out_data(mux_low_out)
	);
	
	register  HI_REG(
	.clk(clk),
	.rst_n(rst_n),
	.wr_en(mthi),
	.rd_en(mfhi),
	.D(mux_high_out),
	.Q(hi_out)
	);

 	register  LO_REG(
 	.clk(clk),
 	.rst_n(rst_n),
 	.wr_en(mtlo),
 	.rd_en(mfhi),
 	.D(mux_low_out),
 	.Q(lo_out)
 	);


	mux16in select_result_INS(
    .in1(alu_res),
    .in2(data_out_from_mem),
    .in3(pcplus4),
    .in4(hi_out),
    .in5(lo_out),
    .sel({mflo,mfhi,is_jump,memtoreg}),
    .out_data(write_data3_wire)          
     );

   
/*****************************************************************
                             controller
/*****************************************************************/

ctrl_unit contol_INS (
.funct(instra[5:0]),
.opcode(instra[31:26]),
.rs(instra[25:21]),
.mem_to_reg(memtoreg),
.mem_write(memwrite),
.branch(branch),
.alu_control(alu_control),
.alu_src(alusrc),
.reg_dst(reg_dst),
.reg_write(reg_write),
.jump(jump),
.jump_RT(jump_RT),
.mfhi(mfhi),
.mflo(mflo),
.mthi(mthi),
.mtlo(mtlo),
.mult(mult),
.multu(multu),
.div(div),
.divu(divu),
.lb(lb),  //load byte
.lbu(lbu), //unsigned
.lh(lh),
.lhu(lhu),
.mtco(mtco),
.mfco(mfco),
.syscall(syscall),
.break(break),
.undefine_instruction(undefine_instruction),
.overflow_check(overflow_check),
.sb(sb),
. sh(sh)
);


   
/*****************************************************************
                              pc valus
/*****************************************************************/
    assign pcplus4= pc_out+32'd4;
    assign instra_shift =instra[25:0]<<2;
    assign pc_jumb={pcplus4[31:28],instra_shift};
    assign sign_imm_shift=sign_imm<<2;
    assign pcbranch=sign_imm_shift+pcplus4;
    assign pcsrc= is_branch & branch ;



    assign write_data=write_data3_wire[3:0];
    
    
    

endmodule
