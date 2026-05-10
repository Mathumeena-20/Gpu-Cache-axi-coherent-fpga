`timescale 1ns/1ps

module axi_interconnect #(
    parameter NUM_MASTERS = 4,
    parameter DATA_WIDTH  = 64
)(
    input  logic clk,
    input  logic rst,

    input  logic [NUM_MASTERS-1:0] req_valid,

    output logic [NUM_MASTERS-1:0] grant
);

    arbitration_unit #(
        .NUM_REQS(NUM_MASTERS)
    ) arb (

        .req(req_valid),
        .grant(grant)

    );

endmodule