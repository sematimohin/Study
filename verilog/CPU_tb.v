`timescale 1 ns / 1 ps

module CPU_tb();
	parameter c_CLOCK_PERIOD_NS 	= 10;
	reg r_clk = 0;
	reg r_reset = 0;
	wire [31:0] w_write_data;
	wire [31:0] w_data_address;
	wire w_mem_write;
	
	DataPath CPU
	(
		.clk(r_clk),
		.reset(r_reset),
		.DM_inWD(w_write_data),
		.DM_inA(w_data_address),
		.MemWrite_in(w_mem_write)
	);
	
	always #(c_CLOCK_PERIOD_NS/2) r_clk <= ~r_clk;
	
	initial
	begin
		r_reset <= 1'b1;
		#22;
		r_reset <= 1'b0;
	end
	
	always @(posedge r_clk)
	begin
		if(w_mem_write == 1'b1)
		begin
			if((w_data_address == 84) && (w_write_data == 7))
			begin
				$display("Simulation succeeded");
				$stop;
			end
			else if(w_data_address != 80)
			begin
				$display("Simulation failed");
				$stop;
			end
		end
	end
	
endmodule
