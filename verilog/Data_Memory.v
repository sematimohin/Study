module Data_Memory
	(
	
		input wire clk,
		input wire WE,
		input wire [31:0]inA,
		input wire [31:0]inWD,
		output wire [31:0]outRD
		
	);
	
	
reg [31:0]DataMemory[0:255];

assign outRD = DataMemory[inA[31:2]];

always @(posedge clk)

	if(WE == 1'b1)
		begin
			DataMemory[inA[31:2]] <= inWD;
		end

	
	
endmodule 



