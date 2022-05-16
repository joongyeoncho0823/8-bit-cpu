module imem(
        output wire [15:0] rd,
        input [3:0] a);

    reg [15:0] ram [0:31];



    initial $readmemh("test1.txt", ram); 


    assign rd = ram[a];

endmodule