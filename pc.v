
/*
		to latch the value for pc
*/
module pc(clock, reset, pc_in, pc_out);
	input clock, reset;
	input [31:0] pc_in;
	output [31:0] pc_out;
		
	myDff dff0(clock, pc_in[0], pc_out[0], reset);
	myDff dff1(clock, pc_in[1], pc_out[1], reset);
	myDff dff2(clock, pc_in[2], pc_out[2], reset);
	myDff dff3(clock, pc_in[3], pc_out[3], reset);
	myDff dff4(clock, pc_in[4], pc_out[4], reset);
	myDff dff5(clock, pc_in[5], pc_out[5], reset);
	myDff dff6(clock, pc_in[6], pc_out[6], reset);
	myDff dff7(clock, pc_in[7], pc_out[7], reset);
	myDff dff8(clock, pc_in[8], pc_out[8], reset);
	myDff dff9(clock, pc_in[9], pc_out[9], reset);
	myDff dff10(clock, pc_in[10], pc_out[10], reset);
	myDff dff11(clock, pc_in[11], pc_out[11], reset);
	myDff dff12(clock, pc_in[12], pc_out[12], reset);
	myDff dff13(clock, pc_in[13], pc_out[13], reset);
	myDff dff14(clock, pc_in[14], pc_out[14], reset);
	myDff dff15(clock, pc_in[15], pc_out[15], reset);
	myDff dff16(clock, pc_in[16], pc_out[16], reset);
	myDff dff17(clock, pc_in[17], pc_out[17], reset);
	myDff dff18(clock, pc_in[18], pc_out[18], reset);
	myDff dff19(clock, pc_in[19], pc_out[19], reset);
	myDff dff20(clock, pc_in[20], pc_out[20], reset);
	myDff dff21(clock, pc_in[21], pc_out[21], reset);
	myDff dff22(clock, pc_in[22], pc_out[22], reset);
	myDff dff23(clock, pc_in[23], pc_out[23], reset);
	myDff dff24(clock, pc_in[24], pc_out[24], reset);
	myDff dff25(clock, pc_in[25], pc_out[25], reset);
	myDff dff26(clock, pc_in[26], pc_out[26], reset);
	myDff dff27(clock, pc_in[27], pc_out[27], reset);
	myDff dff28(clock, pc_in[28], pc_out[28], reset);
	myDff dff29(clock, pc_in[29], pc_out[29], reset);
	myDff dff30(clock, pc_in[30], pc_out[30], reset);
	myDff dff31(clock, pc_in[31], pc_out[31], reset);


endmodule

module myDff(clock, D, Q, reset);
	input clock, D;
	input reset;
	output reg Q;
	
	always @(posedge clock or posedge reset)
		begin
			if(reset)
				begin
					Q = 1'b0;
				end
			else
				begin
					Q = D;
				end
		end


endmodule