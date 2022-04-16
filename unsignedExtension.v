module unsignedExtension(in, out);
	input [26:0] in;
	output [31:0] out;

	
	assign out[26:0] = in[26:0];
	assign out[31:27] = 5'b0;
endmodule