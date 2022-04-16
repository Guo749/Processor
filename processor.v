


/*
	todo: change the youixanji about trinay
*/


module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB,                  // I: Data from port B of regfile
	 Imme,
	 alu_out, alu_A, alu_B
	 //is_r, is_ri, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx
);
	// Control signals
	input clock, reset;

	// Imem
	output [11:0] address_imem;
	input [31:0] q_imem;

	// Dmem
	output [11:0] address_dmem;
	output [31:0] data;
	output wren;
	input [31:0] q_dmem;		

	// Regfile
	output ctrl_writeEnable;
	output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
	output [31:0] data_writeReg;
	input [31:0] data_readRegA, data_readRegB;

	/* YOUR CODE STARTS HERE */

	////////////////////Instruction Code////////////////////////////////
	wire[31:0] Insn;
	wire [4:0] Opcode;
	wire [4:0] ALUop;
	
	/////////////////////control signal/////////////////////////////////
	//signal to specify which instruction is picked, using one hot decode
	wire is_r, is_ri, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx;	 
	wire is_notEqual, isOverFlow, is_lessThan;
	wire doubleCheckOF;
	
	
	///////////////////Immediate////////////////////////////////////////
	output [31:0] Imme;
	wire [31:0] target;
	signExtension     mySE(Insn[16:0], Imme);
	unsignedExtension myUE(Insn[26:0], target);
	
	
	//////////////////PC////////////////////////////////////////////////
	wire [31:0] pc_in, pc_out;
	wire [31:0] pc_plus1,pc_plusN1; 
	
	
	/////////////////Reg File Argument/////////////////////////////////
	wire [4:0] Rd, Rs, Rt;
	wire [4:0] shamt;
	wire [4:0] RegS1, RegS2;
	
	/////////////////ALU//////////////////////////////////////////////
	output [31:0] alu_out;
	output [31:0] alu_A, alu_B;
	wire [31:0] over_data;
	
	//1.to deal with pc
	//module adder32(in0, in1, out);
	pc       myPc(clock, reset, pc_in, pc_out);
	adder32 myAdder1(pc_out, 32'b1, pc_plus1);
	adder32 myAdder2(pc_plus1, Imme, pc_plusN1);
	
	assign pc_in = (is_j | is_jal | (is_bex & is_notEqual)) ? target :
		(((is_bne & is_notEqual) | (is_blt & is_lessThan)) ? pc_plusN1 : (is_jr ? data_readRegA : pc_plus1));
	
	
	//2. Imem
	assign address_imem = pc_out[11:0];
	assign Insn = q_imem;

	
	//3.Instruction and register file
	//using 1h technique
	getInsnType myGet(Opcode, is_r, is_ri, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx);

	assign Opcode = Insn[31:27];
	assign Rd     = Insn[26:22];
	assign Rs     = Insn[21:17];
	assign Rt     = Insn[16:12];
	assign shamt  = (is_r & (ALUop == 4 | ALUop == 5)) ? Insn[11:7] : 5'b0000;
	assign ALUop  = is_ri ? 5'b00000 : Insn[6:2];	

	assign alu_A = (is_r | is_ri | is_lw | is_sw | is_bex | is_bne | is_blt) ? data_readRegA : 32'b0;
	assign alu_B = (is_r | is_bne | is_blt) ? data_readRegB : ((is_ri | is_sw | is_lw) ? Imme : is_jal ? pc_plus1 : 32'b0);
	alu myAlu(alu_A, alu_B, ALUop, shamt, alu_out, is_notEqual, is_lessThan, isOverFlow);
	
	assign ctrl_writeEnable = (is_r | is_ri | is_lw | is_jal | is_setx) ? 1'b1 : 1'b0;
	assign ctrl_writeReg    = (isOverFlow) ? 5'b11110 : (is_r | is_ri | is_lw) ? Rd : (is_jal ? 5'b11111 : (is_setx ? 5'b11110 : 5'b00000));
	assign ctrl_readRegA    = (is_r | is_ri | is_lw | is_sw) ? Rs : (is_bne | is_blt | is_jr) ? Rd : (is_bex) ? 5'b11110 : 5'b00000;		
	assign ctrl_readRegB    = (is_r) ? Rt : is_bne | is_blt ? Rs : is_bex ? 5'b11110 : is_sw ? Rd: 5'b00000;
	assign over_data        = is_ri ? 32'b10 : Insn[6:2] == 5'b00000 ? 32'b1 : Insn[6:2] == 5'b00001 ? 32'b011 : 32'b0;
	assign doubleCheckOF    =  isOverFlow & (ALUop == 0 | ALUop == 1) ? 1'b1 : 1'b0;
	assign data_writeReg    = ((is_r | is_ri) & doubleCheckOF) ? over_data : ((is_r | is_ri)) ?  alu_out : (is_lw ? q_dmem : (is_jal ? pc_plus1 : (is_setx ? target : 32'b0)));
	//todo:overflow
	
	//4.Data Mem
	/*
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem
	*/
	assign address_dmem = (is_sw | is_lw) ? alu_out[11:0] : 12'b0;
	assign data         = data_readRegB;
	assign wren         = is_sw;
	
endmodule
