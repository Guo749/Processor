module my_pc(clk, rst, pc_in, pc_out);
	input clk, rst;
	input [31:0] pc_in;
	output reg[31:0] pc_out;
 
	initial begin
		pc_out <= 32'd0;
	end
 
	always @(posedge clk) begin
	if(rst)
		pc_out <= 32'd0;
	else
		pc_out <= pc_in;
	end

endmodule

//module my_pc(clk,rst,d,q);
//	input clk,rst;
//	input[31:0] d;
//	output[31:0] q;
//	
//	my_dff dff_0(clk, rst, d[0], q[0]);
//   my_dff dff_1(clk, rst, d[1], q[1]);
//   my_dff dff_2(clk, rst, d[2], q[2]);
//   my_dff dff_3(clk, rst, d[3], q[3]);
//   my_dff dff_4(clk, rst, d[4], q[4]);
//   my_dff dff_5(clk, rst, d[5], q[5]);
//   my_dff dff_6(clk, rst, d[6], q[6]);
//   my_dff dff_7(clk, rst, d[7], q[7]);
//   my_dff dff_8(clk, rst, d[8], q[8]);
//   my_dff dff_9(clk, rst, d[9], q[9]);
//   my_dff dff_10(clk, rst, d[10], q[10]);
//   my_dff dff_11(clk, rst, d[11], q[11]);
//   my_dff dff_12(clk, rst, d[12], q[12]);
//   my_dff dff_13(clk, rst, d[13], q[13]);
//   my_dff dff_14(clk, rst, d[14], q[14]);
//   my_dff dff_15(clk, rst, d[15], q[15]);
//   my_dff dff_16(clk, rst, d[16], q[16]);
//   my_dff dff_17(clk, rst, d[17], q[17]);
//   my_dff dff_18(clk, rst, d[18], q[18]);
//   my_dff dff_19(clk, rst, d[19], q[19]);
//   my_dff dff_20(clk, rst, d[20], q[20]); 
//   my_dff dff_21(clk, rst, d[21], q[21]);
//   my_dff dff_22(clk, rst, d[22], q[22]);
//   my_dff dff_23(clk, rst, d[23], q[23]);
//   my_dff dff_24(clk, rst, d[24], q[24]);
//   my_dff dff_25(clk, rst, d[25], q[25]);
//   my_dff dff_26(clk, rst, d[26], q[26]);
//   my_dff dff_27(clk, rst, d[27], q[27]);
//   my_dff dff_28(clk, rst, d[28], q[28]);
//   my_dff dff_29(clk, rst, d[29], q[29]);
//   my_dff dff_30(clk, rst, d[30], q[30]);
//   my_dff dff_31(clk, rst, d[31], q[31]);
//	
//endmodule
