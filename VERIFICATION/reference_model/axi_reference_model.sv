module axi_reference_model #(
    parameter ID_WIDTH   = 4,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64,
    parameter MAX_OUTSTANDING = 16
)(
    input  logic clk,
    input  logic rst,

    input  logic arvalid,
    input  logic [ID_WIDTH-1:0] arid,
    input  logic [ADDR_WIDTH-1:0] araddr,

    input  logic rvalid,
    input  logic [ID_WIDTH-1:0] rid
);

    // ==========================================
    // Outstanding Tracker
    // ==========================================

    logic [MAX_OUTSTANDING-1:0]
        outstanding_ids;

    integer outstanding_count;

    // ==========================================
    // Track Requests
    // ==========================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            outstanding_ids <= 0;
            outstanding_count <= 0;

        end else begin

            // ------------------------------
            // New Request
            // ------------------------------

            if (arvalid) begin

                outstanding_ids[arid] <= 1;
                outstanding_count <=
                    outstanding_count + 1;

            end

            // ------------------------------
            // Response Completion
            // ------------------------------

            if (rvalid) begin

                outstanding_ids[rid] <= 0;
                outstanding_count <=
                    outstanding_count - 1;

            end
        end
    end

endmodule