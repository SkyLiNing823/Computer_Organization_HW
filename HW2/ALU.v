module ALU( result, zero, overflow, aluSrc1, aluSrc2, invertA, invertB, operation );
   
  output wire[31:0] result;
  output wire zero;
  output wire overflow;

  input wire[31:0] aluSrc1;
  input wire[31:0] aluSrc2;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  
  /*your code here*/
  wire set;
  // for carryIn & carryOut
  wire carryBits[32:0];
  assign carryBits[0] = (invertA == 1'b0 && invertB == 1'b1) ? 1'b1 : 1'b0 ;
  // constituted by 32 x ALU_1bit
  ALU_1bit ALU0(result[0], carryBits[1], aluSrc1[0], aluSrc2[0], invertA, invertB, operation, carryBits[0], set);
  ALU_1bit ALU1(result[1], carryBits[2], aluSrc1[1], aluSrc2[1], invertA, invertB, operation, carryBits[1], 1'b0);    
  ALU_1bit ALU2(result[2], carryBits[3], aluSrc1[2], aluSrc2[2], invertA, invertB, operation, carryBits[2], 1'b0);  
  ALU_1bit ALU3(result[3], carryBits[4], aluSrc1[3], aluSrc2[3], invertA, invertB, operation, carryBits[3], 1'b0);  
  ALU_1bit ALU4(result[4], carryBits[5], aluSrc1[4], aluSrc2[4], invertA, invertB, operation, carryBits[4], 1'b0);  
  ALU_1bit ALU5(result[5], carryBits[6], aluSrc1[5], aluSrc2[5], invertA, invertB, operation, carryBits[5], 1'b0);
  ALU_1bit ALU6(result[6], carryBits[7], aluSrc1[6], aluSrc2[6], invertA, invertB, operation, carryBits[6], 1'b0);
  ALU_1bit ALU7(result[7], carryBits[8], aluSrc1[7], aluSrc2[7], invertA, invertB, operation, carryBits[7], 1'b0);
  ALU_1bit ALU8(result[8], carryBits[9], aluSrc1[8], aluSrc2[8], invertA, invertB, operation, carryBits[8], 1'b0);
  ALU_1bit ALU9(result[9], carryBits[10], aluSrc1[9], aluSrc2[9], invertA, invertB, operation, carryBits[9], 1'b0);
  ALU_1bit ALU10(result[10], carryBits[11], aluSrc1[10], aluSrc2[10], invertA, invertB, operation, carryBits[10], 1'b0);
  ALU_1bit ALU11(result[11], carryBits[12], aluSrc1[11], aluSrc2[11], invertA, invertB, operation, carryBits[11], 1'b0);    
  ALU_1bit ALU12(result[12], carryBits[13], aluSrc1[12], aluSrc2[12], invertA, invertB, operation, carryBits[12], 1'b0);  
  ALU_1bit ALU13(result[13], carryBits[14], aluSrc1[13], aluSrc2[13], invertA, invertB, operation, carryBits[13], 1'b0);  
  ALU_1bit ALU14(result[14], carryBits[15], aluSrc1[14], aluSrc2[14], invertA, invertB, operation, carryBits[14], 1'b0);  
  ALU_1bit ALU15(result[15], carryBits[16], aluSrc1[15], aluSrc2[15], invertA, invertB, operation, carryBits[15], 1'b0);
  ALU_1bit ALU16(result[16], carryBits[17], aluSrc1[16], aluSrc2[16], invertA, invertB, operation, carryBits[16], 1'b0);
  ALU_1bit ALU17(result[17], carryBits[18], aluSrc1[17], aluSrc2[17], invertA, invertB, operation, carryBits[17], 1'b0);
  ALU_1bit ALU18(result[18], carryBits[19], aluSrc1[18], aluSrc2[18], invertA, invertB, operation, carryBits[18], 1'b0);
  ALU_1bit ALU19(result[19], carryBits[20], aluSrc1[19], aluSrc2[19], invertA, invertB, operation, carryBits[19], 1'b0);
  ALU_1bit ALU20(result[20], carryBits[21], aluSrc1[20], aluSrc2[20], invertA, invertB, operation, carryBits[20], 1'b0);
  ALU_1bit ALU21(result[21], carryBits[22], aluSrc1[21], aluSrc2[21], invertA, invertB, operation, carryBits[21], 1'b0);    
  ALU_1bit ALU22(result[22], carryBits[23], aluSrc1[22], aluSrc2[22], invertA, invertB, operation, carryBits[22], 1'b0);  
  ALU_1bit ALU23(result[23], carryBits[24], aluSrc1[23], aluSrc2[23], invertA, invertB, operation, carryBits[23], 1'b0);  
  ALU_1bit ALU24(result[24], carryBits[25], aluSrc1[24], aluSrc2[24], invertA, invertB, operation, carryBits[24], 1'b0);  
  ALU_1bit ALU25(result[25], carryBits[26], aluSrc1[25], aluSrc2[25], invertA, invertB, operation, carryBits[25], 1'b0);
  ALU_1bit ALU26(result[26], carryBits[27], aluSrc1[26], aluSrc2[26], invertA, invertB, operation, carryBits[26], 1'b0);
  ALU_1bit ALU27(result[27], carryBits[28], aluSrc1[27], aluSrc2[27], invertA, invertB, operation, carryBits[27], 1'b0);
  ALU_1bit ALU28(result[28], carryBits[29], aluSrc1[28], aluSrc2[28], invertA, invertB, operation, carryBits[28], 1'b0);
  ALU_1bit ALU29(result[29], carryBits[30], aluSrc1[29], aluSrc2[29], invertA, invertB, operation, carryBits[29], 1'b0);
  ALU_1bit ALU30(result[30], carryBits[31], aluSrc1[30], aluSrc2[30], invertA, invertB, operation, carryBits[30], 1'b0);
  ALU_1bit ALU31(result[31], carryBits[32], aluSrc1[31], aluSrc2[31], invertA, invertB, operation, carryBits[31], 1'b0);

  // sign check
  wire A, B;    
  xor (A, aluSrc1[31], invertA);
  xor (B, aluSrc2[31], invertB);
  assign set = ((A == 1'b1 && B == 1'b1) ||
                (A == 1'b1 && B == 1'b0 && carryBits[31] == 1'b0) ||
                (A == 1'b0 && B == 1'b1 && carryBits[31] == 1'b0)) ? 1'b1 : 1'b0;
  // output zero
  nor (zero, result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15], result[16], result[17], result[18], result[19], result[20], result[21], result[22], result[23], result[24], result[25], result[26], result[27], result[28], result[29], result[30], result[31]);
  // overflow detect
  xor (overflow, carryBits[31], carryBits[32]);
	  
endmodule