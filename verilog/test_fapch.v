`timescale 1 ns/1 ps

module test_fapch();

reg r_clk = 1'b0;

wire w_c;
wire w_locked;

FAPCH test_fapch
	(
		.clk(r_clk),
		.c(w_c),
		.locked(w_locked)
	);
	
	always #(25) r_clk <= ~r_clk;
	
	
	initial
		begin: main_test
		@(posedge r_clk);	
		
			while (w_locked == 1'b0)
				@(posedge r_clk);	
			repeat (30) @(posedge r_clk);
			$stop;
		end
		
		endmodule 
			