`timescale 1 ns/1 ps

module testbench3();

reg r_clk = 1'b0;

reg [31:0]r_B = 8'd0;
reg [31:0]r_A = 8'd0;
reg [2:0] cmd = 3'b000;
wire [31:0] Result; 



	ALU ALU_TEST
		(
			.i_A(r_A),
			.i_B(r_B),
			.Cmd(cmd),
			.o_Res(Result)
			
		);
	
always #(20) r_clk <= ~r_clk;

initial
		begin: main_testALU

			cmd <= 3'b000;
			r_A <= 32'd1;
			r_B <= 32'd0;
		@(posedge r_clk);
			cmd <= 3'b000;
			r_A <= 32'd1;
			r_B <= 32'd1;
		@(posedge r_clk);
			cmd <= 3'b001;
			r_A <= 32'd0;
			r_B <= 32'd0;
		@(posedge r_clk);
			cmd <= 3'b001;
			r_A <= 32'd1;
			r_B <= 32'd0;
		@(posedge r_clk);
			cmd <= 3'b001;
			r_A <= 32'd0;
			r_B <= 32'd1;
		@(posedge r_clk);
			cmd <= 3'b010;
			r_A <= 32'b001;
			r_B <= 32'b010;
		@(posedge r_clk);
			cmd <= 3'b010;
			r_A <= 32'b010;
			r_B <= 32'b010;
		@(posedge r_clk);
			cmd <= 3'b100;
			r_A <= 32'd1;
			r_B <= 32'd0;
		@(posedge r_clk);
			cmd <= 3'b100;
			r_A <= 32'd1;
			r_B <= 32'd1;
		//@(posedge r_clk);
			//cmd <= 3'b101;
			//r_A <= 16'd0;
			//r_B <= 16'd1;
		//@(posedge r_clk);
			//cmd <= 3'b101;
			//r_A <= 16'd1;
			//r_B <= 16'd1;
		@(posedge r_clk);
			cmd <= 3'b110;
			r_A <= 32'd8;
			r_B <= 32'd4;
		@(posedge r_clk);
			cmd <= 3'b110;
			r_A <= 32'd5;
			r_B <= 32'd2;			
		@(posedge r_clk);
			cmd <= 3'b111;
			r_A <= 32'd1;
			r_B <= 32'd5;
		@(posedge r_clk);
		@(posedge r_clk);
			cmd <= 3'b111;
			r_A <= 32'd5;
			r_B <= 32'd1;	
@(posedge r_clk);			
		
		$stop;
			
		end
			
endmodule
