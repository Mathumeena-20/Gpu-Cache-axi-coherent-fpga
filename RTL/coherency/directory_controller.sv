/*`timescale 1ns/1ps

module directory_controller #(
    parameter NUM_CORES = 4,
    parameter DEPTH = 256
)(
    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic [31:0] req_addr,
    input  logic [1:0] req_type,
    input  logic [$clog2(NUM_CORES)-1:0] req_core,

    output logic grant,
    output logic send_invalidate,
    output logic [NUM_CORES-1:0] invalidate_vector
);

    typedef struct packed {

        logic valid;
        logic [NUM_CORES-1:0] sharers;
        logic [$clog2(NUM_CORES)-1:0] owner;

    } dir_entry_t;

    dir_entry_t dir_mem [DEPTH-1:0];

    logic [7:0] index;

    assign index = req_addr[9:2];

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            grant <= 0;
        end else begin

            grant <= req_valid;

            if (req_type == 2'b01) begin

                send_invalidate <= 1;
                invalidate_vector <= dir_mem[index].sharers;

                dir_mem[index].owner <= req_core;
                dir_mem[index].sharers <= (1 << req_core);

            end
        end
    end

endmodule*/



/*`timescale 1ns/1ps

module directory_controller #(
    parameter NUM_CORES = 4,
    parameter DEPTH     = 256
)(
    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic [31:0] req_addr,

    // 01 = READ
    // 10 = WRITE
    input  logic [1:0] req_type,

    input  logic [$clog2(NUM_CORES)-1:0] req_core,

    output logic grant,

    output logic send_invalidate,
    output logic [NUM_CORES-1:0] invalidate_vector
);

    // ==========================================
    // MESI STATES
    // ==========================================

    localparam INVALID  = 2'b00;
    localparam SHARED   = 2'b01;
    localparam MODIFIED = 2'b10;

    // ==========================================
    // DIRECTORY ENTRY
    // ==========================================

    typedef struct packed {

        logic valid;

        logic [1:0] state;

        logic [3:0] sharer_vector;

        logic [NUM_CORES-1:0] sharers;

        logic [$clog2(NUM_CORES)-1:0] owner;

    } dir_entry_t;

    // ==========================================
    // DIRECTORY MEMORY
    // ==========================================

    dir_entry_t dir_mem [DEPTH-1:0];

    logic [7:0] index;

    assign index = req_addr[9:2];

    integer i;

    // ==========================================
    // DIRECTORY LOGIC
    // ==========================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            grant <= 0;

            send_invalidate <= 0;
            invalidate_vector <= 0;

            // Reset directory

            for (i = 0; i < DEPTH; i = i + 1) begin

                dir_mem[i].valid   <= 0;
                dir_mem[i].state   <= INVALID;
                dir_mem[i].sharers <= 0;
                dir_mem[i].owner   <= 0;

            end

        end
        else begin

            // Default outputs

            grant <= 0;

            send_invalidate <= 0;
            invalidate_vector <= 0;

            // ==================================
            // HANDLE REQUEST
            // ==================================

            if (req_valid) begin

                grant <= 1;

                // ==================================
                // READ REQUEST
                // ==================================

                if (req_type == 2'b01) begin

                    // First access

                    if (!dir_mem[index].valid) begin

                        dir_mem[index].valid <= 1;

                        dir_mem[index].state <= SHARED;

                        dir_mem[index].sharers[req_core] <= 1'b1;

                        dir_mem[index].owner <= req_core;

                    end
                    else begin

                        // Add sharer

                        dir_mem[index].state <= SHARED;

                        dir_mem[index].sharers[req_core] <= 1'b1;

                    end
                end

                // ==================================
                // WRITE REQUEST
                // ==================================

                else if (req_type == 2'b10) begin

                    // Invalidate all others

                    send_invalidate <= 1;

                    invalidate_vector <=
                        dir_mem[index].sharers &
                        ~(1 << req_core);

                    // Become exclusive owner

                    dir_mem[index].valid <= 1;

                    dir_mem[index].state <= MODIFIED;

                    dir_mem[index].owner <= req_core;

                    dir_mem[index].sharers <= (1 << req_core);

                end
            end
        end
    end

endmodule*/


`timescale 1ns/1ps

module directory_controller #(
    parameter NUM_CORES = 4,
    parameter DEPTH     = 256
)(
    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic [31:0] req_addr,

    // 01 = READ
    // 10 = WRITE
    input  logic [1:0] req_type,

    input  logic [$clog2(NUM_CORES)-1:0] req_core,

    output logic grant,

    output logic send_invalidate,
    output logic [NUM_CORES-1:0] invalidate_vector
);

    // ==========================================
    // MOESI STATES
    // ==========================================

    localparam INVALID  = 3'b000;
    localparam SHARED   = 3'b001;
    localparam EXCLUSIVE= 3'b010;
    localparam OWNED    = 3'b011;
    localparam MODIFIED = 3'b100;

    // ==========================================
    // DIRECTORY ENTRY
    // ==========================================

    typedef struct packed {

        logic valid;

        logic [2:0] state;

        logic [NUM_CORES-1:0] sharers;

        logic [$clog2(NUM_CORES)-1:0] owner;

    } dir_entry_t;

    // ==========================================
    // DIRECTORY MEMORY
    // ==========================================

    dir_entry_t dir_mem [0:DEPTH-1];

    logic [7:0] index;

    integer i;

    assign index = req_addr[9:2];

    // ==========================================
    // DIRECTORY LOGIC
    // ==========================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            grant <= 0;

            send_invalidate <= 0;
            invalidate_vector <= 0;

            // Reset all entries

            for (i = 0; i < DEPTH; i = i + 1) begin

                dir_mem[i].valid   <= 0;
                dir_mem[i].state   <= INVALID;
                dir_mem[i].sharers <= 0;
                dir_mem[i].owner   <= 0;

            end

        end
        else begin

            // Default outputs

            grant <= 0;

            send_invalidate <= 0;
            invalidate_vector <= 0;

            // ==================================
            // REQUEST HANDLING
            // ==================================

            if (req_valid) begin

                grant <= 1;

                // ==================================
                // READ REQUEST
                // ==================================

                if (req_type == 2'b01) begin

                    // Cache line not present

                    if (!dir_mem[index].valid) begin

                        dir_mem[index].valid <= 1;

                        dir_mem[index].state <= EXCLUSIVE;

                        dir_mem[index].owner <= req_core;

                        dir_mem[index].sharers <= (1 << req_core);

                    end
                    else begin

                        // Multiple readers

                        dir_mem[index].state <= SHARED;

                        dir_mem[index].sharers[req_core] <= 1'b1;

                    end
                end

                // ==================================
                // WRITE REQUEST
                // ==================================

                else if (req_type == 2'b10) begin

                    // Invalidate other sharers

                    send_invalidate <= 1;

                    invalidate_vector <=
                        dir_mem[index].sharers &
                        ~(1 << req_core);

                    // Become owner

                    dir_mem[index].valid <= 1;

                    dir_mem[index].state <= MODIFIED;

                    dir_mem[index].owner <= req_core;

                    dir_mem[index].sharers <= (1 << req_core);

                end
            end
        end
    end

endmodule