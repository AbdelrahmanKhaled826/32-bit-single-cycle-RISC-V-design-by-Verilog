`timescale 1ns / 1ps
module ctrl_unit (
// inputs
input wire [5:0] funct,
input wire [5:0] opcode,
input wire [5:0] rs,

// outputs
output reg mem_to_reg,					//select out from mem or not
output reg mem_write,						//control to write in mem	
output reg branch,							//control for B type
output reg [3:0] alu_control,
output reg alu_src,
output reg reg_dst,							//select rt,rd
output reg reg_write,						//control to write in RF
output reg jump,								//jumb for i type
output reg jump_RT,							//jumb for R type
output reg mfhi,								//move from high signal
output reg mflo,								//move from low signal
output reg div,									//division signal cntrol
output reg mthi,								//move to high signal
output reg mtlo,								//move to low signal
output reg divu,								//division unsigned cntrol
output reg mult,								//multiplier control signal
output reg multu,								//multiplier unsigned control signal
output reg lb,									//load byte signal control
output reg lbu,									//load unsigned byte signal control
output reg lh,									//load half word signal control
output reg lhu,									//load unsigned half word  signal control
output reg mfco,
output reg mtco,
output reg syscall,
output reg break,
output reg undefine_instruction,
output reg overflow_check,
output reg sb,
output reg  sh
);


reg [1:0] alu_op;
reg [2:0] extra_control; //for any type not R type  

always @(*)begin

undefine_instruction   =1'b0;
overflow_check=1'b0;
sb=1'b0;
sh=1'b0;
	case(opcode)

/****************************************************
				R TYPE
*******************************************/
	6'b000000:begin
        reg_write			=1'b1;
        reg_dst				=1'b1;
        alu_src				=1'b0;
        branch				=1'b0;
        mem_write			=1'b0;
        mem_to_reg		=1'b0;
        jump					=1'b0;
        alu_op				=2'b10;
        jump_RT				=1'b0;
        extra_control	=3'b0;
        mfhi					=1'b0;
        mflo					=1'b0;
        mthi					=1'b0;
        mtlo					=1'b0;
        mult 					=1'b0;
        multu					=1'b0;
        div 					=1'b0;
        divu					=1'b0;
        lb						=1'b0;
        lbu						=1'b0;
        lh						=1'b0;
        lhu						=1'b0;
        break     		=1'b0;
        mtco					=1'b0;   
        mfco      		=1'b0;
        syscall   		=1'b0;
        
       
                    case(funct)
                        6'b001001: begin //JALR
                        			jump_RT			=1'b1;
		 							reg_write		=1'b1;
                        end

                        6'b001000 : begin //jr i don't write to reg file only read ra 
                                     reg_write 		=1'b0;
                                     jump_RT		=1'b1;
                                     end  
	                    6'b010000 : begin //mfhi 
                                      mfhi			=1'b1;
                                     end  
                       6'b010010 : begin //mflo 
                                      mflo			=1'b1;
                                     end  
                         6'b010001 : begin //mthi 
                                      mthi			=1'b1;
                                     end 
                          6'b010011 : begin //mtlo 
                                      mtlo			=1'b1;
                                     end 
                          6'b011000 : begin //mult 
                                      mult			=1'b1;
                                      mthi			=1'b1;
                                      mtlo			=1'b1;
                                     end 
                          6'b011001 : begin //multu 
                                      multu			=1'b1;
                                      mthi			=1'b1;
                                      mtlo			=1'b1;	
                                     end            
                          6'b011010 : begin //div 
                                   	  div			=1'b1;
                                      mthi			=1'b1;
                                      mtlo			=1'b1;
                                     end 
                          6'b011011 : begin //divu 
                                      divu			=1'b1;
                                      mthi			=1'b1;
                                      mtlo			=1'b1;
                                     end
                          6'b001100: begin//sys call
                                      syscall       =1'b1;
                                    end 
                          6'b001101: begin//break
                                     break       =1'b1;
                                    end                  
                        endcase
		 		end
	/**********************************************************************

									   Load Store

	********************************************************************/

			 6'b100011:begin //lw
		 				reg_write		=1'b1;
		 				reg_dst			=1'b0;
		 				alu_src			=1'b1;
		 				branch			=1'b0;
		 				mem_write		=1'b0;
		 				mem_to_reg		=1'b1;
		 				jump			=1'b0;
		 				alu_op			=2'b00;
		 				jump_RT			=1'b0;
                   		extra_control   =3'b0;
                   		mfhi			=1'b0;
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                        syscall         =1'b0;
		 			end	

			 6'b101011:begin//sw
		 				reg_write		=1'b0;
		 				reg_dst			=1'b0;
		 				alu_src			=1'b1;
		 				branch			=1'b0;
		 				mem_write		=1'b1;
		 				mem_to_reg		=1'b0;
		 				jump			=1'b0;
		 				alu_op			=2'b00;
		 				jump_RT			=1'b0;
                    	extra_control   =3'b0;
                    	mfhi			=1'b0;
                    	mflo			=1'b0;
                    	mthi			=1'b0;
                    	mtlo			=1'b0;
                    	mult 			=1'b0;
                    	multu			=1'b0;
                    	div 			=1'b0;
                    	divu			=1'b0;
                    	lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;   
                   		mtco			=1'b0;   
                           mfco            =1'b0;
                   		syscall         =1'b0;
		 			end	
		 		

	/*******************************************************************

									   I TYPE

	********************************************************************/





		 	6'b001000:begin//addi
		 				reg_write	    =1'b1;
		 				reg_dst		    =1'b0;
		 				alu_src		    =1'b1;
		 				branch		    =1'b0;
		 				mem_write	    =1'b0;
		 				mem_to_reg	    =1'b0;
		 				jump		    =1'b0;
		 				alu_op		    =2'b00;
		 				jump_RT			=1'b0;
                    	extra_control   =3'b0;
                    	mfhi			=1'b0;
                    	mflo			=1'b0;
                    	mthi			=1'b0;
                    	mtlo			=1'b0;
                    	mult 			=1'b0;
                    	multu			=1'b0;
                    	div 			=1'b0;
                    	divu			=1'b0;
                    	lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                   		mtco			=1'b0;   
                           mfco            =1'b0;
                   		syscall         =1'b0;
		 			end
		 	
			6'b001001:begin//addiu unsigned
                   		reg_write       =1'b1;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b1;
                   		branch          =1'b0;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b0;
                   		jump            =1'b0;
                   		alu_op          =2'b00;
                   		jump_RT			=1'b0;
                   		extra_control   =3'b0;
                   		mfhi			=1'b0;
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                         mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
                   		
                   end

 			6'b001100 :begin //andi
                   		reg_write       =1'b1;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b1;
                   		branch          =1'b0;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b0;
                   		jump            =1'b0;
                   		alu_op          =2'b00; 
                   		jump_RT			=1'b0;
                   		extra_control   =3'b001; //for using and 
                   		mfhi			=1'b0; 
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                         mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
                 	end

          	6'b001101 :begin //ori
                   		reg_write       =1'b1;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b1;
                   		branch          =1'b0;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b0;
                   		jump            =1'b0;
                   		alu_op          =2'b00; //sub in alu
                   		jump_RT			=1'b0;
                   		extra_control   =3'b010; //for using or  
                   		mfhi			=1'b0;
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                         mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
                 end                 
          	6'b001110 :begin //xori
              			reg_write       =1'b1;
              			reg_dst         =1'b0;
              			alu_src         =1'b1;
              			branch          =1'b0;
              			mem_write       =1'b0;
              			mem_to_reg      =1'b0;
              			jump            =1'b0;
              			alu_op          =2'b00; //sub in alu
              			jump_RT			=1'b0;
              			extra_control   =3'b011; //for using or 
              			mfhi			=1'b0; 
              			mflo			=1'b0;
              			mthi			=1'b0;
              			mtlo			=1'b0;
              			mult 			=1'b0;
              			multu			=1'b0;
              			div 			=1'b0;
              			divu			=1'b0;
              			lb				=1'b0;
              			lbu				=1'b0;
              			lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
             		 end 


           	6'b001010 :begin //slti
                  		reg_write       =1'b1;
                  		reg_dst         =1'b0;
                  		alu_src         =1'b1;
                  		branch          =1'b0;
                  		mem_write       =1'b0;
                  		mem_to_reg      =1'b0;
                  		jump            =1'b0;
                  		alu_op          =2'b00; 
                  		jump_RT		  	=1'b0;
                  		extra_control   =3'b100;
                  		mfhi			=1'b0;
                  		mflo			=1'b0;
                  		mthi			=1'b0;
                  		mtlo			=1'b0;
                  		mult 			=1'b0;
                  		multu			=1'b0;
                  		div 			=1'b0;
                  		divu			=1'b0;
                  		lb				=1'b0;
                  		lbu				=1'b0;
                  		lh				=1'b0;
                  		lhu				=1'b0;
                  		break           =1'b0;
                        mtco			=1'b0;   
                          mfco            =1'b0;
                          syscall         =1'b0;
                end

        	6'b001011 :begin //sltiu
                  		reg_write       =1'b1;
                  		reg_dst         =1'b0;
                  		alu_src         =1'b1;
                  		branch          =1'b0;
                  		mem_write       =1'b0;
                  		mem_to_reg      =1'b0;
                  		jump            =1'b0;
                  		alu_op          =2'b00; 
                  		jump_RT		  	=1'b0;
                  		extra_control   =3'b101;
                  		mfhi			=1'b0;
                  		mflo			=1'b0;
                  		mthi			=1'b0;
                  		mtlo			=1'b0;
                  		mult 			=1'b0;
                  		multu			=1'b0;
                  		div 			=1'b0;
                  		divu			=1'b0;
                  		lb				=1'b0;
                  		lbu				=1'b0;
                  		lh				=1'b0;
                  		lhu				=1'b0;
                  		break           =1'b0;
                        mtco			=1'b0;   
                          mfco            =1'b0;
                          syscall         =1'b0;
          	      end
          



	/***********************************************************************

									  Branch

	*************************************************************************/



			 6'b000100:begin//beq
		 				reg_write	    =1'b0;
		 				reg_dst		    =1'b0;
		 				alu_src		    =1'b0;
		 				branch		    =1'b1;
		 				mem_write	    =1'b0;
		 				mem_to_reg	    =1'b0;
		 				jump		    =1'b0;
		 				alu_op		    =2'b01;
		 				jump_RT			=1'b0;
                    	extra_control   =3'b0;
                    	mfhi			=1'b0;
                    	mflo			=1'b0;
                    	mthi			=1'b0;
                    	mtlo			=1'b0;
                    	mult 			=1'b0;
                    	multu			=1'b0;
                    	div 			=1'b0;
                    	divu			=1'b0;
                    	lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
		 		end
		 		
		 	6'b000101:begin//bneq
                    	reg_write       =1'b0;
                    	reg_dst         =1'b0;
                    	alu_src         =1'b0;
                    	branch          =1'b1;
                    	mem_write       =1'b0;
                    	mem_to_reg      =1'b0;
                    	jump            =1'b0;
                    	alu_op          =2'b01;
                    	jump_RT			=1'b0;
                    	extra_control  	=3'b0;
                    	mfhi			=1'b0;
                    	mflo			=1'b0;
                    	mthi			=1'b0;
                    	mtlo			=1'b0;
                    	mult 			=1'b0;
                    	multu			=1'b0;
                    	div 			=1'b0;
                    	divu			=1'b0;
                    	lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
                     end
		 		
 			6'b000001 :begin //bltz or bgez
                   		reg_write       =1'b0;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b0;
                   		branch          =1'b1;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b0;
                   		jump            =1'b0;
                   		alu_op          =2'b01;
                   		jump_RT			=1'b0;
                   		extra_control   =3'b0;
                   		mfhi			=1'b0;
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
                  end

		 	6'b000110 :begin //blez
                   		reg_write       =1'b0;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b0;
                   		branch          =1'b1;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b0;
                   		jump            =1'b0;
                   		alu_op          =2'b01;
                   		jump_RT		   	=1'b0;
                   		extra_control   =3'b0;
                   		mfhi			=1'b0;
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                    	mtlo			=1'b0;
                    	mult 			=1'b0;
                    	multu			=1'b0;
                    	div 			=1'b0;
                    	divu			=1'b0;
                    	lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                   		mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
                 end
        	6'b000111 :begin //bgtz
                  		reg_write       =1'b0;
                  		reg_dst         =1'b0;
                  		alu_src         =1'b0;
                  		branch          =1'b1;
                  		mem_write       =1'b0;
                  		mem_to_reg      =1'b0;
                  		jump            =1'b0;
                  		alu_op          =2'b00;
                  		jump_RT		  	=1'b0;
                  		extra_control   =3'b0;
                  		mfhi			=1'b0;
                  		mflo			=1'b0;
                  		mthi			=1'b0;
                  		mtlo			=1'b0;
                  		mult 			=1'b0;
                  		multu			=1'b0;
                  		div 			=1'b0;
                  		divu			=1'b0;
                  		lb				=1'b0;
                  		lbu				=1'b0;
                  		lh				=1'b0;
                  		lhu				=1'b0;
                  		break           =1'b0;
                        syscall         =1'b0;
                mtco			=1'b0;   
                        mfco            =1'b0;
                end


	/**************************************************************************

									   J TYPE

	**************************************************************************/
		 	
			6'b000010:begin//j
		 				reg_write	    =1'b0;
		 				reg_dst		    =1'b0;
		 				alu_src		    =1'b0;
		 				branch		    =1'b0;
		 				mem_write	    =1'b0;
		 				mem_to_reg	    =1'b0;
		 				jump		    =1'b1;
		 				alu_op		    =2'b00;
		 				jump_RT			=1'b0;
                    	extra_control   =3'b0;
                    	mfhi			=1'b0;
                    	mflo			=1'b0;
                    	mthi			=1'b0;
                    	mtlo			=1'b0;
                    	mult 			=1'b0;
                    	multu			=1'b0;
                    	div 			=1'b0;
                    	divu			=1'b0;
                    	lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        syscall         =1'b0;
                        mtco			=1'b0;   
                        mfco            =1'b0;
		 		end
		  	6'b000011:begin//jal
                    	reg_write       =1'b1;
                    	reg_dst         =1'b0;
                    	alu_src         =1'b0;
                    	branch          =1'b0;
                    	mem_write       =1'b0;
                    	mem_to_reg      =1'b0;
                    	jump            =1'b1;
                    	alu_op          =2'b00;
                    	jump_RT			=1'b0;
                    	extra_control   =3'b0;
                    	mfhi			=1'b0;
                    	mflo			=1'b0;
                    	mthi			=1'b0;
                    	mtlo			=1'b0;
                    	mult 			=1'b0;
                    	multu			=1'b0;
                    	div 			=1'b0;
                    	divu			=1'b0;
                    	lb				=1'b0;
						lbu				=1'b0;
						lh				=1'b0;
						lhu				=1'b0;
						break           =1'b0;
                        syscall         =1'b0;
                        mtco			=1'b0;   
                        mfco            =1'b0;
                    end
       
              
/**************************************************************************

									   load

	************************************************************************/

        	6'b001111 :begin //lui
                   		reg_write       =1'b1;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b1;
                   		branch          =1'b0;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b0;
                   		jump            =1'b0;
                   		alu_op          =2'b00;
                   		jump_RT		   	=1'b0; 
                   		extra_control   =3'b000; 
                   		mfhi			=1'b0; 
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                        
                           syscall         =1'b0;
                     end 


         	6'b100000 :begin //lb
                   		reg_write       =1'b1;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b1;
                   		branch          =1'b0;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b1;
                   		jump            =1'b0;
                   		alu_op          =2'b00;
                   		jump_RT		   	=1'b0; 
                   		extra_control   =3'b000; 
                   		mfhi			=1'b0; 
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b1;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                              syscall         =1'b0;

                     end 

         	6'b100100 :begin //lbu
                   		reg_write       =1'b1;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b1;
                   		branch          =1'b0;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b1;
                   		jump            =1'b0;
                   		alu_op          =2'b00;
                   		jump_RT		   	=1'b0; 
                   		extra_control   =3'b000; 
                   		mfhi			=1'b0; 
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b1;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0; 
                           mfco            =1'b0;
                              syscall         =1'b0;
                     end 

            6'b100001 :begin //lh
                   		reg_write       =1'b1;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b1;
                   		branch          =1'b0;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b1;
                   		jump            =1'b0;
                   		alu_op          =2'b00;
                   		jump_RT		   	=1'b0; 
                   		extra_control   =3'b000; 
                   		mfhi			=1'b0; 
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b1;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                           syscall         =1'b0;
                    end 


            6'b100101 :begin //lhu
                   		reg_write       =1'b1;
                   		reg_dst         =1'b0;
                   		alu_src         =1'b1;
                   		branch          =1'b0;
                   		mem_write       =1'b0;
                   		mem_to_reg      =1'b1;
                   		jump            =1'b0;
                   		alu_op          =2'b00;
                   		jump_RT		   	=1'b0; 
                   		extra_control   =3'b000; 
                   		mfhi			=1'b0; 
                   		mflo			=1'b0;
                   		mthi			=1'b0;
                   		mtlo			=1'b0;
                   		mult 			=1'b0;
                   		multu			=1'b0;
                   		div 			=1'b0;
                   		divu			=1'b0;
                   		lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b1;
                   		break           =1'b0;
                           syscall         =1'b0;
                        mtco			=1'b0;   
                           mfco            =1'b0;
                     end 
                     
                     
                     
      6'b101000:begin//sb
                        reg_write        =1'b0;
                        reg_dst            =1'b0;
                        alu_src            =1'b1;
                        branch            =1'b0;
                        mem_write        =1'b1;
                        mem_to_reg        =1'b0;
                        jump            =1'b0;
                        alu_op            =2'b00;
                        jump_RT            =1'b0;
                       extra_control   =3'b0;
                       mfhi            =1'b0;
                       mflo            =1'b0;
                       mthi            =1'b0;
                       mtlo            =1'b0;
                       mult             =1'b0;
                       multu            =1'b0;
                       div             =1'b0;
                       divu            =1'b0;
                       lb                =1'b0;
                          lbu                =1'b0;
                          lh                =1'b0;
                          lhu                =1'b0;
                          break           =1'b0;  
                          mtco            =1'b0;   
                          mfco            =1'b0;
                          syscall         =1'b0;
                          sb=1'b1;
                          sh=1'b0;
                    end    
                     
                     
                      6'b101000:begin//sh
                                           reg_write        =1'b0;
                                           reg_dst            =1'b0;
                                           alu_src            =1'b1;
                                           branch            =1'b0;
                                           mem_write        =1'b1;
                                           mem_to_reg        =1'b0;
                                           jump            =1'b0;
                                           alu_op            =2'b00;
                                           jump_RT            =1'b0;
                                          extra_control   =3'b0;
                                          mfhi            =1'b0;
                                          mflo            =1'b0;
                                          mthi            =1'b0;
                                          mtlo            =1'b0;
                                          mult             =1'b0;
                                          multu            =1'b0;
                                          div             =1'b0;
                                          divu            =1'b0;
                                          lb                =1'b0;
                                             lbu                =1'b0;
                                             lh                =1'b0;
                                             lhu                =1'b0;
                                             break           =1'b0;   
                                             mtco            =1'b0;   
                                             mfco            =1'b0;
                                             syscall         =1'b0;
                                             sb=1'b0;
                                             sh=1'b1;
                                       end    
                     
                     
                     

 	6'b010000 :begin //mtco mfco
              			reg_dst         =1'b0;
              			alu_src         =1'b1;
              			branch          =1'b0;
              			mem_write       =1'b0;
              			mem_to_reg      =1'b0;
              			jump            =1'b0;
              			alu_op          =2'b00; 
              			jump_RT			=1'b0;
              			extra_control   =3'b000; 
              			mfhi			=1'b0; 
              			mflo			=1'b0;
              			mthi			=1'b0;
              			mtlo			=1'b0;
              			mult 			=1'b0;
              			multu			=1'b0;
              			div 			=1'b0;
              			divu			=1'b0;
              			lb				=1'b0;
              			lbu				=1'b0;
              			lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                        syscall         =1'b0;
                   		if(rs==5'b0)  begin 
                   		mfco		    =1'b1;
                   		reg_write       =1'b1;
                   		end
                   		else begin  		
                   		mtco			=1'b1;
                   		reg_write       =1'b0;                     
                     end
                     end 


              
              
		 	default:begin
		 				reg_write	    =1'b0;
		 				reg_dst		    =1'b0;
		 				alu_src		    =1'b0;
		 				branch		    =1'b0;
		 				mem_write	    =1'b0;
		 				mem_to_reg	    =1'b0;
		 				jump		    =1'b0;
		 				alu_op		    =2'b00;
		 				jump_RT			=1'b0;
                    	extra_control   =3'b0;
                    	mfhi			=1'b0;
                    	mflo			=1'b0;
                    	mthi			=1'b0;
                    	mtlo			=1'b0;
                    	mult 			=1'b0;
                    	multu			=1'b0;
                    	div 			=1'b0;
                    	divu			=1'b0;
                    	lb				=1'b0;
                   		lbu				=1'b0;
                   		lh				=1'b0;
                   		lhu				=1'b0;
                   		break           =1'b0;
                           syscall         =1'b0;
                        mtco			=1'b0;
                        mfco		    =1'b0;
                        undefine_instruction   =1'b1;
		 		end
	endcase
end



always @(*) begin

casex({alu_op ,funct,extra_control})

11'b00_xxxxxx_000 :begin alu_control = 4'b0010;end //add
11'bx1_xxxxxx_000 :begin alu_control = 4'b0110;end //subtract
11'b1x_100000_000 :begin overflow_check=1'b1; alu_control = 4'b0010;end //add
11'b1x_100010_000 :begin overflow_check=1'b1; alu_control = 4'b0110;end //subtract
11'b1x_100100_000 :begin alu_control = 4'b0000;end //and
11'b1x_100101_000 :begin alu_control = 4'b0001;end //or
11'b1x_101010_000 :begin alu_control = 4'b0111;end //slt
11'b10_100001_000 :begin alu_control = 4'b0010;end //add for addu
11'b10_100011_000 :begin alu_control = 4'b0110;end //sub for subu 
11'b10_100110_000 :begin alu_control = 4'b0100;end //xor
11'b10_100111_000 :begin alu_control = 4'b0101;end //nor
11'b1x_101011_000 :begin alu_control = 4'b1000;end //sltu
11'b10_000000_000 :begin alu_control = 4'b1001;end //sll
11'b10_000010_000 :begin alu_control = 4'b1010;end //srl
11'b10_000011_000 :begin alu_control = 4'b1011;end //sra
11'b10_000100_000 :begin alu_control = 4'b1100;end //sllv
11'b10_000110_000 :begin alu_control = 4'b1101;end //srlv
11'b10_000111_000 :begin alu_control = 4'b1110;end //srav
11'bxx_xxxxxx_001 :begin alu_control = 4'b0000;end //andi
11'bxx_xxxxxx_010 :begin alu_control = 4'b0001;end //ori
11'bxx_xxxxxx_011 :begin alu_control = 4'b0100;end //xori
11'bxx_xxxxxx_100 :begin alu_control = 4'b0111;end //slti
11'bxx_xxxxxx_101 :begin alu_control = 4'b1000;end //sltiu
    
default : alu_control = 4'b0010; //default
        
endcase
end

endmodule