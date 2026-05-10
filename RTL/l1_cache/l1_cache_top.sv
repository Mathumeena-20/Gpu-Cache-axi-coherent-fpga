/*`timescale 1ns/1ps

module l1_cache_top (

    input  logic        clk,
    input  logic        rst,

    input  logic        req_valid,
    input  logic [31:0] req_addr,
    input  logic [63:0] req_wdata,
    input  logic        req_write,

    output logic        resp_valid,
    output logic [63:0] resp_rdata,

    output logic        mem_req_valid,
    output logic [31:0] mem_req_addr,

    input  logic        mem_resp_valid,
    input  logic [63:0] mem_resp_data
);

    logic hit;

        logic        valid;
    logic [31:0] cached_addr;
    logic [63:0] cached_data;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            resp_valid    <= 0;
            mem_req_valid <= 0;

            valid         <= 0;
            cached_addr   <= 0;
            cached_data   <= 0;

        end
        else begin

            resp_valid    <= 0;
            mem_req_valid <= 0;

            // ==========================================
            // REQUEST
            // ==========================================

            if (req_valid) begin

                // HIT
                if (valid && (req_addr == cached_addr)) begin

                    resp_valid <= 1;
                    resp_rdata <= cached_data;

                end
                // MISS
                else begin

                    mem_req_valid <= 1;
                    mem_req_addr  <= req_addr;

                end
            end

            // ==========================================
            // MEMORY RESPONSE
            // ==========================================

            if (mem_resp_valid) begin

                valid       <= 1;
                cached_addr <= req_addr;
                cached_data <= mem_resp_data;

                resp_valid  <= 1;
                resp_rdata  <= mem_resp_data;

            end
        end
    end
endmodule*/

`timescale 1ns/1ps

module l1_cache_top #(
    parameter NUM_LINES = 4
)(

    input  logic        clk,
    input  logic        rst,

    // =====================================================
    // CPU REQUEST
    // =====================================================

    input  logic        req_valid,
    input  logic [31:0] req_addr,
    input  logic [63:0] req_wdata,
    input  logic        req_write,

    // =====================================================
    // CPU RESPONSE
    // =====================================================

    output logic        resp_valid,
    output logic [63:0] resp_rdata,

    // =====================================================
    // MEMORY REQUEST
    // =====================================================

    output logic        mem_req_valid,
    output logic [31:0] mem_req_addr,

    // =====================================================
    // MEMORY RESPONSE
    // =====================================================

    input  logic        mem_resp_valid,
    input  logic [63:0] mem_resp_data
);

    // =====================================================
    // CACHE ARRAYS
    // =====================================================

    logic                  valid_array [0:NUM_LINES-1];
    logic                  dirty_array [0:NUM_LINES-1];

    logic [26:0]           tag_array   [0:NUM_LINES-1];
    logic [63:0]           data_array  [0:NUM_LINES-1];

    // =====================================================
    // ADDRESS DECODE
    // =====================================================

    logic [1:0]  index;
    logic [26:0] tag;

    assign index = req_addr[4:3];
    assign tag   = req_addr[31:5];

    // =====================================================
    // PENDING MISS TRACKING
    // =====================================================

    logic [31:0] pending_miss_addr;

    logic [1:0]  pending_index;
    logic [26:0] pending_tag;

    assign pending_index = pending_miss_addr[4:3];
    assign pending_tag   = pending_miss_addr[31:5];

    integer i;

    // =====================================================
    // MAIN CACHE LOGIC
    // =====================================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            resp_valid         <= 0;
            resp_rdata         <= 0;

            mem_req_valid      <= 0;
            mem_req_addr       <= 0;

            pending_miss_addr  <= 0;

            // =============================================
            // RESET CACHE ARRAYS
            // =============================================

            for (i = 0; i < NUM_LINES; i = i + 1) begin

                valid_array[i] <= 0;
                dirty_array[i] <= 0;

                tag_array[i]   <= 0;
                data_array[i]  <= 0;

            end
        end
        else begin

            // =============================================
            // DEFAULT OUTPUTS
            // =============================================

            resp_valid    <= 0;
            mem_req_valid <= 0;

            // =============================================
            // CACHE ACCESS
            // =============================================

            if (req_valid) begin

                // =========================================
                // CACHE HIT
                // =========================================

                if (valid_array[index] &&
                    (tag_array[index] == tag)) begin

                    // -------------------------------------
                    // WRITE HIT
                    // -------------------------------------

                    if (req_write) begin

                        data_array[index]  <= req_wdata;
                        dirty_array[index] <= 1;

                        resp_valid <= 1;

                    end

                    // -------------------------------------
                    // READ HIT
                    // -------------------------------------

                    else begin

                        resp_valid <= 1;
                        resp_rdata <= data_array[index];

                    end
                end

                // =========================================
                // CACHE MISS
                // =========================================

                else begin

                    mem_req_valid     <= 1;
                    mem_req_addr      <= req_addr;

                    pending_miss_addr <= req_addr;

                end
            end

            // =============================================
            // MEMORY RESPONSE
            // =============================================

            if (mem_resp_valid) begin

                // Fill cache line

                valid_array[pending_index] <= 1;
                dirty_array[pending_index] <= 0;

                tag_array[pending_index]   <= pending_tag;
                data_array[pending_index]  <= mem_resp_data;

                // Return data to CPU

                resp_valid <= 1;
                resp_rdata <= mem_resp_data;

            end
        end
    end

endmodule