module shift2
	(
		input wire [25:0]in_1,
		input wire [3:0]in_2,
		output wire [31:0]out

	);

	assign out = {in_2,in_1,2'b0};
	
endmodule 