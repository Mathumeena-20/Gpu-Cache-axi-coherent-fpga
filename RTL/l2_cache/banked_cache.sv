module banked_cache #(
    parameter NUM_BANKS = 4,
    parameter DATA_WIDTH = 64
)(
    input  logic clk,
    input  logic rst,

    input  logic [$clog2(NUM_BANKS)-1:0] bank_sel,

    input  logic req_valid,
    input  logic [31:0] req_addr,
    input  logic [DATA_WIDTH-1:0] req_wdata,
    input  logic req_write,

    output logic resp_valid,
    output logic [DATA_WIDTH-1:0] resp_rdata,

    output logic hit
);

    logic [DATA_WIDTH-1:0] bank_mem [NUM_BANKS-1:0][255:0];

    always_ff @(posedge clk) begin

        hit <= 1;

        if (req_write)
            bank_mem[bank_sel][req_addr[9:2]] <= req_wdata;

        resp_rdata <= bank_mem[bank_sel][req_addr[9:2]];

        resp_valid <= req_valid;

    end

endmodule