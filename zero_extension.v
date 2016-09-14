`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:16:56 11/07/2015 
// Design Name: 
// Module Name:    zero_extension 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module zero_extension( in, out); 
	
	input wire [15:0] in; // Entrada de 16 bits
	output reg [31:0] out; // Salida de 32 bits
	
	always @ (*)
	begin
		out[15:0] <= in[15:0]; // Se copian los primeros 16 bits
		out[16] <= 1'b0; // Bit 16 en 0
		out[17] <= 1'b0; // Bit 17 en 0
		out[18] <= 1'b0; // Bit 18 en 0
		out[19] <= 1'b0; // Bit 19 en 0
		out[20] <= 1'b0; // Bit 20 en 0
		out[21] <= 1'b0; // Bit 21 en 0
		out[22] <= 1'b0; // Bit 22 en 0
		out[23] <= 1'b0; // Bit 23 en 0
		out[24] <= 1'b0; // Bit 24 en 0
		out[25] <= 1'b0; // Bit 25 en 0
		out[26] <= 1'b0; // Bit 26 en 0
		out[27] <= 1'b0; // Bit 27 en 0
		out[28] <= 1'b0; // Bit 28 en 0
		out[29] <= 1'b0; // Bit 29 en 0
		out[30] <= 1'b0; // Bit 30 en 0
		out[31] <= 1'b0; // Bit 31 en 0
	end
 endmodule  
