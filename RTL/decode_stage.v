`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2024 03:19:44 AM
// Design Name: 
// Module Name: decode_stage
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


module decode_stage(
input               clk,
input               rst_n,
input       [31:0]  pc_plus4_d,
input       [31:0]  instra_d,

//mux 
input       [31:0]  ealu,// input 1 in mux = output from alu in exe stage
input       [31:0]  malu,// input 2 in mux = output from alu in mem stage  
input       [31:0]  mmo,// input 3 in mux = memory output in mem stage 


//reg file
input       [31:0]  wdi,//rsultW = data in write back to register file
input       [4:0]   wrn,//write reg W = addres in reg file from mux rt or rd
input               wwreg,//reg write w =en write in reg file
input               stall,
input       [1:0]   fwda,fwdb,

output      [4:0]   rs,rt,
output      [31:0]  jpc,
output      [31:0]  bpc,
output      [31:0]  a, b, // operands a and b
output      [31:0]  dimm,
output      [4:0]   rn, //destination register
output      [5:0]   op,
output      [4:0]   shamt,
output      [1:0]   pcsrc, // next pc select
output              clr,
output              bgez,
output              bgtz,
output              branch,
output              bne,
//control
output  wire        wreg,
output  wire        m2reg,
output  wire        wmem,
output  wire        jal,
output  wire [3:0]  aluc,
output  wire        aluimm
    );
    
    
    
wire    [31:0]      a1,a2,a3,b1,b2,b3;    
wire                regrt;//destination addres    
wire                jump,jump_RT,is_branch_bgtz,is_branch_bgez;
wire                wreg_wire,wmem_wire; 
wire                beq,jal_J,jalr_R,jr,sw;
wire    [31:0]      qa, qb; // regfile outputs
wire                rsrtequ;
wire    [27:0]      instra_shift;
wire    [31:0]      sign_imm_shift;
wire    [31:0]      temp;
wire    [5:0]       func;



assign  func    =   instra_d[5:0]   ;
assign  op      =   instra_d[31:26] ;
assign  rs      =   instra_d[25:21] ; 
assign  rt      =   instra_d[20:16] ; 
assign  shamt   =   instra_d[10:6]  ;
   
   
// **********update jump pc value***********

assign  instra_shift  = instra_d[25:0]<<2;
assign  jpc           = {pc_plus4_d[31:28],instra_shift};

// **********update branch pc value***********

assign sign_imm_shift = dimm<<2;
adder #(32) bPC_INST(.A(sign_imm_shift),.B(pc_plus4_d),.cin(1'b0),.sum(bpc),.carry());
    
    
    
ctrl_unit contol_INS (
    .funct(func),
    .opcode(op),
    .mem_to_reg(m2reg),
    .mem_write(wmem_wire),
    .branch(branch),
    .alu_control(aluc),
    .alu_src(aluimm),
    .reg_dst(regrt),
    .reg_write(wreg_wire),
    .jump(jump),
    .jump_RT(jump_RT),
    .mfhi(),
    .mflo(),
    .mthi(),
    .mtlo(),
    .mult(),
    .multu(),
    .div(),
    .divu(),
    .lb(),  //load byte
    .lbu(), //unsigned
    .lh(),
    .lhu()
    );
      
  reg_file reg_file_INST(
    .clk(~clk),
    .rst_n(rst_n),
    .wr_en(wwreg),
    .rd_addr1(rs),
    .rd_addr2(rt),
    .wr_addr3(wrn),
    .wr_data3(wdi),
    .rd_data1(qa),
    .rd_data2(qb)
    );
       
mux4in MUX_sel_da(
    .in1(qa),   //output1 from reg file
    .in2(ealu), // output from alu in exe stage 
    .in3(malu), // output from alu in mem stage 
    .in4(mmo),  // memory output in mem stage
    .sel(fwda),
    .data_out(a3)
  );
  
  assign a2 =   (rs==wrn & wwreg & jr)?wdi:a3;
  assign a  =   (rs==wrn & wwreg & fwda==2'b00)?wdi:a2;
  
  
mux4in MUX_sel_db(
    .in1(qb),   //out 2 from reg file
    .in2(ealu), // output from alu in exe stage 
    .in3(malu), // output from alu in mem stage 
    .in4(mmo),  // memory output in mem stage
    .sel(fwdb),
    .data_out(b3)
  );
 assign b2 =   (rt==wrn & wwreg & sw)?wdi:b3;
 assign b  =   (rt==wrn & wwreg & fwdb==2'b00)?wdi:b2;
 
 
sign_ext sign_INS(
    .instruction_mem(instra_d[15:0]),
    .code(op),
    .sign_imm(dimm)
  );
         
mux RD_RT_MUX( 
    .A(rt),//rt
    .B(instra_d[15:11]), //rd
    .SEL(regrt),
    .OUT(rn)
 );


//_______________________________________________________

assign wreg    =   wreg_wire & stall; // prevent from executing twice and not write data in reg file
assign wmem    =   wmem_wire & stall; // prevent from executing twice not write in mem












assign rsrtequ =   ~|(a^b);
assign temp    =   a-32'b0;


assign is_branch_bgtz=(op==6'b000111 & temp[31]==1'b0 & (temp!=32'b0))?1'b1:1'b0;
assign is_branch_bgez=(op==6'b000001 & ((rt==5'b0) && (temp[31]==1'b1) ||  (rt==5'b00001) & (temp[31]==1'b0)  ))?1'b1:1'b0;


assign beq  =   (op==6'b000100)?    1'b1:1'b0;
assign bne  =   (op==6'b000101)?    1'b1:1'b0;   
assign bgtz =   (op==6'b000111)?    1'b1:1'b0;
assign bgez =   (op==6'b000001)?    1'b1:1'b0;
assign sw   =   (op==6'b101011)?    1'b1:1'b0;
assign jal_J=   (op==6'b000011)?    1'b1:1'b0;
assign jalr_R=  (op==6'b000000 && func==6'b001001)?1'b1:1'b0;
assign jr    =  (op==6'b000000 && func==6'b001000)?1'b1:1'b0;
assign jal   =  jal_J | jalr_R|jr; //to make dest reg 1f to write address in ra

//jump --> j,jal
//jump RT---> jr,jalr

assign pcsrc[1] =jump | jump_RT;
assign pcsrc[0] = beq & rsrtequ | bne & ~rsrtequ |jump|is_branch_bgtz|is_branch_bgez;

assign clr= pcsrc[0] |  jump_RT;


endmodule
