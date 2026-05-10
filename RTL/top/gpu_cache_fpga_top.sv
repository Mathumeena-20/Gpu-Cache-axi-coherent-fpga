`timescale 1ns/1ps

module gpu_cache_fpga_top(

    input  logic clk,
    input  logic rst,

    output logic [7:0] led

);

    // ==========================================
    // PARAMETERS
    // ==========================================

    parameter NUM_CORES  = 4;
    parameter ADDR_WIDTH = 32;
    parameter DATA_WIDTH = 64;

    // ==========================================
    // INTERNAL SIGNALS
    // ==========================================

    logic [NUM_CORES-1:0]                  req_valid;
    logic [NUM_CORES-1:0][ADDR_WIDTH-1:0] req_addr;

    logic [NUM_CORES-1:0]                  resp_valid;
    logic [NUM_CORES-1:0][DATA_WIDTH-1:0] resp_data;

    // ==========================================
    // RETAINED COUNTER LOGIC
    // ==========================================

    (* keep = "true" *) logic [31:0] counter;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            counter <= 32'd0;

        else
            counter <= counter + 1'b1;

    end

    // ==========================================
    // CONNECT COUNTER TO FPGA OUTPUT
    // ==========================================

    assign led = counter[31:24];

    // ==========================================
    // SIMPLE TRAFFIC GENERATOR
    // ==========================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            req_valid <= '0;
            req_addr  <= '0;

        end
        else begin

            // Core0
            req_valid[0] <= 1'b1;
            req_addr[0]  <= 32'h1000;

            // Core1
            req_valid[1] <= 1'b1;
            req_addr[1]  <= 32'h2000;

            // Core2
            req_valid[2] <= 1'b1;
            req_addr[2]  <= 32'h3000;

            // Core3
            req_valid[3] <= 1'b1;
            req_addr[3]  <= 32'h4000;

        end
    end

    // ==========================================
    // DUT
    // ==========================================

    gpu_cache_system_top dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),

        .resp_valid(resp_valid),
        .resp_data(resp_data)

    );

endmodule