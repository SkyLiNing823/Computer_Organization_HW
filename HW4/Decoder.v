module Decoder( instr_op_i, RegWrite_o,	ALUOp_o, ALUSrc_o, RegDst_o, Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o, MemtoReg_o);
     
//I/O ports
input	[6-1:0] instr_op_i;

output			RegWrite_o;
output	[3-1:0] ALUOp_o;
output			ALUSrc_o;
output	[2-1:0] RegDst_o, MemtoReg_o;
output			Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o;
 
//Internal Signals
wire	[3-1:0] ALUOp_o;
wire			ALUSrc_o;
wire			RegWrite_o;
wire	[2-1:0] RegDst_o, MemtoReg_o;
wire			Jump_o, Branch_o, BranchType_o, MemWrite_o, MemRead_o;

//Main function
/*your code here*/
assign ALUOp_o[2:0] = (instr_op_i == 6'b000000) ? 3'b010 : // R-fromat
                      (instr_op_i == 6'b001000) ? 3'b011 : // addi
                      (instr_op_i == 6'b100001) ? 3'b000 : // lw
                      (instr_op_i == 6'b100011) ? 3'b000 : // sw
                      (instr_op_i == 6'b111011) ? 3'b001 : // beq
                      (instr_op_i == 6'b100101) ? 3'b110 : // bne
                                                  3'b000 ;  // j

assign ALUSrc_o =   (instr_op_i == 6'b000000) ? 1'b0 :  // R-fromat
                    (instr_op_i == 6'b001000) ? 1'b1 :  // addi
                    (instr_op_i == 6'b100001) ? 1'b1 :  // lw
                    (instr_op_i == 6'b100011) ? 1'b1 :  // sw
                    (instr_op_i == 6'b111011) ? 1'b0 :  // beq
                    (instr_op_i == 6'b100101) ? 1'b0 :  // bne
                                                1'b1 ;  // j

assign RegWrite_o = (instr_op_i == 6'b000000) ? 1'b1 :  // R-fromat
                    (instr_op_i == 6'b001000) ? 1'b1 :  // addi
                    (instr_op_i == 6'b100001) ? 1'b1 :  // lw
                    (instr_op_i == 6'b100011) ? 1'b0 :  // sw
                    (instr_op_i == 6'b111011) ? 1'b0 :  // beq
                    (instr_op_i == 6'b100101) ? 1'b0 :  // bne
                                                1'b0 ;  // j
                    
assign RegDst_o =   (instr_op_i == 6'b000000) ? 2'b01 :  // R-fromat
                    (instr_op_i == 6'b001000) ? 2'b00 :  // addi
                    (instr_op_i == 6'b100001) ? 2'b00 :  // lw
                    (instr_op_i == 6'b100011) ? 2'b00 :  // sw
                    (instr_op_i == 6'b111011) ? 2'b00 :  // beq
                    (instr_op_i == 6'b100101) ? 2'b00 :  // bne
                                                2'b00 ;  // j

assign MemtoReg_o = (instr_op_i == 6'b000000) ? 2'b00 :  // R-fromat
                    (instr_op_i == 6'b001000) ? 2'b00 :  // addi
                    (instr_op_i == 6'b100001) ? 2'b01 :  // lw
                    (instr_op_i == 6'b100011) ? 2'b00 :  // sw
                    (instr_op_i == 6'b111011) ? 2'b00 :  // beq
                    (instr_op_i == 6'b100101) ? 2'b00 :  // bne
                                                2'b00 ;  // j

assign Jump_o = (instr_op_i == 6'b000000) ? 1'b0 :  // R-fromat
                (instr_op_i == 6'b001000) ? 1'b0 :  // addi
                (instr_op_i == 6'b100001) ? 1'b0 :  // lw
                (instr_op_i == 6'b100011) ? 1'b0 :  // sw
                (instr_op_i == 6'b111011) ? 1'b0 :  // beq
                (instr_op_i == 6'b100101) ? 1'b0 :  // bne
                                            1'b1 ;  // j

assign Branch_o = (instr_op_i == 6'b000000) ? 1'b0 :  // R-fromat
                  (instr_op_i == 6'b001000) ? 1'b0 :  // addi
                  (instr_op_i == 6'b100001) ? 1'b0 :  // lw
                  (instr_op_i == 6'b100011) ? 1'b0 :  // sw
                  (instr_op_i == 6'b111011) ? 1'b1 :  // beq
                  (instr_op_i == 6'b100101) ? 1'b1 :  // bne
                                              1'b0 ;  // j

assign BranchType_o = (instr_op_i == 6'b000000) ? 1'b0 :  // R-fromat
                      (instr_op_i == 6'b001000) ? 1'b0 :  // addi 
                      (instr_op_i == 6'b100001) ? 1'b0 :  // lw
                      (instr_op_i == 6'b100011) ? 1'b0 :  // sw
                      (instr_op_i == 6'b111011) ? 1'b0 :  // beq
                      (instr_op_i == 6'b100101) ? 1'b1 :  // bne
                                                  1'b0 ;  // j

assign MemWrite_o = (instr_op_i == 6'b000000) ? 1'b0 :  // R-fromat
                    (instr_op_i == 6'b001000) ? 1'b0 :  // addi
                    (instr_op_i == 6'b100001) ? 1'b0 :  // lw
                    (instr_op_i == 6'b100011) ? 1'b1 :  // sw
                    (instr_op_i == 6'b111011) ? 1'b0 :  // beq
                    (instr_op_i == 6'b100101) ? 1'b0 :  // bne
                                                1'b0 ;  // j

assign MemRead_o = (instr_op_i == 6'b000000) ? 1'b0 :  // R-fromat
                   (instr_op_i == 6'b001000) ? 1'b0 :  // addi
                   (instr_op_i == 6'b100001) ? 1'b1 :  // lw
                   (instr_op_i == 6'b100011) ? 1'b0 :  // sw
                   (instr_op_i == 6'b111011) ? 1'b0 :  // beq
                   (instr_op_i == 6'b100101) ? 1'b1 :  // bne
                                               1'b0 ;  // j

endmodule
   