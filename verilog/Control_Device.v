
module Control_Device	
	(	
		input wire [5:0]Opcode,
		input wire [5:0]Funct,
		output wire MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,Jump,
		output wire [2:0]ALUControl
		
	);
	
	wire [1:0] w_ALUOp;
	
	
	MainDecoder MainDecoder
	(
		.Opcode(Opcode),
		.MemtoReg(MemtoReg),
		.MemWrite(MemWrite),
		.Branch(Branch),
		.ALUSrc(ALUSrc),
		.RegDst(RegDst),
		.RegWrite(RegWrite),
		.ALUOp(w_ALUOp),
		.Jump(Jump)
	
	);

	ALU_Decoder ALU_Decoder
	(
		.ALUOp(w_ALUOp),
		.Funct(Funct),
		.ALUControl(ALUControl)
	
	);
	
	
	
endmodule
	
	
