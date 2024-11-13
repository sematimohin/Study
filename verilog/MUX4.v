module MUX4
	#(parameter n = 32)
	(
		input wire [n-1:0] i_D0,
		input wire [n-1:0] i_D1,
		input wire [n-1:0] i_D2,
		input wire [n-1:0] i_D3,
		input wire [1:0] i_s,
		output wire [n-1:0] o_Y
	);
	wire [n-1:0]Y1;
	wire [n-1:0]Y2;
	
	MUX2 mux1
	(
		.i_D0(i_D0),
		.i_D1(i_D1),
		.o_Y(Y1),
		.i_s(i_s[0])
	);
	defparam mux1.n = n;
	
	
	
	MUX2 mux2
	(
		.i_D0(i_D2),
		.i_D1(i_D3),
		.o_Y(Y2),
		.i_s(i_s[0])
	);
	defparam mux2.n = n;
	
	MUX2 mux3
	(
		.i_D0(Y1),
		.i_D1(Y2),
		.o_Y(o_Y),
		.i_s(i_s[1])
	);
	defparam mux3.n = n;
	
	
endmodule