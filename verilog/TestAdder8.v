`timescale 1 ns/1 ps

module testbench2();


reg r_clk = 1'b0;

reg [7:0] r_A = 8'd0;
reg [7:0] r_B = 8'd0; //???
wire w_Cout;
wire [7:0] w_S;



adder8 Adder8_Test
	(
		.i_A(r_A),
		.i_B(r_B),
		.o_S(w_S),
		
		.o_Cout(w_Cout)
	
	);

always #(20) r_clk <= ~r_clk;

initial
		begin: main_test2
		
		r_A <= 8'b00000111;
		r_B <= 8'b11111011;
		
		@(posedge r_clk);
		@(posedge r_clk);
		@(posedge r_clk);
		
		$stop;
		
		end

endmodule




