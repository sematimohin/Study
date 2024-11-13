module RegUart
	(
		input wire [31:0] in,
		output wire out,
		output wire [31:0] Q,
		//output wire done,
		input wire clk,
		input wire reset,
		input wire WE2
	
	);
	
	
	wire done;


	Reg_forUART Red_Before_UartTX
	(
		.clk(clk),
		.d({in[31:10],done,in[8:0]}),
		.reset(reset),
		.q(Q[31:0]),
		.WE(WE2)
	
	);
	
	UART_TX  uart
	(
		.i_CLK(clk),
		.i_TX_DV(Q[8]),
		.i_TX_BYTE(Q[7:0]),
		.o_TX_SERIAL(out),
		.o_TX_DONE(done)
	
	);
	
	
	
	
endmodule 

