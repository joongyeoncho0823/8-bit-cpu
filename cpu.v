`timescale 1ns/1ps

module cpu();

    reg [15:0] instruction;
    reg [7:0] A, B;
    reg [7:0] Rx [7:0];
    reg [1:0] alu_sel;
    reg [3:0] addr, pc;
    reg alu_mux, we, oe, clk;
    wire [15:0] instr;
    wire [7:0] bus;
    wire [3:0] Rn, Rd, Rm, opcode;
    wire COut;
    integer i;

    assign opcode = instruction[15:12];
    assign Rd = instruction[11:8];
    assign Rn = instruction[7:4];
    assign Rm = instruction[3:0];

    wire [7:0] tmp_alu;
    alu aluop(.A(A), .B(B), .result(tmp_alu), .op(alu_sel), .COut(COut));
    datapath dp(.clk(clk), .mux(alu_mux), .in(tmp_alu), .out(bus));
    dmem data(.data(bus), .clk(clk), .we(we), .oe(oe), .addr(addr));
    imem mem(.a(pc), .rd(instr));
    
    always @(posedge clk)
    begin
        case(opcode)
            4'b000:begin      // ADD
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 2'b00;
                alu_mux = 1'b1;
                #10
                Rx[Rd] = bus; 
                alu_mux = 1'b0;
            end
            4'b001:begin      // ADDI
                A <= Rx[Rn];
                B <= Rm;
                alu_sel = 2'b00;
                alu_mux = 1'b1;
                #10
                Rx[Rd] = bus;
                alu_mux = 1'b0;
            end
            4'b010: begin      //AND
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 2'b10;
                alu_mux = 1'b1;
                #10
                Rx[Rd] = bus;
                alu_mux = 1'b0;
            end
            4'b011: begin      //OR
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 2'b11;
                alu_mux = 1'b1;
                #10
                Rx[Rd] = bus;
                alu_mux = 1'b0;
            end
            4'b100:begin      // MULT
                A <= Rx[Rn];
                B <= Rx[Rm];
                alu_sel = 2'b01;
                alu_mux = 1'b1;
                #10
                Rx[Rd] = bus;
                alu_mux = 1'b0;
            end
            4'b101:begin      //Display
                $display("\nRegister Values\n");
                for(i =0; i < 8; i = i+1) begin
                    $display("Rx[%d]: %d",i, Rx[i]);
                end
            end
            4'b110:begin      //STUR 
                addr = Rd;
                A <= 0;
                B <= Rx[Rn];
                alu_sel = 2'b00;
                alu_mux = 1;
                oe = 0;
                we = 1;
                #10
                we = 0;
                alu_mux = 0;
            end
            4'b111:begin      //LDUR
                addr = Rd;
                we = 0;
                oe = 1;
                #10
                Rx[Rn] = bus;
                oe = 0;
            end
            4'b1001: begin
                $finish;    
            end

            default : A = 4'hz; 
        endcase
    end

    always @(negedge clk)
    begin
        pc = pc + 1;
        #10
        instruction = instr;
    end

    always #50 clk = ~clk;

    initial begin
        clk = 0;
        {we, oe, alu_mux, addr} <= 0;
        for(i = 0; i < 8; i = i+1) begin
            Rx[i] = 8'b0;
        end
        i = 0;
        pc = -1;
        #100
        $dumpfile("test.vcd");
        $dumpvars(0, clk, instruction, tmp_alu, Rx[0], Rx[1], Rx[2], Rx[3], Rx[4], Rx[5], Rx[6], Rx[7]);
        //$monitor("%d",Rx[1]);
        
    end
endmodule