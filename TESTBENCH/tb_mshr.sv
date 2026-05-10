`timescale 1ns/1ps
module tb_mshr;

    logic clk;
    logic rst;

    logic miss_valid;
    logic [31:0] miss_addr;

    logic mem_resp_valid;
    logic [31:0] mem_resp_addr;

    mshr dut (

        .clk(clk),
        .rst(rst),

        .miss_valid(miss_valid),
        .miss_addr(miss_addr),

        .mem_resp_valid(mem_resp_valid),
        .mem_resp_addr(mem_resp_addr)

    );

    always #5 clk = ~clk;

    initial begin

            // ==========================================
    // RESET
    // ==========================================

    rst = 1;

    miss_valid     = 0;
    mem_resp_valid = 0;

    #20;

    rst = 0;

    // ==========================================
    // MULTIPLE OUTSTANDING MISSES
    // ==========================================

    // MISS 1

    #10;

    miss_valid = 1;
    miss_addr  = 32'h1000;

    #10;

    // MISS 2

    miss_addr  = 32'h2000;

    #10;

    // MISS 3

    miss_addr  = 32'h3000;

    #10;

    miss_valid = 0;

    // ==========================================
    // OUT-OF-ORDER RESPONSES
    // ==========================================

    #20;

    mem_resp_valid = 1;

    // Response for MISS 2 first

    mem_resp_addr = 32'h2000;

    #10;

    // Response for MISS 1

    mem_resp_addr = 32'h1000;

    #10;

    // Response for MISS 3

    mem_resp_addr = 32'h3000;

    #10;

    mem_resp_valid = 0;

    #100;

    $finish;

    end

endmodule