module FAPCH
	(
		input wire clk,
		output wire c,
		output wire locked
	
	
	);
	
new_pll	new_pll_inst (
	.inclk0 ( clk ),
	.c0 ( c ),
	.locked ( locked )
	);

	
endmodule
	