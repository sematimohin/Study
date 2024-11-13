module Register_File
	(
		input wire [4:0] A1,
		input wire [4:0] A2,
		input wire [4:0] A3,
		input wire [31:0] WD3,
		output wire [31:0]RD1,
		output wire [31:0]RD2,
		input wire clk,WE3

	);
 reg [31:0]data_massive[0:31];
 
 
	assign RD1 = (A1==5'd0)?32'd0:data_massive[A1];
	assign RD2 = (A2==5'd0)?32'd0:data_massive[A2];
	
	always @(posedge clk)
		if (WE3)
			data_massive[A3] <= WD3;
				
endmodule 