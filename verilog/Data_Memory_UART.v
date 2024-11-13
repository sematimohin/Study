module Data_Memory_UART
	(
		input wire [31:0] A,
		input wire [31:0] WD,
		output wire [31:0] RD,
		
		input wire reset,
		input wire clk,
		input wire WE1,
		
		output wire serial

	);
	
	wire [31:0] W1,W2;
	
	
	Data_Memory Data_Memory 
	(
		.clk(clk),
		.WE(WE1),
		.inA({{24{1'b0}},A[7:0]}),
		.inWD(WD),
		.outRD(W2)
			
	);
	
	
	RegUart RegUart
	(
		.in(WD),
		.out(serial), 
		.Q(W1), 
		.clk(clk),
		.reset(reset),
		.WE2(A[8])
		
		
	);
	
	
	MUX2 MUX
	(
		.i_D0(W2),
		.i_D1(W1),
		.i_s(A[8]),
		.o_Y(RD)
	
	);
	
	
	
	
	
	
	
	
	
	
	
	
	endmodule 