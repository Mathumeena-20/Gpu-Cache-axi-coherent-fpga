module tb_noc_router;

    logic clk;
    logic rst;

    logic valid_in;
    logic [63:0] packet_in;

    logic valid_out;
    logic [63:0] packet_out;

    noc_router dut (

        .clk(clk),
        .rst(rst),

        .valid_in(valid_in),
        .packet_in(packet_in),

        .valid_out(valid_out),
        .packet_out(packet_out)

    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        #20 rst = 0;

        valid_in = 1;
        packet_in = 64'hDEADBEEF12345678;

        #100;

        $finish;

    end

endmodule