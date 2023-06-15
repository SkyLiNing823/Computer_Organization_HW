module Zero_Filled( data_i, data_o );

//I/O ports
input	[16-1:0] data_i;
output	[32-1:0] data_o;

//Internal Signals
wire	[32-1:0] data_o;

//Zero_Filled
assign data_o[15:0] = data_i[15:0];
assign data_o[16] = 0;
assign data_o[17] = 0;
assign data_o[18] = 0;
assign data_o[19] = 0;
assign data_o[20] = 0;
assign data_o[21] = 0;
assign data_o[22] = 0;
assign data_o[23] = 0;
assign data_o[24] = 0;
assign data_o[25] = 0;
assign data_o[26] = 0;
assign data_o[27] = 0;
assign data_o[28] = 0;
assign data_o[29] = 0;
assign data_o[30] = 0;
assign data_o[31] = 0;

endmodule      
