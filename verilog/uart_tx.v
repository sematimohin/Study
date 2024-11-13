// Module for UART transmitter
// Use this formula to calculate input parameter: CLKS_PER_BIT = (frequency of i_Clock)/(UART baudrate)
// Result value can't be more then 255, otherwise counter will be overfilled
// Example: 10 MHz frequency, 115200 baudrate
// (10000000)/(115200) = 87

module UART_TX 
	#(parameter CLKS_PER_BIT = 87)
	(
		input  wire       i_CLK,			// Input clock signal
		input  wire       i_TX_DV,			// Input signal to start the transmission
		input  wire [7:0] i_TX_BYTE,		// Input data byte for transmit
		output wire      	o_TX_ACTIVE,	// Output signal, active during transmission
		output wire      	o_TX_START,		// Output signal, arise at the start of the start byte transmission (one clock impuls)
		output wire  		o_TX_SERIAL,	// Output UART data line
		output wire      	o_TX_DONE		// Output signal for complete of data transmission (one clock impuls)
	);
	
	// Constatnts for UART state machine
	reg [2:0] s_IDLE         = 3'b000;
	reg [2:0] s_TX_START_BIT = 3'b001;
	reg [2:0] s_TX_DATA_BITS = 3'b010;
	reg [2:0] s_TX_STOP_BIT  = 3'b011;
	reg [2:0] s_CLEANUP      = 3'b100;
   
	// Varaibles
	reg [2:0] r_SM_Main     = 3'b0;	// 3x nuber for current state machine state
	reg [7:0] r_Clock_Count = 8'b0;	// 8x counter for uart symbol length calculation
	reg [2:0] r_Bit_Index   = 3'b0;	// 3x index (from 0 to 7) for transmitted bit of output data byte
	reg [7:0] r_Tx_Data     = 8'b0;	// Transmitted data byte
	reg       r_Tx_Done     = 1'b0; 	// Cell for state of the output transmission complete signal
	reg       r_Tx_Active   = 1'b0;	// Cell for state of the output transmission in progress signal
	reg       r_Tx_Start    = 1'b0;	// Cell for state of the output transmission start signal
	reg       r_Tx_Serial   = 1'b1;  // Cell for the state of outpud data line
   
	// Transmitter state machine
	always @(posedge i_CLK)
	begin
		case (r_SM_Main)
			// Wait for new data
			s_IDLE:
			begin
				r_Tx_Serial   <= 1'b1;	// While not transmitting data line should be in high state
				r_Tx_Done     <= 1'b0;
            r_Clock_Count <= 8'b0;
            r_Bit_Index   <= 1'b0;             
            if (i_TX_DV == 1)	// When start of the transmission signal arise, set the data transmitting and start of the transmission flags
				begin
					r_Tx_Active <= 1'b1;
					r_Tx_Start  <= 1'b1;
					r_SM_Main   <= s_TX_START_BIT;	// go to the next state
				end
            else
				begin
					r_SM_Main <= s_IDLE;
				end
			end
			// Send the start byte. The start byte is always low level
			s_TX_START_BIT:
			begin
				if(r_Clock_Count == 0)
				begin
					r_Tx_Start <= 1'b0; // Reset start of the transmission flag
				end
				if(r_Clock_Count == 1)
				begin
					r_Tx_Data   <= i_TX_BYTE; // Sample transmitted byte at the next clock cycle
				end
            r_Tx_Serial <= 1'b0;
            // Wait for the byte length
            if (r_Clock_Count < CLKS_PER_BIT - 1)
				begin
					r_Clock_Count <= r_Clock_Count + 1;
					r_SM_Main     <= s_TX_START_BIT;
				end
            else
				begin
					r_Clock_Count <= 8'b0;
					r_SM_Main     <= s_TX_DATA_BITS;	// Go to the data bytes transmission
				end
			end
			// Send 8 bytes of data       
			s_TX_DATA_BITS:
			begin
				r_Tx_Serial <= r_Tx_Data[r_Bit_Index];
				if (r_Clock_Count < CLKS_PER_BIT - 1)
				begin
					r_Clock_Count <= r_Clock_Count + 1;
					r_SM_Main     <= s_TX_DATA_BITS;
				end
				else
				begin
					r_Clock_Count <= 8'b0;
					// Check, that we sended all the data
					if (r_Bit_Index < 7)
					begin
						r_Bit_Index <= r_Bit_Index + 1;
						r_SM_Main   <= s_TX_DATA_BITS;
					end
					else
					begin
						r_Bit_Index <= 1'b0;
						r_SM_Main   <= s_TX_STOP_BIT; // Go to the transmission of the stop byte
					end
				end
			end
			// Send the stop byte. The stop byte is always high level
			s_TX_STOP_BIT:
			begin
				r_Tx_Serial <= 1'b1;
				// Wait for the byte length
            if (r_Clock_Count < CLKS_PER_BIT-1)
				begin
					r_Clock_Count <= r_Clock_Count + 1;
					r_SM_Main     <= s_TX_STOP_BIT;
				end
            else
				begin	// Upon completing transmission reset actie transmission flag and go to the final state
					r_Tx_Done     <= 1'b1;
					r_Clock_Count <= 8'b0;
					r_Tx_Active   <= 1'b0;
					r_SM_Main     <= s_CLEANUP;
				end
			end
			// Wait one clock in the state, lower transmit completed flag and return to the wait for new data state
			s_CLEANUP:
			begin
				r_Tx_Done <= 1'b0;
				r_SM_Main <= s_IDLE;
			end
			default:
			begin
				r_SM_Main <= s_IDLE;
			end
		endcase
	end
 
	assign o_TX_SERIAL = r_Tx_Serial;
	assign o_TX_ACTIVE = r_Tx_Active;
	assign o_TX_DONE   = r_Tx_Done;
	assign o_TX_START  = r_Tx_Start; 
endmodule
