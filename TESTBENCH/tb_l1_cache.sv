`timescale 1ns/1ps

module tb_l1_cache;

    // =====================================================
    // SIGNALS
    // =====================================================

    logic clk;
    logic rst;

    logic        req_valid;
    logic        req_write;

    logic [31:0] req_addr;

    logic        hit;

    logic [2:0] current_state;

    // =====================================================
    // DUT
    // =====================================================

    l1_cache dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_write(req_write),

        .req_addr(req_addr),

        .hit(hit),

        .current_state(current_state)

    );

    // =====================================================
    // CLOCK
    // =====================================================

    always #5 clk = ~clk;

    // =====================================================
    // TEST
    // =====================================================

    initial begin

        clk = 0;

        rst = 1;

        req_valid = 0;
        req_write = 0;

        req_addr = 0;

        // ================================================
        // RESET
        // ================================================

        #20;
        rst = 0;

        // ================================================
        // TEST1 : READ MISS
        // I -> E
        // ================================================

        @(posedge clk);

        req_valid = 1;
        req_write = 0;

        req_addr = 32'h1000;

        @(posedge clk);

        req_valid = 0;

        #20;

        // ================================================
        // TEST2 : READ HIT
        // E -> S
        // ================================================

        @(posedge clk);

        req_valid = 1;
        req_write = 0;

        req_addr = 32'h1000;

        @(posedge clk);

        req_valid = 0;

        #20;

        // ================================================
        // TEST3 : WRITE HIT
        // S -> M
        // ================================================

        @(posedge clk);

        req_valid = 1;
        req_write = 1;

        req_addr = 32'h1000;

        @(posedge clk);

        req_valid = 0;

        #50;

        $finish;

    end

endmodule