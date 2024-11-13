module MainDecoder	
	(	
		input wire [5:0]Opcode,
		output wire MemtoReg,MemWrite,Branch,ALUSrc,RegDst,RegWrite,Jump,
		output wire [1:0]ALUOp
		
	);
	reg [1:0]r_ALUOp = 0;
	reg r_MemtoReg = 0;
	reg r_MemWrite = 0;
	reg r_Branch = 0;
	reg r_ALUSrc = 0;
	reg r_RegDst = 0;
	reg r_RegWrite = 0;
	reg r_Jump = 0;
	
	
	assign ALUOp = r_ALUOp;
	assign MemtoReg = r_MemtoReg;
	assign MemWrite = r_MemWrite;
	assign Branch = r_Branch;
	assign ALUSrc = r_ALUSrc;
	assign RegDst = r_RegDst;
	assign RegWrite = r_RegWrite;
	assign Jump = r_Jump;
	
	
	
	always @(*)
		begin 

		case (Opcode)
				6'b000000: //команды типа R
				begin
					r_ALUOp <= 2'b10;
					r_MemtoReg <= 0;
					r_MemWrite <= 0;
					r_Branch <= 0;
					r_ALUSrc <= 0;
					r_RegDst <= 1;
					r_RegWrite <= 1;		
					r_Jump <= 0;
				end
				6'b100011: //команды типа lw
				begin
					r_ALUOp <= 2'b00; 
					r_MemtoReg <= 1;
					r_MemWrite <= 0;
					r_Branch <= 0;
					r_ALUSrc <= 1;
					r_RegDst <= 0;
					r_RegWrite <= 1;
					r_Jump <= 0;			
				end
				6'b101011: //команды типа sw
				begin
					r_ALUOp <= 2'b00; 
					r_MemtoReg <= 1;
					r_MemWrite <= 1;
					r_Branch <= 0;
					r_ALUSrc <= 1;
					r_RegDst <= 1;
					r_RegWrite <= 0;
					r_Jump <= 0;			
				end
				6'b000100: //команды типа beq
				begin
					r_ALUOp <= 2'b01;
					r_MemtoReg <= 0;
					r_MemWrite <= 0;
					r_Branch <= 1;
					r_ALUSrc <= 0;
					r_RegDst <= 0;
					r_RegWrite <= 0;
					r_Jump <= 0;			
				end
				6'b001000: // команда addi
				begin
				r_ALUOp <= 2'b00; 
					r_MemtoReg <= 0;
					r_MemWrite <= 0;
					r_Branch <= 0;
					r_ALUSrc <= 1;
					r_RegDst <= 0;
					r_RegWrite <= 1;
					r_Jump <= 0;
				end
				6'b000010: //команда Jump
				begin
					r_ALUOp <= 2'b00; 
					r_MemtoReg <= 0;
					r_MemWrite <= 0;
					r_Branch <= 0;
					r_ALUSrc <= 1;
					r_RegDst <= 0;
					r_RegWrite <= 0;
					r_Jump <= 1;			
				end
			endcase
		
		end 
		
		
endmodule 