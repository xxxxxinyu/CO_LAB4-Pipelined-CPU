// 109550085
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 23:17:42
// Design Name: 
// Module Name: Decoder
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


module Decoder(
    instr_op_i,
    MemToReg_o,
    MemRead_o,
    MemWrite_o,
    RegWrite_o,
    ALU_op_o,
    ALUSrc_o,
    RegDst_o,
    Branch_o
    );
    
//I/O ports
input  [6-1:0] instr_op_i;

output         MemToReg_o;
output         MemRead_o;
output         MemWrite_o;
output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg            MemRead_o;
reg            MemWrite_o;
reg            MemToReg_o;
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter
always @(*)
begin
    MemToReg_o = (instr_op_i == 6'b100011) ? 1'b1:1'b0;   // lw => 1, other => 0
    RegDst_o = (instr_op_i == 6'b000000 || instr_op_i == 6'b011100) ? 1'b1:1'b0;     // R-type mul 
    // addi, R-type, lw, mul
    RegWrite_o = ((instr_op_i == 6'b001000) || (instr_op_i == 6'b000000) || (instr_op_i == 6'b100011) || (instr_op_i == 6'b011100)) ? 1'b1:1'b0;
    Branch_o = (instr_op_i == 6'b000100) ? 1'b1:1'b0;       // beq
    ALUSrc_o = (instr_op_i == 6'b001000 || instr_op_i == 6'b100011 || instr_op_i == 6'b101011) ? 1'b1:1'b0;     // addi lw sw
    MemWrite_o = (instr_op_i == 6'b101011) ? 1'b1:1'b0;     // sw
    MemRead_o = (instr_op_i == 6'b100011) ? 1'b1:1'b0;      // lw

    
    ALU_op_o = (instr_op_i == 6'b000000) ? 3'b010:          // R-type
               (instr_op_i == 6'b001000 || instr_op_i == 6'b100011 || instr_op_i == 6'b101011) ? 3'b100:    // addi lw sw
               (instr_op_i == 6'b000100) ? 3'b011:          // beq
               (instr_op_i == 6'b001010) ? 3'b111:          // slti
               (instr_op_i == 6'b011100) ? 3'b001:3'b000;   // mul
end

//Main function

endmodule
