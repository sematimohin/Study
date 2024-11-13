`timescale 1 ns/1 ps


module test_uartTX();

reg r_clk = 1'b0;
reg r_TXDV = 1'b0;
reg [7:0] r_TXBYTE = 8'd0;

wire w_TX_SERIAL;
wire w_o_TX_DONE;


UART_TX test_uartTX
	(
		.i_CLK(r_clk),
		.i_TX_DV(r_TXDV),
		.i_TX_BYTE(r_TXBYTE),
		
		.o_TX_SERIAL(w_TX_SERIAL),
		.o_TX_DONE(w_o_TX_DONE)
	
	);
	
	always #(50) r_clk <= ~r_clk;

	
initial
		begin: main_test
		@(posedge r_clk);	
			r_TXDV = 1'b1;
			r_TXBYTE = 8'd5;
			
			@(posedge r_clk);	
			
			while(w_o_TX_DONE == 1'b0)
			begin
			
				@(posedge r_clk);
				
			end		
					if ( w_o_TX_DONE ==1'b1)
						$stop;	
		end
			
		


endmodule
