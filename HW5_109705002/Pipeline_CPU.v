module Pipeline_CPU( clk_i, rst_n );

//I/O port
input         clk_i;
input         rst_n;

//Internal Signles
wire [32-1:0] instr, PC_i, PC_o, ReadData1, ReadData2, WriteData;
wire [32-1:0] signextend, zerofilled, ALUinput2, ALUResult, ShifterResult;
wire [5-1:0] WriteReg_addr, Shifter_shamt;
wire [4-1:0] ALU_operation;
wire [3-1:0] ALUOP;
wire [2-1:0] FURslt;
wire [2-1:0] RegDst, MemtoReg;
wire RegWrite, ALUSrc, zero, overflow;
wire Jump, Branch, BranchType, MemWrite, MemRead;
wire [32-1:0] PC_add1, PC_add2, PC_no_jump, PC_t, Mux3_result, DM_ReadData;
wire Jr;
assign Jr = ((instr[31:26] == 6'b000000) && (instr[20:0] == 21'd8)) ? 1 : 0;

//ID
wire [32-1:0] PC_add1_ID;
wire [32-1:0] instr_ID;
//EX
wire [32-1:0] ReadData1_EX;
wire [32-1:0] ReadData2_EX;
wire RegWrite_EX;
wire [3-1:0] ALUOP_EX;
wire ALUSrc_EX;
wire [2-1:0] RegDst_EX;
wire Jump_EX;
wire Branch_EX;
wire MemWrite_EX;
wire MemRead_EX;
wire [2-1:0] MemtoReg_EX;
wire [32-1:0] signextend_EX;
wire [20:0] instr_EX;
wire [32-1:0] PC_add1_EX;
//MEM
wire [32-1:0] PC_add2_MEM;
wire [32-1:0] ALUResult_MEM;
wire zero_MEM; 
wire [5-1:0] WriteReg_addr_MEM;
wire [32-1:0] ReadData2_MEM; 
wire RegWrite_MEM;
wire Branch_MEM;
wire MemRead_MEM;
wire MemWrite_MEM;
wire [2-1:0] MemtoReg_MEM;
//WB
wire [32-1:0] DM_ReadData_WB;
wire [32-1:0] ALUResult_WB;
wire [5-1:0] WriteReg_addr_WB;
wire RegWrite_WB;
wire [2-1:0] MemtoReg_WB;

//modules

// IF
Mux2to1 #(.size(32)) Mux_branch(
        .data0_i(PC_add1),
        .data1_i(PC_add2_MEM),
        .select_i(Branch_MEM & zero_MEM),
        .data_o(PC_i)
        );


Program_Counter PC(
        .clk_i(clk_i),
	    .rst_n(rst_n),
	    .pc_in_i(PC_i),
	    .pc_out_o(PC_o)
	    );

Adder Adder1(//next instruction
        .src1_i(PC_o), 
	    .src2_i(32'd4),
	    .sum_o(PC_add1)
	    );

Instr_Memory IM(
        .pc_addr_i(PC_o),
	    .instr_o(instr)
	    );

// IF/ID
Pipeline_Reg #(.size(64)) IF_ID( 
		.clk_i(clk_i),
		.rst_n(rst_n),
		.data_i({PC_add1, instr}),
		.data_o({PC_add1_ID, instr_ID})
		);

// ID
Reg_File RF(
        .clk_i(clk_i),
	    .rst_n(rst_n),
        .RSaddr_i(instr_ID[25:21]),
        .RTaddr_i(instr_ID[20:16]),
        .RDaddr_i(WriteReg_addr_WB),
        .RDdata_i(WriteData),
        .RegWrite_i(RegWrite_WB),
        .RSdata_o(ReadData1),
        .RTdata_o(ReadData2)
        );

