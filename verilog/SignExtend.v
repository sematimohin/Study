module SignExtend
	(
		input wire [15:0]in_data,
		output reg [31:0]out_data
	);
	
	always @(*)
	
		begin
			out_data = {{16{in_data[15]}},in_data}; //????
			
			//signimm <= $signed(instr);
		end
endmodule
 