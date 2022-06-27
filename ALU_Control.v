//109550085
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 23:17:42
// Design Name: 
// Module Name: ALU_Ctrl
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


module ALU_Control(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
    );
    
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

       
//Select exact operation
always @(*)
begin
    ALUCtrl_o = (ALUOp_i == 3'b010 && funct_i == 6'b100000) ? 4'b0010:    // add 2
                (ALUOp_i == 3'b010 && funct_i == 6'b100010) ? 4'b0110:    // sub 6
                (ALUOp_i == 3'b010 && funct_i == 6'b100100) ? 4'b0000:    // and 0
                (ALUOp_i == 3'b010 && funct_i == 6'b100101) ? 4'b0001:    // or 1
                (ALUOp_i == 3'b010 && funct_i == 6'b101010) ? 4'b0101:    // slt 5
                (ALUOp_i == 3'b100) ? 4'b0010:                            // addi  2
                (ALUOp_i == 3'b011) ? 4'b0100:                            // beq 4
                (ALUOp_i == 3'b111) ? 4'b0101:                            // slti 5 
                (ALUOp_i == 3'b001) ? 4'b0011:4'b0000;                    // mul 3

end
endmodule
