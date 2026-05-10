/*`timescale 1ns/1ps
module tb_axi_ooo;

    logic clk;
    logic rst;

    logic req_valid;
    logic [31:0] req_addr;

    logic arvalid;
    logic [31:0] araddr;
    logic arready;

    axi_master dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),

        .arvalid(arvalid),
        .araddr(araddr),

        .arready(arready)

    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        #20 rst = 0;

        repeat (10) begin

            //req_valid = 1;
            //req_addr  = $random;

            //arready = $random;

            req_valid = 0;
            req_addr  = 0;

            arready = 1;

            #10;

        end

        $finish;

    end

endmodule*/


`timescale 1ns/1ps

module tb_axi_ooo;

    logic clk;
    logic rst;

    logic req_valid;
    logic [31:0] req_addr;

    logic arvalid;
    logic [31:0] araddr;
    logic arready;

    // ==========================================
    // DUT
    // ==========================================

    axi_master dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),

        .arvalid(arvalid),
        .araddr(araddr),

        .arready(arready)

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

        req_valid = 0;
        req_addr  = 0;

        // Slave always ready

        arready = 1;

        #20;

        rst = 0;

        // ======================================
        // GENERATE MULTIPLE REQUESTS
        // ======================================

        repeat (10) begin

            @(posedge clk);

            req_valid = 1;
            req_addr  = $random;

            @(posedge clk);

            req_valid = 0;

            #10;

        end

        #100;

        $finish;

    end

endmodule