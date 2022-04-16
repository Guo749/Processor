/**
 * NOTE: you should not need to change this file! This file will be swapped out for a grading
 * "skeleton" for testing. We will also remove your imem and dmem file.
 *
 * NOTE: skeleton should be your top-level module!
 *
 * This skeleton file serves as a wrapper around the processor to provide certain control signals
 * and interfaces to memory elements. This structure allows for easier testing, as it is easier to
 * inspect which signals the processor tries to assert when.
 */

module skeleton(clock, reset, imem_clock, dmem_clock, processor_clock, regfile_clock,
		//address_imem, q_imem,
		ctrl_readRegA, ctrl_readRegB, data_writeReg, ctrl_writeReg,ctrl_writeEnable,
		Imme,
		alu_out, alu_A, alu_B,
		q_dmem,
		wren,address_dmem,
		q_imem,address_imem
		//is_r, is_ri, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx
		
	);
	
	//op by guo
	output [31:0] Imme;
	output [31:0] alu_out,alu_A, alu_B;
	//output is_r, is_ri, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx;
	
    input clock, reset;
	 output imem_clock, dmem_clock, processor_clock, regfile_clock;
	 
	 /** CLKS_INI **/
	 wire clk_2, clk_4;
	 frequency_divider_by2 fd2_1(clock, reset, clk_2);
	 frequency_divider_by2 fd2_2(clk_2, reset, clk_4);
	 
	 assign imem_clock      = clk_2;
	 assign dmem_clock      = ~clock;
	 assign processor_clock = ~clk_2;
	 assign regfile_clock   = ~clk_2;
	 

    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    output [11:0] address_imem;
    output [31:0] q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (imem_clock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!

    output [11:0] address_dmem;
    
	 wire [31:0] data;
    output wren;
    output [31:0] q_dmem;
    dmem my_dmem(
        .address    	(address_dmem),       // address of data
        .clock      	(dmem_clock),            // may need to invert the clock
        .data	    	(data),    				// data you want to write
        .wren	    	(wren),      // write enable
        .q          	(q_dmem)    // data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_readRegA, ctrl_readRegB;
	 output[4:0] ctrl_writeReg;
    output [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        regfile_clock,
        ctrl_writeEnable,
        reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB
    );

    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        processor_clock,                // I: The master clock
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
        data_readRegB,                   // I: Data from port B of regfile
		  Imme,
		  alu_out,
		  alu_A,
		  alu_B
		  //,is_r, is_ri, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx
    );

endmodule
