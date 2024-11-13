`timescale 1 ns/1 ps


module test_RegUart();

reg r_clk = 1'b0;
reg [31:0] r_in = 32'b0;
wire [31:0] w_Q;
wire w_out;
wire w_reset;


RegUart test_RegUart
	(
		.clk(r_clk),
		.in(r_in),
		.out(w_out),
		.Q(w_Q),
		.reset(w_reset)
	
	);
	
	always #(50) r_clk <= ~r_clk;

	
initial
		begin: main_test
		@(posedge r_clk);	
		
		r_in = 32'd261;

			@(posedge r_clk);	
			
			while(w_Q[9] == 1'b0)
			begin
			
				@(posedge r_clk);
				
			end		
				
						$stop;	
		end
			
		


endmodule