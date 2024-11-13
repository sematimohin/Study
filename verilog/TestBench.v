`timescale 1 ns/1 ps
/*устанавливает единицы измерения в которых измеряются все задержки в проекте (первое число) 
и точность с которой система моделирования рассчитывает задержки или, иначе, шаг моделирования (второе число).
*/
module testbench ();
	
	reg [3:0] r_D0 = 4'b0;
	reg [3:0] r_D1 = 4'b0;
	reg r_s = 1'b0;
	wire [3:0] w_Y;
	reg r_clk = 1'b0;

	MUX2 UUT1
	(
		.i_D0(r_D0),
		.i_D1(r_D1),
		.i_s(r_s),
		.o_Y(w_Y)
		
	);
	defparam UUT1.n = 4;

	always #(20) r_clk <= ~r_clk;
		
	initial
		begin: main_test
		integer i, err;
		err = 0;
		r_s <= 1'b0;
				for (i=4'b0000; i<=4'b1111;i=i+4'b0001)
					begin
						r_D0 = i;
						r_D1 = i+4'b0001;
						@(posedge r_clk);
						if(w_Y != r_D0)
						begin
							err = err + 1;
							$display("Err, step 0, iter %d", i);
						end
					end
		r_s <= 1'b1;
				for (i=4'b0000; i<=4'b1111;i=i+4'b0001)
					begin
						r_D0 <= i;
						r_D1 <= i+4'b0001 ;
						@(posedge r_clk);
						if(w_Y != r_D1)
						begin
							err = err + 1;
							$display("Err, step 1, iter %d", i);
						end
					end
		r_s <= 1'b0;
				for (i=4'b0000; i<=4'b1111;i=i+4'b0001)
					begin
						r_D0 <= i;
						r_D1 <= i;
						@(posedge r_clk);
						if(w_Y != r_D0)
						begin
							err = err + 1;
							$display("Err, step 2, iter %d", i);
						end
					end
		r_s <= 1'b1;
				for (i=4'b0000; i<=4'b1111;i=i+4'b0001)
					begin
						r_D0 <= i;
						r_D1 <= i;
						@(posedge r_clk);
						if(w_Y != r_D1)
						begin
							err = err + 1;
							$display("Err, step 3, iter %d", i);
						end
					end
		$display("Tests completed with %d errors", err);
		$stop;
		
		end
		
endmodule
		
					
	  
		//r_D0 <= i;
		//r_D1 <= 4'b0001;
		//r_s <= 1'b0;
		
//@(posedge r_clk);
		
		
		
		
//r_D0 <= 4'b0000;
//r_D1 <= 4'b0001;
//r_s <= 1'b1;
//@(posedge r_clk);
//$stop;
//	end

//endmodule

	