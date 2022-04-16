module my_dff(clk,rst,d,q);
	input clk,rst,d;
	output reg q;
	
	initial
   begin
        q = 1'b0;
   end
	
	always @(posedge clk or posedge rst) 
	begin
		if(rst == 1'b1)
			q <= 1'b0; 
		else 
			q <= d; 
	end 
endmodule 
