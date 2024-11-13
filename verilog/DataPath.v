module DataPath
	(

	input wire clk,
	output wire MemWrite_in,
	output wire[31:0] DM_inA,
	output wire[31:0] DM_inWD,
	input wire reset,
	
	output wire serial
  
	);
	
	
	wire WE3;
	wire MemWrite;
	wire Branch;
	wire RegDst;
	wire ALUSrc;
	wire [2:0]ALUControl;
	wire MemtoReg;
	wire Jump;
	
	
	
	wire [31:0]DataMemory_inA;
	wire [31:0]DataMemory_inWD;
	wire [31:0]DataMemory_outRD;
	wire [31:0]InstructionMemory_in;
	wire [31:0]InstructionMemory_out;

	
	wire [31:0]W1,W3,W7,W8,W13,W10,W12,W2,W14,W15;
	wire [4:0]W9;

	wire zeroflag;
	
	
	//assign W15 = {W3,W14};
	
	wire [31:0]W5,W6,W11;
	
	assign PCSrc = Branch & zeroflag;
	assign MemWrite_in = MemWrite;
	assign DM_inA = DataMemory_inA;
	assign DM_inWD = DataMemory_inWD;
	

	
		shift2 jump_shift
		(
			.in_1(InstructionMemory_out[25:0]),
			.in_2(W3[31:28]),
			.out(W15)
		
		);
	
	
	
		MUX2 MUX_beforePC
		(
			.i_D0(W1),
			.i_D1(W15),
			.o_Y(W2),
			.i_s(Jump)
		
		);
	

		Instruction_Memory Instruction_Memory 
		(
			.Instruction_Adress(InstructionMemory_in),
			.Instruction(InstructionMemory_out)
	
		);	
		
		Data_Memory_UART Data_Memory
		(
			.clk(clk),
			.WE1(MemWrite),
			.A(DataMemory_inA),
			.WD(DataMemory_inWD),
			.RD(DataMemory_outRD),
			.serial(serial)
		
		);	
	
	
		Control_Device Control_Device
		(
			.Opcode(InstructionMemory_out[31:26]),
			.Funct(InstructionMemory_out[5:0]),
			.MemtoReg(MemtoReg),
			.MemWrite(MemWrite),
			.Branch(Branch),
			.ALUSrc(ALUSrc),
			.RegDst(RegDst),
			.RegWrite(WE3),
			.ALUControl(ALUControl),
			.Jump(Jump)
		
		);

		MUX2 MUX_start
		(
			.i_D0(W3),
			.i_D1(W13),
			.o_Y(W1),
			.i_s(PCSrc)
		
		);
		
		Reg PC
		(
			.clk(clk),
			.d(W2),
			.q(InstructionMemory_in),
			.reset(1'b0)
		
		);
		
		adder32 PCPlus4
		(
			.i_A(InstructionMemory_in),
			.i_B(32'd4),
			.o_S(W3)
		
		);
		
		Register_File RF
		(
			.A1(InstructionMemory_out[25:21]),
			.A2(InstructionMemory_out[20:16]),
			.A3(W9),
			.WD3(W8),
			.RD1(W5),
			.RD2(DataMemory_inWD), //?????
			.clk(clk),
			.WE3(WE3)
			
		);
		
		MUX2 MUX_underRF  //?????
		(
			.i_D0(InstructionMemory_out[20:16]),
			.i_D1(InstructionMemory_out[15:11]),
			.o_Y(W9),
			.i_s(RegDst)
		
		);
		defparam MUX_underRF.n = 5;
		
		SignExtend SignExtend
		(
			.in_data(InstructionMemory_out[15:0]),
			.out_data(W10)
		
		
		);
		
		MUX2 MUX_beforeALU
		(
			.i_D0(DataMemory_inWD), //???
			.i_D1(W10),
			.o_Y(W11),
			.i_s(ALUSrc)
		
		);
		
		
		ALU ALU
		(
			.Cmd(ALUControl),
			.i_A(W5),
			.i_B(W11),
			.o_Res(DataMemory_inA),
			.zeroflag(zeroflag)
		
		);
		
		
		shift shift1
		(
			.in_data(W10),
			.out_data(W12)
		
		);
		
		
		adder32 PCBranch
		(
			.i_A(W12),
			.i_B(W3),
			.o_S(W13)
		
		);
		
		MUX2 MUX_result
		(
			.i_D0(DataMemory_inA),
			.i_D1(DataMemory_outRD),
			.o_Y(W8),
			.i_s(MemtoReg)
		
		);
		
		


	
endmodule 