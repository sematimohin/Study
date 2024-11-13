module Reg
	(
		input wire clk,
		input wire [31:0]d,
		input wire reset,
		output wire [31:0]q
	
	);
	
	reg [31:0] q_data = 32'd0;
	
	always@(posedge clk)
		begin
			if (reset == 1'd1)
				q_data <= 0;
				
				else
					q_data <= d;
				end
					
	assign q = q_data;
endmodule 