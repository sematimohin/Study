module ALU
	(	
		//input wire rst,clk,
		input wire [2:0]Cmd, //Командное слово
		input [31:0]i_A,i_B, // Сколько бит должны быть операнды в АЛУ????
		output wire [31:0]o_Res,
		output wire zeroflag
		
	);
	
	reg [31:0]Res;
	reg Flag;
	assign o_Res = Res;
	assign zeroflag = Flag;
	
	always @(*)
		if (Res == 32'd0)
			Flag = 1'b1;
				else
					Flag = 1'b0;
					
	always @(*)
		case(Cmd)
			3'b000:Res <= i_A&i_B; 
			3'b001:Res <= i_A|i_B; 
			3'b010:Res <= i_A+i_B;
			3'b100:Res <= i_A&~i_B; 
			3'b101:Res <= i_A|~i_B; 
			3'b110:Res <= i_A-i_B; 
			3'b111:
			begin
				if (i_A<i_B)
					Res <= 1;
					else
					Res <= 0;
			
					end
					
		endcase
	
	endmodule
	