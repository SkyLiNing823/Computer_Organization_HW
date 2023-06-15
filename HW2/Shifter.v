module Shifter( result, leftRight, shamt, sftSrc );
    
  output wire[31:0] result;

  input wire leftRight;
  input wire[4:0] shamt;
  input wire[31:0] sftSrc ;
  
  /*your code here*/ 
  assign result = (leftRight == 1'b0) ? {1'b0, sftSrc[31:1]} : {sftSrc[30:0], 1'b0};

endmodule