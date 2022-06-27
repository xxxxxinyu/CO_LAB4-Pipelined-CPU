//109550085
`timescale 1ns / 1ps
//Subject:     CO project 4 - Pipe CPU 1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Pipe_CPU_1(
    clk_i,
    rst_i
    );
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
wire [32-1:0] pc_out; 
wire [32-1:0] add_pc_o; 
wire [32-1:0] im_out; 
wire          PCSrc;
wire [32-1:0] mux0_o;
wire [64-1:0] IF_ID_i;
wire [64-1:0] IF_ID_o;

wire [5-1:0]  RSaddr;
wire [5-1:0]  RTaddr;
wire [5-1:0]  RDaddr;
wire [32-1:0] RSdata_out;
wire [32-1:0] RTdata_out;
wire [6-1:0]  instr;
wire          MemToReg;
wire          MemRead;
wire          MemWrite;
wire          RegWrite;
wire [3-1:0]  alu_op;
wire          alu_src;
wire          RegDst;
wire          Branch;
wire [16-1:0] imm;
wire [32-1:0] sign_ext_out;
wire [32-1:0] pc_ID;
wire [148-1:0] ID_EX_i;
wire [148-1:0] ID_EX_o;

wire          RegDst_EX; 
wire [3-1:0]  alu_op_EX;
wire          alu_src_EX;
wire [32-1:0] pc_EX;
wire [32-1:0] RSdata_EX;
wire [32-1:0] RTdata_EX;
wire [32-1:0] sign_ext_EX;
wire [5-1:0]  RTaddr_EX;
wire [5-1:0]  RDaddr_EX;
wire [32-1:0] shift_left_out;
wire [32-1:0] alu_result;
wire          alu_zero;
wire [4-1:0]  alu_ctrl_out;
wire [32-1:0] mux_alusrc_out;
wire [5-1:0]  write_reg;
wire [32-1:0] branch_addr;
wire [107-1:0] EX_MEM_i;
wire [107-1:0] EX_MEM_o;

wire          Branch_DM;
wire          MemRead_DM;
wire          MemWrite_DM;
wire [32-1:0] branch_addr_DM;
wire          alu_zero_DM;
wire [32-1:0] alu_result_DM;
wire [32-1:0] RTdata_DM;
wire [32-1:0] write_reg_DM;
wire [32-1:0] DM_out;
wire [71-1:0] DM_i;
wire [71-1:0] DM_o;

wire          RegWrite_WB;
wire          MemToReg_WB;
wire [32-1:0] DM_WB;
wire [32-1:0] alu_result_WB;
wire [32-1:0] write_reg_WB;
wire [32-1:0] write_data;

/**** IF stage ****/
assign IF_ID_i[32-1:0] = im_out[32-1:0];
assign IF_ID_i[64-1:32] = add_pc_o[32-1:0];
assign PCSrc = Branch_DM & alu_zero_DM;

/**** ID stage ****/

//control signal
assign pc_ID = IF_ID_o[64-1:32];
assign instr = IF_ID_o[31:26];
assign RSaddr = IF_ID_o[25:21];
assign RTaddr = IF_ID_o[20:16];
assign RDaddr = IF_ID_o[15:11];
assign imm = IF_ID_o[16-1:0];

assign ID_EX_i[5-1:0] = RDaddr;
assign ID_EX_i[10-1:5] = RTaddr;
assign ID_EX_i[42-1:10] = sign_ext_out;
assign ID_EX_i[74-1:42] = RTdata_out;
assign ID_EX_i[106-1:74] = RSdata_out;
assign ID_EX_i[138-1:106] = pc_ID;
assign ID_EX_i[138] = alu_src;
assign ID_EX_i[142-1:139] = alu_op;
assign ID_EX_i[142] = RegDst;
assign ID_EX_i[143] = MemWrite;
assign ID_EX_i[144] = MemRead;
assign ID_EX_i[145] = Branch;
assign ID_EX_i[146] = MemToReg;
assign ID_EX_i[147] = RegWrite;

/**** EX stage ****/

//control signal
assign RDaddr_EX = ID_EX_o[5-1:0];
assign RTaddr_EX = ID_EX_o[10-1:5];
assign sign_ext_EX = ID_EX_o[42-1:10];
assign RTdata_EX = ID_EX_o[74-1:42];
assign RSdata_EX = ID_EX_o[106-1:74];
assign pc_EX = ID_EX_o[138-1:106];
assign alu_src_EX = ID_EX_o[138];
assign alu_op_EX = ID_EX_o[142-1:139];
assign RegDst_EX = ID_EX_o[142];

assign EX_MEM_i[5-1:0] = write_reg;
assign EX_MEM_i[37-1:5] = RTdata_EX;
assign EX_MEM_i[69-1:37] = alu_result;
assign EX_MEM_i[69] = alu_zero;
assign EX_MEM_i[102-1:70] = branch_addr;
assign EX_MEM_i[106:102] = ID_EX_o[147:143];

/**** MEM stage ****/

//control signal
assign write_reg_DM = EX_MEM_o[5-1:0];
assign RTdata_DM = EX_MEM_o[37-1:5];
assign alu_result_DM = EX_MEM_o[69-1:37];
assign alu_zero_DM = EX_MEM_o[69];
assign branch_addr_DM = EX_MEM_o[102-1:70];
assign MemWrite_DM = EX_MEM_o[102];
assign MemRead_DM = EX_MEM_o[103];
assign Branch_DM = EX_MEM_o[104];

assign DM_i[5-1:0] = write_reg_DM;
assign DM_i[37-1:5] = alu_result_DM;
assign DM_i[69-1:37] = DM_out;
assign DM_i[69] = EX_MEM_o[105];
assign DM_i[70] = EX_MEM_o[106];

/**** WB stage ****/

//control signal
assign write_reg_WB = DM_o[5-1:0];
assign alu_result_WB = DM_o[37-1:5];
assign DM_WB = DM_o[69-1:37];
assign MemToReg_WB = DM_o[69];
assign RegWrite_WB = DM_o[70];

/****************************************
Instantiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) Mux0(
        .data0_i(add_pc_o),
        .data1_i(branch_addr_DM), 
        .select_i(PCSrc),
        .data_o(mux0_o)
);

ProgramCounter PC(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .pc_in_i(mux0_o),
        .pc_out_o(pc_out)
);

Instruction_Memory IM(
        .addr_i(pc_out),  
	    .instr_o(im_out) 
);
			
Adder Add_pc(
        .src1_i(pc_out),
        .src2_i(32'd4),
        .sum_o(add_pc_o)
);

Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(IF_ID_i),
        .data_o(IF_ID_o)
);

//Instantiate the components in ID stage
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(RSaddr) ,  
        .RTaddr_i(RTaddr) ,  
        .RDaddr_i(write_reg_WB) ,  
        .RDdata_i(write_data) , 
        .RegWrite_i (RegWrite_WB), 
        .RSdata_o(RSdata_out) ,  
        .RTdata_o(RTdata_out)
);

Decoder Control(
        .instr_op_i(instr),
        .MemToReg_o(MemToReg),
        .MemRead_o(MemRead),
        .MemWrite_o(MemWrite),
        .RegWrite_o(RegWrite),
        .ALU_op_o(alu_op),
        .ALUSrc_o(alu_src),
        .RegDst_o(RegDst),
        .Branch_o(Branch)
);

Sign_Extend Sign_Extend(
        .data_i(imm),
        .data_o(sign_ext_out)
);	

Pipe_Reg #(.size(148)) ID_EX(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(ID_EX_i),
        .data_o(ID_EX_o)
);


//Instantiate the components in EX stage	   
Shift_Left_Two_32 Shifter(
        .data_i(sign_ext_EX),
        .data_o(shift_left_out)
);

ALU ALU(
        .src1_i(RSdata_EX),
	    .src2_i(mux_alusrc_out), 
	    .ctrl_i(alu_ctrl_out), 
	    .result_o(alu_result),
		.zero_o(alu_zero)
);
		
ALU_Control ALU_Control(
        .funct_i(sign_ext_EX[5:0]),   
        .ALUOp_i(alu_op_EX),   
        .ALUCtrl_o(alu_ctrl_out) 
);

MUX_2to1 #(.size(32)) Mux1(
        .data0_i(RTdata_EX),
        .data1_i(sign_ext_EX),
        .select_i(alu_src_EX),
        .data_o(mux_alusrc_out)
);
		
MUX_2to1 #(.size(5)) Mux2(
        .data0_i(RTaddr_EX),
        .data1_i(RDaddr_EX),
        .select_i(RegDst_EX),
        .data_o(write_reg)
);

Adder Add_pc_branch(
        .src1_i(pc_EX),     
	    .src2_i(shift_left_out),     
	    .sum_o(branch_addr)   
);

Pipe_Reg #(.size(107)) EX_MEM(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(EX_MEM_i),
        .data_o(EX_MEM_o)
);


//Instantiate the components in MEM stage
Data_Memory DM(
        .clk_i(clk_i),
        .addr_i(alu_result_DM),
        .data_i(RTdata_DM),
        .MemRead_i(MemRead_DM),
        .MemWrite_i(MemWrite_DM),
        .data_o(DM_out)
);

Pipe_Reg #(.size(71)) MEM_WB(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .data_i(DM_i),
        .data_o(DM_o)
);


//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
        .data0_i(alu_result_WB),
        .data1_i(DM_WB),
        .select_i(MemToReg_WB),
        .data_o(write_data)
);

/****************************************
signal assignment
****************************************/

endmodule

