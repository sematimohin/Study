module Counter

	(
		input wire clk,
		output wire [31:0] Q
		
	);
	wire [31:0] Y1;
	
	adder8 add1
		(
			.i_A(32'd1),
			.i_B(Q),
			.o_S(Y1)
			
		);
	Reg reg1
		(
			.d(Y1),
			.clk(clk),
			.q(Q)
				
		);
		
endmodule
