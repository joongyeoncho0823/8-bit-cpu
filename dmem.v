`timescale 1ns/1ps

module dmem(
        inout [7:0] data,
        input [3:0] addr,
        input we, clk, oe  
        );

    reg [7:0] ram [7:0];

    reg [7:0] tmp;
    integer i;
    always @ (posedge clk)
    begin
        if(we) begin
            ram[addr] <= data;
            #1
            $display("Checking if STUR works...");
            $display("this is ram[addr]: %d", ram[addr]);

        end
        else
            tmp <= data;
            #1
            $display("Checking if databus is working...");
            $display("this is tmp: %d", tmp);


    end
    assign data = oe & !we ? tmp : 'hz;

endmodule