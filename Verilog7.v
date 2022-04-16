module _2decoder(in,out);
	input[1:0] in;
	output[3:0] out;
	
	wire not_in0, not_in1;
	
	not not_1(not_in0, in[0]);
	not not_2(not_in1, in[1]);
	
	and and_1(out[0],not_in0,not_in1);
	and and_2(out[1],in[1],not_in0);
	and and_3(out[2],not_in1,in[0]);
	and and_4(out[3],in[0],in[1]);
	
endmodule

module _3decoder(in,E,out);
	input[2:0] in;
	input E;
	output[7:0] out;
	
	wire not_in0, not_in1, not_in2;
	wire t0,t1,t2,t3,t4,t5,t6,t7;
	wire o0,o1,o2,o3,o4,o5,o6,o7;
	
	not not_0(not_in0,in[0]);
	not not_1(not_in1,in[1]);
	not not_2(not_in2,in[2]);
	
	// build 3-input and gates
	and and_t0(t0,not_in0,not_in1);
	and and_t1(t1,not_in0,not_in2);
	and and_t2(t2,not_in1,not_in2);
	and and_t3(t3,not_in0,in[1]);
	and and_t5(t5,not_in1,in[0]);
	and and_t6(t6,in[0],in[1]);
	
	and and_o0(o0,t0,not_in2);
	and and_o1(o1,t0,in[2]);
	and and_o2(o2,t1,in[1]);
	and and_o3(o3,t3,in[2]);
	and and_o4(o4,t2,in[0]);
	and and_o5(o5,t5,in[2]);
	and and_o6(o6,t6,not_in2);
	and and_o7(o7,t6,in[2]);
	
	// output when E=1
	and and_0(out[0],E,o0);
	and and_1(out[1],E,o1);
	and and_2(out[2],E,o2);
	and and_3(out[3],E,o3);
	and and_4(out[4],E,o4);
	and and_5(out[5],E,o5);
	and and_6(out[6],E,o6);
	and and_7(out[7],E,o7);
	
endmodule


module _5decoder(ctrl_opcode,out);
	input[4:0] ctrl_opcode;
	output[31:0] out;
	
	wire[3:0] temp;
	
	_2decoder _2decoder_imp(ctrl_opcode[1:0],temp);
	_3decoder _3decoder_1(ctrl_opcode[4:2],temp[0],out[7:0]);
	_3decoder _3decoder_2(ctrl_opcode[4:2],temp[1],out[15:8]);
	_3decoder _3decoder_3(ctrl_opcode[4:2],temp[2],out[23:16]);
	_3decoder _3decoder_4(ctrl_opcode[4:2],temp[3],out[31:24]);
	
endmodule
