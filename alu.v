module alu(
           input [7:0] A,B,                
           input [1:0] op,
           output [7:0] result,
           output COut 
    );
    reg [7:0] Y;
    assign result = Y; 
    assign COut = CarryOut;
    wire [15:0] mult;
    wire [7:0] Sum;
    wire CarryOut;
    assign mult = A*B;
    adder8bit adder(A, B, 1'b0, Sum, CarryOut); 
    
    always @(*)
    begin
        case(op)
          2'b00: begin // Addition
           Y <= Sum;
          //  if(CarryOut) begin
          //    $display("CarryOut GOT HERE");
          //  end 
          end
          2'b01: // MULT 
           Y <= mult[7:0];
          2'b10: //  AND 
           Y <= A & B;
          2'b11: //  Logical or
           Y <= A | B;
          default: Y = Sum; 
        endcase
    end
endmodule