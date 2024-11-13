module adder32
	(
	input wire [31:0] i_A,
	input wire [31:0] i_B,
	output wire [31:0] o_S
	//output wire o_Cout
	
	);
	
	assign o_S = i_A + i_B;	//эта строчка равносильна тому, что расписано ниже в блоках adder add0..7
	
	
	//Правильное ли суммирование?
	
	/*
	wire i_Cin1;
	wire i_Cin2;
	wire i_Cin3;
	wire i_Cin4;
	wire i_Cin5;
	wire i_Cin6;
	wire i_Cin7;
	
	adder add0 
		(
			.i_A(i_A[0]),
			.i_B(i_B[0]),
			.C_in(1'b0),
			.C_out(i_Cin1),
			.o_S(o_S[0])
			
		);
		
	adder add1 
		(
			.i_A(i_A[1]),
			.i_B(i_B[1]),
			.C_in(i_Cin1),
			.C_out(i_Cin2),
			.o_S(o_S[1])
			
		);
		
	adder add2 
		(
			.i_A(i_A[2]),
			.i_B(i_B[2]),
			.C_in(i_Cin2),
			.C_out(i_Cin3),
			.o_S(o_S[2])
			
		);
		
	adder add3 
		(
			.i_A(i_A[3]),
			.i_B(i_B[3]),
			.C_in(i_Cin3),
			.C_out(i_Cin4),
			.o_S(o_S[3])
			
		);
		
	adder add4 
		(
			.i_A(i_A[4]),
			.i_B(i_B[4]),
			.C_in(i_Cin4),
			.C_out(i_Cin5),
			.o_S(o_S[4])
			
		);
		
	adder add5 
		(
			.i_A(i_A[5]),
			.i_B(i_B[5]),
			.C_in(i_Cin5),
			.C_out(i_Cin6),
			.o_S(o_S[5])
			
		);
		
	adder add6 
		(
			.i_A(i_A[6]),
			.i_B(i_B[6]),
			.C_in(i_Cin6),
			.C_out(i_Cin7),
			.o_S(o_S[6])
			
		);
	
	adder add7 
		(
			.i_A(i_A[7]),
			.i_B(i_B[7]),
			.C_in(i_Cin7),
			.C_out(o_Cout),
			.o_S(o_S[7])
			
		);
		
		*/
	
endmodule
	
	
	
	
	
	
	
	