`timescale 1 ns / 100 ps
module testProcessor_tb();

	reg clock;
	wire imem_clock, dmem_clock, processor_clock, regfile_clock;
	
	integer i;
	skeleton mysk(clock, 1'b0, imem_clock, dmem_clock, processor_clock, regfile_clock);
	
	initial begin
		$display($time, " Simulation starts");
		
		clock = 1'b0;
		
		@(posedge processor_clock) begin
			$display("pc = %d", mysk.address_imem);
			$display("instruction is = %h", mysk.q_imem);
			
			for(i = 0; i < 32; i = i + 1)	begin
				$display("reg[%d] = %d", i,mysk.my_regfile.registers[i]);
			end
			
			$display("readRegA = %d, read Value = %d", mysk.ctrl_readRegA, mysk.data_readRegA);
			$display("readRegB = %d, read Value = %d", mysk.ctrl_readRegA, mysk.data_readRegB);
			$display("writeReg = %d, write value = %d", mysk.ctrl_writeReg, mysk.data_writeReg);
			
			
		end
	
	end


	always
		#10 clock = ~clock;
endmodule
