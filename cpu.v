`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:14:55 11/06/2015 
// Design Name: 
// Module Name:    cpu 
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
module cpu (clk, reset,datamemory_outdata,alu_result,Read_Data2,Mem_Write); 
	input wire clk;
	input wire reset;
	input wire [31:0] datamemory_outdata;
	
	output wire [31:0] alu_result;
   output wire [31:0] Read_Data2;
	output wire [3:0] Mem_Write;
 

    //-------------------------------------------------
    // Signal Declarations: wire
    //-------------------------------------------------
	wire [31:0] pc;
	wire [31:0] instruction;
	wire [31:0] inmediate_signextended;
	wire [31:0] immediate_zeroextended;
	wire [31:0] immediate_concatenate; //para el lui
	//wire [31:0] datamemory_outdata; //lo puse aqui para probarlo
	wire [31:0] jal_8_signextended; //Extend 8 for the jal instruction
	
	
	wire	REG_WR;
	wire [1:0] SEL_DATO;
	wire 			SEL_OPERA_A; // mux de la entrada A de la ALU
	wire [1:0]	SEL_DEST;
	wire [1:0]	SEL_OPERA_B;
	wire [3:0]	alu_control;
	wire [3:0]	SEL_PC; //Selects the PC

	wire [4:0] 	Write_Register;

	wire [31:0]	Read_Data1;

	wire [31:0]	Write_Data;

	//Entradas de la alu
	wire [31:0] alu_operand_b;
	wire [31:0] alu_operand_a;
	wire [4:0] 	shamt;
	wire alu_flag_overflow;
	wire alu_zero;


	wire [4:0] rs;
	wire [4:0] rt;
	wire [4:0] rd;
	wire [25:0] dir_jmp; // AGREGUE ESTA
	wire [15:0] inmediate; // AGREGUE ESTA
	wire [4:0] register_31; //jal = R[31] = PC + 8
	
	wire [7:0] crc_out; //Documente esto porque creo que no hace ninguna diferencia

	

	//---------------------------------------------------------------
	// Instantiations
	//---------------------------------------------------------------
	
	// Da como salida el siguiente new_pc a utilizar, este depende del SEL_PC (si es new_pc+4, j)
	program_counter mux_sel_pc (clk, reset, SEL_PC, dir_jmp, inmediate, Read_Data1, pc);
	
	// Retorna la instruccion a utilizar
	instruction_memory inst_mem (pc,instruction);

	// Unidad de control de señales de los mux
	control_unit cntrlUnit (instruction,alu_zero,Mem_Write,REG_WR,SEL_DATO,SEL_DEST,SEL_OPERA_B,SEL_OPERA_A,alu_control,shamt,SEL_PC);

	//Se realiza extension de signo del inmediato
	sign_extension inme_SignExtend (inmediate,inmediate_signextended);
																						
	//Modulo que se encarga de realizar la extension de zeros al inmediato
	zero_extension immediateZeroExtend (inmediate,immediate_zeroextended);
									
	//Modulo que se encarga de realizar la extension de signo al numero 8
	sign_extension eightSignExtend ((16'h0008),jal_8_signextended);
									
									
	//Este es el mux que se encarga de escoger la direccion de escritura en el banco de registros
	mux_3_entries RegFile_SelectMux (rt, rd, register_31,SEL_DEST,Write_Register);
	
	// Modulo de banco de registros, señal de control de escritura (reg_wr)
	register_file regFile (clk,rs,rt,Write_Register,Write_Data,REG_WR,Read_Data1,Read_Data2);	
	
	//Este mux selecciona la Entrada B de la AlU. Selecciona entre rt o el inmediaton extendido.
	mux_2_entries aluOperandA_SelectMux (Read_Data1,pc,SEL_OPERA_A,alu_operand_a);
	
	//Este mux selecciona la Entrada B de la AlU. Selecciona entre rt,el inmediaton extendido o 8.
	mux_4_entries aluOperandB_SelectMux (Read_Data2,inmediate_signextended,immediate_zeroextended, jal_8_signextended,SEL_OPERA_B,alu_operand_b);
	
	//Este modulo contiene a la ALU
	alu alu(alu_operand_a,alu_operand_b,alu_control,shamt,alu_result,alu_zero,alu_flag_overflow);
		
	//Este mux selecciona cual valor se debe almacenar en el banco de registros.
	mux_3_entries_selectdatain dataMemoryRDataSelectMux(datamemory_outdata,immediate_concatenate,alu_result,SEL_DATO,Write_Data);
	
	// MEMORIA
	//data_memory data_memory1 (clk,reset,alu_result,addr_vga,Read_Data2,Mem_Write,1'b0,crc_out,datamemory_outdata,datamemory_outdata_vga);	
	 
	//---------------------------------------------------------------
	// Combinatorial Logic
	//---------------------------------------------------------------
	assign rs = instruction[25:21];
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];
	assign register_31 = 5'b11111;
	assign dir_jmp = instruction[25:0];
	assign inmediate = instruction[15:0];
	assign immediate_concatenate = {instruction[15:0],16'h0000};
	
	always @(posedge clk)
	begin
		$display("\n\n\nINSTRUCTION=%h - radd0=%d - radd1=%d - rdata0=0x%h - rdata1=0x%h   alu_zero %d",
			instruction,
			instruction[25:21], 
			instruction[20:16], 
			Read_Data1, 
			Read_Data2, 
			alu_zero);
	//	$display("Primera entrada de la ALU: %h", Read_Data1);
	//	$display("Segunda entrada de la ALU: %h", Read_Data2);
		$display("Primera entrada de la ALU: %h", alu_operand_a);
		$display("Segunda entrada de la ALU: %h", alu_operand_b);
		$display("Resultado de la ALU: %h", alu_result);
	end

endmodule
