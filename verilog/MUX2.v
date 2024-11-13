`timescale 1 ns/1 ps

module MUX2
	#(parameter n = 32)
	(
		input wire [n-1:0] i_D0,
		input wire [n-1:0] i_D1,
		input wire i_s,
		output wire [n-1:0] o_Y
	);	

	assign o_Y = (i_s == 1'b1) ? i_D1 : i_D0 ;

endmodule

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
