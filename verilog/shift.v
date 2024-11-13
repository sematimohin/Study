module shift
	(
		input wire [31:0]in_data,
		output wire [31:0] out_data
	
	);
	//reg [31:0]result_out;
	//assign out_data = result_out;
	
assign out_data = in_data<<2; //более краткое описание сдвига с помощью встроенного оператора <<

	//initial
		//begin
			//result_out = {in_data[29:0],1'b0,1'b0}; так тоже можно описать сдвиг на два влево
		//end
			


endmodule	
	
	
	