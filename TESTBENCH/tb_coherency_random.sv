`timescale 1ns/1ps
module tb_coherency_random;

    logic clk;
    logic rst;

    logic req_valid;
    logic [31:0] req_addr;
    logic [1:0] req_type;
    logic [1:0] req_core;

    logic grant;

    directory_controller dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),
        .req_type(req_type),
        .req_core(req_core),

        .grant(grant),
        .send_invalidate(),
        .invalidate_vector()

    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        #20 rst = 0;

        repeat (100) begin

            req_valid = 1;
            req_addr  = $random %4;
            req_type  = ($random % 2) ? 2'b01 : 2'b10;
            req_core  = $random % 4;

            #10;

        end

        $finish;

    end

endmodule