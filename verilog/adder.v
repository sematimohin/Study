module adder
//#(parameter n = 8)
		(
			output wire C_out,
			input wire C_in,
			output wire [31:0]o_S,
			input wire [31:0]i_A,
			input wire [31:0]i_B
			
		);
		
		assign {C_out,o_S} = i_A + i_B + C_in;

endmodule		