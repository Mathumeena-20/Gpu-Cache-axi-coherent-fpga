module tb_dram_controller;

    logic clk;
    logic rst;

    logic req_valid;
    logic [31:0] req_addr;
    logic [63:0] req_wdata;
    logic req_write;

    logic resp_valid;
    logic [63:0] resp_rdata;

    dram_controller dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),
        .req_wdata(req_wdata),
        .req_write(req_write),

        .resp_valid(resp_valid),
        .resp_rdata(resp_rdata)

    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        #20 rst = 0;

        // Write
        req_valid = 1;
        req_write = 1;
        req_addr  = 32'h1000;
        req_wdata = 64'hCAFEBABE;

        #20;

        // Read
        req_write = 0;

        #50;

        $finish;

    end

endmodule