/*`timescale 1ns/1ps

module mshr #(
    parameter DEPTH = 8
)(
    input  logic        clk,
    input  logic        rst,

    input  logic        miss_valid,
    input  logic [31:0] miss_addr,

    input  logic        mem_resp_valid,
    input  logic [31:0] mem_resp_addr,

    output logic        full
);

    // ==========================================
    // MSHR ENTRY
    // ==========================================

    typedef struct packed {

        logic        valid;
        logic [31:0] addr;

    } mshr_entry_t;

    // ==========================================
    // TABLE
    // ==========================================

    mshr_entry_t entries [0:DEPTH-1];

    integer i;

    logic allocated;

    // ==========================================
    // FULL LOGIC
    // ==========================================

    always_comb begin

        full = 1'b1;

        for (int j = 0; j < DEPTH; j++) begin

            if (!entries[j].valid)
                full = 1'b0;

        end

    end

    // ==========================================
    // MAIN LOGIC
    // ==========================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            for (i = 0; i < DEPTH; i = i + 1) begin

                entries[i].valid <= 0;
                entries[i].addr  <= 0;

            end

        end
        else begin

            // ==================================
            // ALLOCATE ENTRY
            // ==================================

            allocated = 0;

            if (miss_valid && !full) begin

                for (i = 0; i < DEPTH; i = i + 1) begin

                    if (!entries[i].valid && !allocated) begin

                        entries[i].valid <= 1;
                        entries[i].addr  <= miss_addr;

                        allocated = 1;

                    end
                end
            end

            // ==================================
            // FREE ENTRY
            // ==================================

            if (mem_resp_valid) begin

                for (i = 0; i < DEPTH; i = i + 1) begin

                    if (entries[i].valid &&
                        entries[i].addr == mem_resp_addr) begin

                        entries[i].valid <= 0;

                    end
                end
            end

        end
    end

endmodule*/


`timescale 1ns/1ps

module mshr #(

    parameter DEPTH = 8

)(

    input  logic        clk,
    input  logic        rst,

    input  logic        miss_valid,
    input  logic [31:0] miss_addr,

    input  logic        mem_resp_valid,
    input  logic [31:0] mem_resp_addr

);

    // =====================================================
    // MSHR ENTRY
    // =====================================================

    typedef struct packed {

        logic        valid;
        logic [31:0] addr;

    } mshr_entry_t;

    // =====================================================
    // MSHR TABLE
    // =====================================================

    mshr_entry_t entries [0:DEPTH-1];

    integer i;

    logic allocated;

    // =====================================================
    // MSHR LOGIC
    // =====================================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            allocated <= 0;

            for (i = 0; i < DEPTH; i = i + 1) begin

                entries[i].valid <= 0;
                entries[i].addr  <= 0;

            end

        end
        else begin

            allocated <= 0;

            // ============================================
            // ALLOCATE NEW MISS
            // ============================================

            if (miss_valid) begin

                for (i = 0; i < DEPTH; i = i + 1) begin

                    if (!entries[i].valid &&
                        !allocated) begin

                        entries[i].valid <= 1;

                        entries[i].addr <= miss_addr;

                        allocated <= 1;

                    end
                end
            end

            // ============================================
            // DEALLOCATE ON MEMORY RESPONSE
            // ============================================

            if (mem_resp_valid) begin

                for (i = 0; i < DEPTH; i = i + 1) begin

                    if (entries[i].valid &&
                        entries[i].addr ==
                        mem_resp_addr) begin

                        entries[i].valid <= 0;

                    end
                end
            end
        end
    end

endmodule