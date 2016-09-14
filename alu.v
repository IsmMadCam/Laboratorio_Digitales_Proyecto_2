`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:05:19 11/06/2015 
// Design Name: 
// Module Name:    alu 
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
module alu 
(
    //--------------------------
    // Input Ports
    //--------------------------
   input	[31:0]	operand_a, 
	input	[31:0]	operand_b, 
	input	[3:0]	control,
	input [4:0] shamt,
	
    //--------------------------
    // Output Ports
    //--------------------------
    output	   [31:0]	result,
	 output     zero,
	 output		overflow
);
  

  
	assign result 	= alu_function(control, operand_a, operand_b);
	assign zero 	= (result == 0) ? 1'b1 : 1'b0;
	assign overflow = (operand_a[31] == operand_b[31]) && (result[31] != operand_a[31]);

	function [31:0] alu_function;
		input [3:0] control;
      input [31:0] operand_a;
      input [31:0] operand_b;
		begin
			case (control)
				//AND
				4'b0000: alu_function = operand_a & operand_b;
				//OR
				4'b0001: alu_function = operand_a | operand_b;
				//XOR
				4'b0010: alu_function = operand_a ^ operand_b;
				//NOR
				4'b0011: alu_function = ~(operand_a | operand_b);
				//ADD
				4'b0100: alu_function = operand_a + operand_b;
				//SIGNED ADD
				4'b0101: alu_function = $signed(operand_a) + $signed(operand_b);
				//SUB
				4'b0110: alu_function = operand_a - operand_b;
				//SIGNED SUB
				4'b0111: alu_function = $signed(operand_a) - $signed(operand_b);
				//SET ON LESS THAN
				4'b1000: alu_function = operand_a < operand_b;
				//SHIFT LEFT
				4'b1001: alu_function = operand_b << shamt;
				//SHIFT RIGHT
				4'b1010: alu_function = operand_b >> shamt;
				//SHIFT RIGHT ARITHMETIC
				4'b1011: alu_function = $signed(operand_a) >>> operand_b;
				default:
					alu_function = 0;
			endcase

		end
	endfunction
endmodule



