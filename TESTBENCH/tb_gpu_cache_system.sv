/*`timescale 1ns/1ps

module tb_gpu_cache_system;

    logic clk;
    logic rst;

    // ==========================================
    // DUT
    // ==========================================

    gpu_cache_system_top dut (

        .clk(clk),
        .rst(rst)

    );

    // ==========================================
    // CLOCK
    // ==========================================

    always #5 clk = ~clk;

    // ==========================================
    // TEST
    // ==========================================

    initial begin

        clk = 0;
        rst = 1;

        #20;
        rst = 0;

        #500;

        $finish;

    end

endmodule*/


`timescale 1ns/1ps

module tb_gpu_cache_system;

    logic clk;
    logic rst;

    logic req_valid;
    logic [31:0] req_addr;

    gpu_cache_system_top dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr)

    );

    // CLOCK

    always #5 clk = ~clk;

    // TEST

    initial begin

        clk = 0;
        rst = 1;

        req_valid = 0;
        req_addr  = 0;

        #20;
        rst = 0;

        // REQUEST 1
        req_valid = 1;
        req_addr  = 32'h1000;

        #40;

        // REQUEST 2
        req_addr  = 32'h2000;

        #40;

        // REQUEST 3
        req_addr  = 32'h3000;

        #40;

        // HIT CASE
        req_addr  = 32'h1000;

        #100;

        $finish;

    end

endmodule


