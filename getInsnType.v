module getInsnType(opcode, is_r, is_ri, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx);
	input[4:0] opcode;
	output is_r, is_ri, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx;
	
	assign is_r    = (~opcode[4]) & (~opcode[3]) & (~opcode[2]) &(~opcode[1])  & (~opcode[0]);	//00000
	assign is_ri   = (~opcode[4]) & (~opcode[3]) & (opcode[2])  &(~opcode[1])  & (opcode[0]);		//00101
	assign is_sw   = (~opcode[4]) & (~opcode[3]) & (opcode[2])  &(opcode[1])   & (opcode[0]);		//00111
	assign is_lw   = (~opcode[4]) & (opcode[3])  & (~opcode[2]) &(~opcode[1])  & (~opcode[0]);		//01000
	assign is_j    = (~opcode[4]) & (~opcode[3]) & (~opcode[2]) &(~opcode[1])  & (opcode[0]);		//00001
	assign is_bne  = (~opcode[4]) & (~opcode[3]) & (~opcode[2]) &(opcode[1])   & (~opcode[0]);		//00010
	assign is_jal  = (~opcode[4]) & (~opcode[3]) & (~opcode[2]) &(opcode[1])   & (opcode[0]);		//00011
	assign is_jr   = (~opcode[4]) & (~opcode[3]) & (opcode[2])  &(~opcode[1])  & (~opcode[0]);		//00100
	assign is_blt  = (~opcode[4]) & (~opcode[3]) & (opcode[2])  &(opcode[1])   & (~opcode[0]);		//00110
	assign is_bex  = (opcode[4])  & (~opcode[3]) & (opcode[2])  &(opcode[1])   & (~opcode[0]);		//10110
	assign is_setx = (opcode[4])  & (~opcode[3]) & (opcode[2])  &(~opcode[1])  & (opcode[0]);		//10101
	
endmodule