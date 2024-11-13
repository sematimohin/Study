`timescale 1 ns/1 ps

module testbench1 ();

	reg r_A = 1'b0;
	reg r_B = 1'b0;
	reg r_Cin = 1'b0;
	reg r_clk = 1'b0;
	wire w_Cout = 1'b0;
	wire w_S;

	
	adder Adder_Test
		(
			.i_A(r_A),
			.i_B(r_B),
			.C_in(r_Cin),
			.C_out(w_Cout),
			.o_S(w_S)
			
		);
		
	//defparam Adder_Test.n = 4;
	always #(20) r_clk <= ~r_clk;
	
	initial
		begin: main_test1
		integer err;
		err = 0;
		
		r_A <= 1'b0;
		r_B <= 1'b0;
		r_Cin <= 1'b0;
		@(posedge r_clk);
		
			if (w_Cout !=1'b0 || w_S !=1'b0)
				begin
					err = err + 1;
					$display("Err, step 0");	
				end
					else
						begin
							err = err;
							
						end
		
		@(posedge r_clk);
		r_A <= 1'b0;
		r_B <= 1'b1;
		r_Cin <=1'b0;
		
		@(posedge r_clk);
			if (w_Cout !=1'b0 || w_S !=1'b1)
				begin
					err = err + 1;
					$display("Err, step 1");	
				end
					else
						begin
							err = err;
							
						end
						
		@(posedge r_clk);
		r_A <= 1'b1;
		r_B <= 1'b0;
		r_Cin <=1'b0;
		@(posedge r_clk);
		
			if (w_Cout !=1'b0 || w_S !=1'b1)
				begin
					err = err + 1;
					$display("Err, step 2");	
				end
					else
						begin
							err = err;
							
						end
		
		@(posedge r_clk);
		r_A <= 1'b1;
		r_B <= 1'b1;
		r_Cin <=1'b0;
		@(posedge r_clk);
		
			if (w_Cout !=1'b1 || w_S !=1'b0)
				begin
					err = err + 1;
					$display("Err, step 3");	
				end
					else
						begin
							err = err;
							
						end
		
		
		@(posedge r_clk);
		r_A <= 1'b0;
		r_B <= 1'b0;
		r_Cin <=1'b1;
		@(posedge r_clk);
		
			if (w_Cout !=1'b0 || w_S !=1'b1)
				begin
					err = err + 1;
					$display("Err, step 4");	
				end
					else
						begin
							err = err;
							
						end
		
		@(posedge r_clk);
		r_A <= 1'b0;
		r_B <= 1'b1;
		r_Cin <=1'b1;
		@(posedge r_clk);
		
			if (w_Cout !=1'b1 || w_S !=1'b0)
				begin
					err = err + 1;
					$display("Err, step 5");	
				end
					else
						begin
							err = err;
							
						end
		
		
		@(posedge r_clk);
		r_A <= 1'b1;
		r_B <= 1'b0;
		r_Cin <=1'b1;
		@(posedge r_clk);
		
			if (w_Cout !=1'b1 || w_S !=1'b0)
				begin
					err = err + 1;
					$display("Err, step 6");	
				end
					else
						begin
							err = err;
							
						end
		
		@(posedge r_clk);
		r_A <= 1'b1;
		r_B <= 1'b1;
		r_Cin <=1'b1;
		@(posedge r_clk);
		
		if (w_Cout !=1'b1 || w_S !=1'b1)
				begin
					err = err + 1;
					$display("Err, step 7");	
				end
					else
						begin
							err = err;
							
						end
						
		$display("Tests completed with %d errors", err);
		$stop;
	
		end

endmodule
