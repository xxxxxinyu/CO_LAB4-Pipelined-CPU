//109550085
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 23:17:42
// Design Name: 
// Module Name: ALU
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


module ALU(
    src1_i,
    src2_i,
    ctrl_i,
    result_o,
    zero_o
    );
    
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
assign zero_o = (result_o == 0) ? 1'b1:1'b0;
//Main function
always @(ctrl_i, src1_i, src2_i)
    begin
        case (ctrl_i)
            0: result_o <= src1_i & src2_i;                     // AND
            1: result_o <= src1_i | src2_i;                     // OR
            2: result_o <= src1_i + src2_i;                     // Add 
            3: result_o <= src1_i * src2_i;                     // mul
            4: result_o <= (src1_i == src2_i) ? 1'b0:1'b1;      // beq
            5: result_o <= (src1_i < src2_i) ? 1'b1:1'b0;       // slti  slt
            6: result_o <= src1_i - src2_i;                     // sub
            default: result_o <= 0;
        endcase    
    end
endmodule
