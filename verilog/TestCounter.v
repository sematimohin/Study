`timescale 1 ns/1 ps

module testbench5();

reg r_clk = 1'b0;

//reg r_A = 8'd1;
wire [7:0]w_Q;

Counter TestCounter
	(
		.clk(r_clk),
		.Q(w_Q)
		
	);
	
always #(20) r_clk <= ~r_clk;

initial
		begin: main_TestCount
		
		
		repeat(257) @(posedge r_clk);
		$stop;
end
endmodule