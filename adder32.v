

module adder32(in0, in1, out);
	input [31:0] in0, in1;
	wire cin;
	output [31:0] out;
	wire cout;
	
	wire tempLowCout;
	wire [15:0] out_0, out_1;
	wire cout_0, cout_1;
	
	
	//perform low 16-bit 
	_16BitAdder lo(in0[15:0], in1[15:0], out[15:0], cin, tempLowCout);
	
	
	//perform high 16-bit
	_16BitAdder hi_0(in0[31:16], in1[31:16], out_0, 1'b0, cout_0);
	_16BitAdder hi_1(in0[31:16], in1[31:16], out_1, 1'b1, cout_1);
	
	assign out[31:16] = (tempLowCout == 1'b0) ? out_0 : out_1;
	assign cout       = (tempLowCout == 1'b0) ? cout_0 : cout_1;
	


endmodule

module _16BitAdder(in0, in1, out, cin, cout);
	input [15:0] in0, in1;
	input cin;
	
	output [15:0] out;
	output cout;
	
	wire tempLowCout;
	wire [7:0] out_0, out_1;
	wire cout_0, cout_1;
	
	
	//perform low 8-bit 
	eightBitAdder lo(in0[7:0], in1[7:0], out[7:0], cin, tempLowCout);
	
	
	//perform high 8-bit
	eightBitAdder hi_0(in0[15:8], in1[15:8], out_0, 1'b0, cout_0);
	eightBitAdder hi_1(in0[15:8], in1[15:8], out_1, 1'b1, cout_1);
	
	assign out[15:8] = (tempLowCout == 1'b0) ? out_0 : out_1;
	assign cout      = (tempLowCout == 1'b0) ? cout_0 : cout_1;
	
endmodule

module eightBitAdder(in0, in1, out, cin, cout);
	input [7:0] in0, in1;
	input cin;
	
	output [7:0] out;
	output cout;
	
	wire tempLowCout;
	wire [3:0] out_0, out_1;
	wire cout_0, cout_1;
	
	
	//perform low 4-bit 
	fourBitAdder lo(in0[3:0], in1[3:0], out[3:0], cin, tempLowCout);
	
	
	//perform high 4-bit
	fourBitAdder hi_0(in0[7:4], in1[7:4], out_0, 1'b0, cout_0);
	fourBitAdder hi_1(in0[7:4], in1[7:4], out_1, 1'b1, cout_1);
	
	assign out[7:4] = (tempLowCout == 1'b0) ? out_0 : out_1;
	assign cout     = (tempLowCout == 1'b0) ? cout_0 : cout_1;	

endmodule

module fourBitAdder(in0, in1, out, cin, cout);
	input [3:0] in0, in1;
	input cin;
	
	output [3:0] out;
	output cout;
	
	wire tempLowCout;
	wire [1:0] out_0, out_1;
	wire cout_0, cout_1;
	
	
	//perform low 2-bit 
	twoBitAdder lo(in0[1:0], in1[1:0], out[1:0], cin, tempLowCout);
	
	
	//perform high 2-bit
	twoBitAdder hi_0(in0[3:2], in1[3:2], out_0, 1'b0, cout_0);
	twoBitAdder hi_1(in0[3:2], in1[3:2], out_1, 1'b1, cout_1);
	
	assign out[3:2] = (tempLowCout == 1'b0) ? out_0 : out_1;
	assign cout     = (tempLowCout == 1'b0) ? cout_0 : cout_1;
	
endmodule

//assert that twoBit is all right ? yes or no


//to constrcut the 2-bit adder
module twoBitAdder(in0, in1, out, cin, cout);
	input [1:0] in0, in1;
	input cin;
	
	output [1:0] out;
	output cout;
	
	wire tempLowCout;
	wire out_0, out_1;
	wire cout_0, cout_1;
	
	//low bit
	oneBitAdder loBit(in0[0], in1[0], out[0], cin, tempLowCout);
	
	//high bit
	oneBitAdder hiBit_0(in0[1], in1[1], out_0, 1'b0, cout_0);
	oneBitAdder hiBit_1(in0[1], in1[1], out_1, 1'b1, cout_1);
	
	assign out[1] = tempLowCout == 1'b0 ? out_0  : out_1;
	assign cout   = tempLowCout == 1'b0 ? cout_0 : cout_1;
	
endmodule


module oneBitAdder(in0, in1, out, cin, cout);
	input in0, in1, cin;	
	output out, cout;
	wire w1, w2, w3;
	
	xor xor_1(w1, in0, in1);
	xor xor_2(out, w1, cin);
	
	nand nand_1(w2, in0, in1);
	nand nand_2(w3, cin, w1);
	nand nand_3(cout, w2, w3);
	
endmodule


