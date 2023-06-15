module Simple_Single_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles

// Program_Counter
wire [31:0] pc_input, pc;

// Instr_Memory
wire [31:0] instruction;

// Reg_File
wire [4:0] WriteRegister;
wire [31:0] RsData, RtData, WriteData;

// Decoder
wire RegDst, RegWrite, ALUSrc;
wire [2:0] ALUOP;
wire [1:0] FURslt;

// ALU_Ctrl
wire [3:0] ALU_operation;

// Sign_Extend
wire [31:0] SignExtended;

// Zero_Filled
wire [31:0] ZeroFilled;

// ALU
wire [31:0] MUX_ALUSrc, ALU_result;
wire zero, overflow;

// Shifter
wire [32-1:0] shifter_result;

//modules
Program_Counter PC(
        .clk_i(clk_i),      
	    .rst_n(rst_n),     
	    .pc_in_i(pc_input) ,   
	    .pc_out_o(pc) 
	    );
	
Adder Adder1(
        .src1_i(pc),     
	    .src2_i(32'd4),
	    .sum_o(pc_input)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc),  
	    .instr_o(instruction)    
	    );

Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruction[20:16]),
        .data1_i(instruction[15:11]),
        .select_i(RegDst),
        .data_o(WriteRegister)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_n(rst_n) ,     
        .RSaddr_i(instruction[25:21]) ,  
        .RTaddr_i(instruction[20:16]) ,  
        .RDaddr_i(WriteRegister) ,  
        .RDdata_i(WriteData)  , 
        .RegWrite_i(RegWrite),
        .RSdata_o(RsData) ,  
        .RTdata_o(RtData)   
        );
	
Decoder Decoder(
        .instr_op_i(instruction[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUOp_o(ALUOP),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst)   
		);

ALU_Ctrl AC(
        .funct_i(instruction[5:0]),   
        .ALUOp_i(ALUOP),   
        .ALU_operation_o(ALU_operation),
		.FURslt_o(FURslt)
        );
	
Sign_Extend SE(
        .data_i(instruction[15:0]),
        .data_o(SignExtended)
        );

Zero_Filled ZF(
        .data_i(instruction[15:0]),
        .data_o(ZeroFilled)
        );
		
Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(RtData),
        .data1_i(SignExtended),
        .select_i(ALUSrc),
        .data_o(MUX_ALUSrc)
        );	
		
ALU ALU(
		.aluSrc1(RsData),
	    .aluSrc2(MUX_ALUSrc),
	    .ALU_operation_i(ALU_operation),
		.result(ALU_result),
		.zero(zero),
		.overflow(overflow)
	    );
		
Shifter shifter( 
		.result(shifter_result), 
		.leftRight(ALUOP[0]),
		.shamt(instruction[10:6]),
		.sftSrc(MUX_ALUSrc) 
		);
		
Mux3to1 #(.size(32)) RDdata_Source(
        .data0_i(ALU_result),
        .data1_i(shifter_result),
		.data2_i(ZeroFilled),
        .select_i(FURslt),
        .data_o(WriteData)
        );			

endmodule



