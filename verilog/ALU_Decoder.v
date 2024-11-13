module ALU_Decoder
	(
		input [1:0] ALUOp, 
		input [5:0] Funct,
		output [2:0] ALUControl
		
	);
	
	reg [2:0]r_ALUControl = 0;
	
	assign ALUControl = r_ALUControl;
	
	always @(*)
	
		if (ALUOp == 2'b00)
			r_ALUControl = 3'b010; // сложение
			
			else if(ALUOp == 2'b01 )
					r_ALUControl = 3'b110; // вычитание
				else if(ALUOp == 2'b10)
				
						begin
						
							case(Funct)
							
							6'b100000: r_ALUControl = 3'b010; // Сложение
							6'b100010: r_ALUControl = 3'b110; // Вычитание
							6'b100100: r_ALUControl = 3'b000; // Логическое И
							6'b100101: r_ALUControl = 3'b001; // Логическое ИЛИ
							6'b101010: r_ALUControl = 3'b111; // Установить, если меньше
							
						endcase
							
						end
						
endmodule 



