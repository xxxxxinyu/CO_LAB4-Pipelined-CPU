//109550085
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/02 23:17:42
// Design Name: 
// Module Name: Shift_Left_Two_32
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


module Shift_Left_Two_32(
    data_i,
    data_o
    );
    
//I/O ports                    
input [32-1:0] data_i;
output [32-1:0] data_o;

//shift left 2
assign data_o[32-1:2] = data_i[32-3:0];
assign data_o[1:0] = 2'b00; 
    
endmodule
