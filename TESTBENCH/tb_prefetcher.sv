module tb_prefetcher;

    logic clk;
    logic rst;

    logic access_valid;
    logic [31:0] access_addr;

    logic prefetch_valid;
    logic [31:0] prefetch_addr;

    stride_prefetcher dut (

        .clk(clk),
        .rst(rst),

        .access_valid(access_valid),
        .access_addr(access_addr),

        .prefetch_valid(prefetch_valid),
        .prefetch_addr(prefetch_addr)

    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        #20 rst = 0;

        repeat (10) begin

            access_valid = 1;
            access_addr  = access_addr + 64;

            #10;

        end

        $finish;

    end

endmodule