Decoder Decoder(
        .instr_op_i(instr_ID[31:26]),
	    .RegWrite_o(RegWrite),
	    .ALUOp_o(ALUOP),
	    .ALUSrc_o(ALUSrc),
	    .RegDst_o(RegDst),
                .Jump_o(Jump),
                .Branch_o(Branch),
                .BranchType_o(BranchType),
                .MemWrite_o(MemWrite),
                .MemRead_o(MemRead),
                .MemtoReg_o(MemtoReg)
                );

Sign_Extend SE(
        .data_i(instr_ID[15:0]),
        .data_o(signextend)
        );


// ID/EX
Pipeline_Reg #(.size(161)) ID_EX( 
		.clk_i(clk_i),
		.rst_n(rst_n),
		.data_i({ReadData1, ReadData2, RegWrite, ALUOP, ALUSrc, RegDst, Branch, MemWrite, MemRead, MemtoReg, signextend, instr_ID[20:0], PC_add1_ID}),
		.data_o({ReadData1_EX, ReadData2_EX, RegWrite_EX, ALUOP_EX, ALUSrc_EX, RegDst_EX, Branch_EX, MemWrite_EX, MemRead_EX, MemtoReg_EX, signextend_EX, instr_EX, PC_add1_EX})
		);

// EX
Adder Adder2(//branch
        .src1_i(PC_add1_EX),
	    .src2_i({signextend_EX[29:0], 2'b00}),//shift left 2
	    .sum_o(PC_add2)
	    );

ALU ALU(
	    .aluSrc1(ReadData1_EX),
	    .aluSrc2(ALUinput2),
	    .ALU_operation_i(ALU_operation),
		.result(ALUResult),
		.zero(zero),
		.overflow(overflow)
	    );

ALU_Ctrl AC(
        .funct_i(instr_EX[5:0]),
        .ALUOp_i(ALUOP_EX),
        .ALU_operation_o(ALU_operation),
		.FURslt_o(FURslt)
        );

Shifter shifter( 
		.result(ShifterResult),
		.leftRight(ALU_operation[0]),
		.shamt(instr[10:6]),
		.sftSrc(ALUinput2)
		);


Mux2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_EX[20:16]),
        .data1_i(instr_EX[15:11]),
        .select_i(RegDst_EX),
        .data_o(WriteReg_addr)
        );

Mux2to1 #(.size(32)) ALU_src2Src(
        .data0_i(ReadData2_EX),
        .data1_i(signextend_EX),
        .select_i(ALUSrc_EX),
        .data_o(ALUinput2)
        );	
	

// EX/MEM
Pipeline_Reg #(.size(108)) EX_MEM( 
		.clk_i(clk_i),
		.rst_n(rst_n),
		.data_i({PC_add2, ALUResult, zero, WriteReg_addr, ReadData2_EX, RegWrite_EX, Branch_EX, MemRead_EX, MemWrite_EX, MemtoReg_EX}),
		.data_o({PC_add2_MEM, ALUResult_MEM, zero_MEM, WriteReg_addr_MEM, ReadData2_MEM, RegWrite_MEM, Branch_MEM, MemRead_MEM, MemWrite_MEM, MemtoReg_MEM})
		);

// MEM
Data_Memory DM(
		.clk_i(clk_i),
		.addr_i(ALUResult_MEM),
		.data_i(ReadData2_MEM),
		.MemRead_i(MemRead_MEM),
		.MemWrite_i(MemWrite_MEM),
		.data_o(DM_ReadData)
		);


// MEM/WB
Pipeline_Reg #(.size(72)) MEM_WB( 
		.clk_i(clk_i),
		.rst_n(rst_n),
		.data_i({DM_ReadData, ALUResult_MEM, WriteReg_addr_MEM, RegWrite_MEM, MemtoReg_MEM}),
		.data_o({DM_ReadData_WB, ALUResult_WB, WriteReg_addr_WB, RegWrite_WB, MemtoReg_WB})
		);

// WB
Mux2to1 #(.size(32)) Mux_Write( 
        .data0_i(ALUResult_WB),
        .data1_i(DM_ReadData_WB),
        .select_i(MemtoReg_WB),
        .data_o(WriteData)
        );


endmodule