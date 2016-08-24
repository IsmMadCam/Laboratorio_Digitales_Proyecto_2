`timescale 1ns / 10ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:16:55 08/23/2016
// Design Name:   toplevel
// Module Name:   C:/Users/Kevin/Laboratorio/testcon.v
// Project Name:  Laboratorio
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: toplevel
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testcon;

	// Inputs
	reg clk;
	reg reset;
	reg switchR;
	reg switchG;
	reg switchB;

	// Outputs
	wire hsync;
	wire vsync;
	wire [2:0] rgb;

	// Instantiate the Unit Under Test (UUT)
	toplevel uut (
		.clk(clk), 
		.reset(reset), 
		.switchR(switchR), 
		.switchG(switchG), 
		.switchB(switchB), 
		.hsync(hsync), 
		.vsync(vsync), 
		.rgb(rgb)
	);
	
//	always begin #5 clk=~clk;end
/*	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		switchR = 1;
		switchG = 0;
		switchB = 0;

		#100;
		reset = 1;  
		
		#200; 
		reset = 0;
		
		#600000;
		switchR = 0;
		switchG = 1;
		
		#1000000;
		$finish;

	end
*/
	
	always begin #0.5 clk=~clk;end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		switchR = 1;
		switchG = 0;
		switchB = 0;

		#1 reset=1;  
		
		#1 reset=0;
		
		#600000 switchR=0;
		#1 switchG=1;
	end
      
endmodule

