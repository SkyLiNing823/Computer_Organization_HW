module ALU_1bit( result, carryOut, a, b, invertA, invertB, operation, carryIn, less ); 
  
  output wire result;
  output wire carryOut;
  
  input wire a;
  input wire b;
  input wire invertA;
  input wire invertB;
  input wire[1:0] operation;
  input wire carryIn;
  input wire less;
  
  /*your code here*/
  wire result0, result1, result2, result3;
  // invert
  wire A, B;
  xor (A, a, invertA);
  xor (B, b, invertB);
  // operation
  or (result0, A, B);
  and (result1, A, B);
  Full_adder full_adder(result2, carryOut, carryIn, A, B);
  assign result3 = less;
  // multiplexor
  assign result = (operation == 2'b00) ?  result0 : 
                  (operation == 2'b01) ?  result1 : 
                  (operation == 2'b10) ?  result2 : 
                                          result3 ;
endmodule