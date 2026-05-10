`timescale 1ns/1ps

module multi_core_gpu_top #(
    parameter NUM_CORES = 4,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64
)(
    input  logic clk,
    input  logic rst
);

    // ==========================================
    // Core ↔ Cache Signals
    // ==========================================

    logic [NUM_CORES-1:0]                    core_req_valid;
    logic [NUM_CORES-1:0][ADDR_WIDTH-1:0]   core_req_addr;
    logic [NUM_CORES-1:0][DATA_WIDTH-1:0]   core_req_wdata;
    logic [NUM_CORES-1:0]                    core_req_write;

    logic [NUM_CORES-1:0]                    core_resp_valid;
    logic [NUM_CORES-1:0][DATA_WIDTH-1:0]   core_resp_rdata;

    // ==========================================
    // L1 ↔ Interconnect
    // ==========================================

    logic [NUM_CORES-1:0]                    l1_req_valid;
    logic [NUM_CORES-1:0][ADDR_WIDTH-1:0]   l1_req_addr;

    logic [NUM_CORES-1:0]                    l1_resp_valid;
    logic [NUM_CORES-1:0][DATA_WIDTH-1:0]   l1_resp_data;

    // ==========================================
    // Generate Core Clusters
    // ==========================================

    genvar i;

    generate
        for (i=0; i<NUM_CORES; i++) begin : CORE_CLUSTER

            cluster_top cluster_i (

                .clk(clk),
                .rst(rst),

                .core_req_valid(core_req_valid[i]),
                .core_req_addr(core_req_addr[i]),
                .core_req_wdata(core_req_wdata[i]),
                .core_req_write(core_req_write[i]),

                .core_resp_valid(core_resp_valid[i]),
                .core_resp_rdata(core_resp_rdata[i]),

                .l1_req_valid(l1_req_valid[i]),
                .l1_req_addr(l1_req_addr[i]),

                .l1_resp_valid(l1_resp_valid[i]),
                .l1_resp_data(l1_resp_data[i])

            );

        end
    endgenerate

    // ==========================================
    // Shared AXI/NoC Interconnect
    // ==========================================

    soc_top_axi #(
        .NUM_CORES(NUM_CORES)
    ) soc_interconnect (

        .clk(clk),
        .rst(rst),

        .req_valid(l1_req_valid),
        .req_addr(l1_req_addr),

        .resp_valid(l1_resp_valid),
        .resp_data(l1_resp_data)

    );

endmodule