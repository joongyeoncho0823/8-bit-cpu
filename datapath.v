
// transfer data from ALU to dmem
module datapath(input [7:0] in, 
              input mux, clk,
              output reg [7:0] out);
    
    always @(*) begin
        if(mux)
            out <= in;
    end

endmodule