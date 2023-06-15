module Pipeline_Reg( clk_i, rst_n, data_i, data_o);


parameter size = 0;

//I/O ports
input clk_i, rst_n;
input [size-1:0] data_i;
output reg [size-1:0] data_o;  
        

//Writing data when postive edge clk_i
always @( posedge clk_i ) begin
    if (~rst_n)
        data_o <= 0;
    else
        data_o <= data_i;
end

endmodule  