module Instruction_Memory
	(
		input wire [31:0]Instruction_Adress,
		output wire [31:0]Instruction
	);
	
reg [31:0]InstructionMemory[0:17];

assign Instruction = InstructionMemory[Instruction_Adress[31:2]];

initial
begin
$readmemh("C:\\Timokhin\\EP3C5E144C8N\\memfile.dat", InstructionMemory );
end


endmodule

