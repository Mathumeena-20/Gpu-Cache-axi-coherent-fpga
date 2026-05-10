/*`timescale 1ns/1ps

module l1_cache #(
    parameter LINES = 16
)(

    input  logic        clk,
    input  logic        rst,

    input  logic        req_valid,
    input  logic [31:0] req_addr,

    output logic        hit

);

    // ==========================================
    // CACHE ARRAYS
    // ==========================================

    logic        valid [0:LINES-1];

    logic [31:0] tag   [0:LINES-1];

    logic [3:0] index;

    integer i;

    assign index = req_addr[5:2];

    // ==========================================
    // CACHE LOGIC
    // ==========================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            hit <= 0;

            for (i = 0; i < LINES; i = i + 1) begin

                valid[i] <= 0;
                tag[i]   <= 0;
            end

        end
        else begin

            hit <= 0;

            if (req_valid) begin

                // CACHE HIT

                if (valid[index] &&
                    tag[index] == req_addr) begin

                    hit <= 1;

                end

                // CACHE MISS

                else begin

                    hit <= 0;

                    valid[index] <= 1;
                    tag[index]   <= req_addr;

                end

            end

        end

    end

endmodule*/


/*`timescale 1ns/1ps

module l1_cache #(

    parameter DEPTH = 16

)(

    input  logic        clk,
    input  logic        rst,

    input  logic        req_valid,
    input  logic [31:0] req_addr,

    output logic        hit

);

    // =========================================================
    // MOESI STATES
    // =========================================================

    typedef enum logic [2:0] {

        MOESI_M = 3'b000,
        MOESI_O = 3'b001,
        MOESI_E = 3'b010,
        MOESI_S = 3'b011,
        MOESI_I = 3'b100

    } moesi_state_t;

    // =========================================================
    // CACHE LINE
    // =========================================================

    typedef struct packed {

        logic          valid;
        logic [31:0]   tag;
        moesi_state_t  state;

    } cache_line_t;

    // =========================================================
    // CACHE MEMORY
    // =========================================================

    cache_line_t cache_mem [0:DEPTH-1];

    logic [3:0] index;

    integer i;

    // =========================================================
    // ADDRESS INDEX
    // =========================================================

    assign index = req_addr[5:2];

    // =========================================================
    // CACHE LOGIC
    // =========================================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            hit <= 0;

            for (i = 0; i < DEPTH; i = i + 1) begin

                cache_mem[i].valid <= 0;
                cache_mem[i].tag   <= 0;
                cache_mem[i].state <= MOESI_I;

            end

        end
        else begin

            hit <= 0;

            // =================================================
            // CACHE ACCESS
            // =================================================

            if (req_valid) begin

                // =============================================
                // CACHE HIT
                // =============================================

                if (cache_mem[index].valid &&
                    cache_mem[index].tag == req_addr &&
                    cache_mem[index].state != MOESI_I) begin

                    hit <= 1;

                end

                // =============================================
                // CACHE MISS
                // =============================================

                else begin

                    hit <= 0;

                    cache_mem[index].valid <= 1;
                    cache_mem[index].tag   <= req_addr;

                    // First fill -> Exclusive
                    cache_mem[index].state <= MOESI_E;

                end
            end
        end
    end

endmodule*/


/*`timescale 1ns/1ps

module l1_cache #(

    parameter DEPTH = 16

)(

    input  logic        clk,
    input  logic        rst,

    // =========================================================
    // REQUEST INTERFACE
    // =========================================================

    input  logic        req_valid,
    input  logic        req_write,

    input  logic [31:0] req_addr,

    // =========================================================
    // CACHE RESPONSE
    // =========================================================

    output logic        hit,

    // =========================================================
    // DEBUG SIGNALS
    // =========================================================

    output logic [2:0]  current_state

);

    // =========================================================
    // MOESI STATES
    // =========================================================

    typedef enum logic [2:0] {

        MOESI_M = 3'b000,
        MOESI_O = 3'b001,
        MOESI_E = 3'b010,
        MOESI_S = 3'b011,
        MOESI_I = 3'b100

    } moesi_state_t;

    // =========================================================
    // CACHE LINE
    // =========================================================

    typedef struct packed {

        logic          valid;
        logic [31:0]   tag;
        moesi_state_t  state;

    } cache_line_t;

    // =========================================================
    // CACHE MEMORY
    // =========================================================

    cache_line_t cache_mem [0:DEPTH-1];

    // =========================================================
    // INDEX
    // =========================================================

    logic [3:0] index;

    integer i;

    // =========================================================
    // INDEX CALCULATION
    // =========================================================

    assign index = req_addr[5:2];

    // =========================================================
    // DEBUG STATE OUTPUT
    // =========================================================

    assign current_state = cache_mem[index].state;

    // =========================================================
    // CACHE CONTROLLER
    // =========================================================

    always_ff @(posedge clk or posedge rst) begin

        // =====================================================
        // RESET
        // =====================================================

        if (rst) begin

            hit <= 0;

            for (i = 0; i < DEPTH; i = i + 1) begin

                cache_mem[i].valid <= 0;

                cache_mem[i].tag <= 0;

                cache_mem[i].state <= MOESI_I;

            end

        end

        // =====================================================
        // NORMAL OPERATION
        // =====================================================

        else begin

            hit <= 0;

            // =================================================
            // REQUEST VALID
            // =================================================

            if (req_valid) begin

                // =============================================
                // CACHE HIT
                // =============================================

                if (cache_mem[index].valid &&
                    cache_mem[index].tag == req_addr &&
                    cache_mem[index].state != MOESI_I) begin

                    hit <= 1;

                    // =========================================
                    // WRITE REQUEST
                    // =========================================

                    if (req_write) begin

                        // -------------------------------------
                        // Any write -> MODIFIED
                        // -------------------------------------

                        cache_mem[index].state <= MOESI_M;

                    end

                    // =========================================
                    // READ REQUEST
                    // =========================================

                    else begin

                        case (cache_mem[index].state)

                            // ---------------------------------
                            // EXCLUSIVE -> SHARED
                            // ---------------------------------

                            MOESI_E: begin

                                cache_mem[index].state <= MOESI_S;

                            end

                            // ---------------------------------
                            // SHARED stays SHARED
                            // ---------------------------------

                            MOESI_S: begin

                                cache_mem[index].state <= MOESI_S;

                            end

                            // ---------------------------------
                            // MODIFIED stays MODIFIED
                            // ---------------------------------

                            MOESI_M: begin

                                cache_mem[index].state <= MOESI_M;

                            end

                            // ---------------------------------
                            // OWNED stays OWNED
                            // ---------------------------------

                            MOESI_O: begin

                                cache_mem[index].state <= MOESI_O;

                            end

                            // ---------------------------------
                            // INVALID
                            // ---------------------------------

                            default: begin

                                cache_mem[index].state <= MOESI_I;

                            end

                        endcase

                    end

                end

                // =============================================
                // CACHE MISS
                // =============================================

                else begin

                    hit <= 0;

                    // -----------------------------------------
                    // ALLOCATE NEW LINE
                    // -----------------------------------------

                    cache_mem[index].valid <= 1;

                    cache_mem[index].tag <= req_addr;

                    // -----------------------------------------
                    // WRITE MISS -> MODIFIED
                    // -----------------------------------------

                    if (req_write)

                        cache_mem[index].state <= MOESI_M;

                    // -----------------------------------------
                    // READ MISS -> EXCLUSIVE
                    // -----------------------------------------

                    else

                        cache_mem[index].state <= MOESI_E;

                end
            end
        end
    end

endmodule*/


`timescale 1ns/1ps

module l1_cache #(

    parameter DEPTH = 16

)(

    // =====================================================
    // CLOCK / RESET
    // =====================================================

    input  logic        clk,
    input  logic        rst,

    // =====================================================
    // CORE REQUEST
    // =====================================================

    input  logic        req_valid,
    input  logic        req_write,

    input  logic [31:0] req_addr,

    // =====================================================
    // DIRECTORY INVALIDATION
    // =====================================================

    input  logic        invalidate,

    // =====================================================
    // CACHE RESPONSE
    // =====================================================

    output logic        hit,

    // =====================================================
    // DEBUG STATE OUTPUT
    // =====================================================

    output logic [2:0] current_state

);

    // =====================================================
    // MOESI STATES
    // =====================================================

    localparam MOESI_M = 3'b000;
    localparam MOESI_O = 3'b001;
    localparam MOESI_E = 3'b010;
    localparam MOESI_S = 3'b011;
    localparam MOESI_I = 3'b100;

    // =====================================================
    // CACHE LINE
    // =====================================================

    typedef struct packed {

        logic        valid;

        logic [31:0] tag;

        logic [2:0]  state;

    } cache_line_t;

    // =====================================================
    // CACHE MEMORY
    // =====================================================

    cache_line_t cache_mem [0:DEPTH-1];

    // =====================================================
    // INDEX
    // =====================================================

    logic [3:0] index;

    integer i;

    // =====================================================
    // ADDRESS INDEX
    // =====================================================

    assign index = req_addr[5:2];

    // =====================================================
    // DEBUG OUTPUT
    // =====================================================

    assign current_state = cache_mem[index].state;

    // =====================================================
    // CACHE CONTROLLER
    // =====================================================

    always_ff @(posedge clk or posedge rst) begin

        // =================================================
        // RESET
        // =================================================

        if (rst) begin

            hit <= 0;

            for (i = 0; i < DEPTH; i = i + 1) begin

                cache_mem[i].valid <= 0;

                cache_mem[i].tag <= 0;

                cache_mem[i].state <= MOESI_I;

            end

        end

        // =================================================
        // NORMAL OPERATION
        // =================================================

        else begin

            hit <= 0;

            // =============================================
            // DIRECTORY INVALIDATION
            // =============================================

            if (invalidate) begin

                cache_mem[index].state <= MOESI_I;

                cache_mem[index].valid <= 0;

            end

            // =============================================
            // CACHE REQUEST
            // =============================================

            else if (req_valid) begin

                // =========================================
                // CACHE HIT
                // =========================================

                if (cache_mem[index].valid &&
                    cache_mem[index].tag == req_addr &&
                    cache_mem[index].state != MOESI_I) begin

                    hit <= 1;

                    // =====================================
                    // WRITE REQUEST
                    // =====================================

                    if (req_write) begin

                        // ---------------------------------
                        // Any write -> MODIFIED
                        // ---------------------------------

                        cache_mem[index].state <= MOESI_M;

                    end

                    // =====================================
                    // READ REQUEST
                    // =====================================

                    else begin

                        case (cache_mem[index].state)

                            // -----------------------------
                            // E -> S
                            // -----------------------------

                            MOESI_E: begin

                                cache_mem[index].state
                                    <= MOESI_S;

                            end

                            // -----------------------------
                            // S stays S
                            // -----------------------------

                            MOESI_S: begin

                                cache_mem[index].state
                                    <= MOESI_S;

                            end

                            // -----------------------------
                            // M stays M
                            // -----------------------------

                            MOESI_M: begin

                                cache_mem[index].state
                                    <= MOESI_M;

                            end

                            // -----------------------------
                            // O stays O
                            // -----------------------------

                            MOESI_O: begin

                                cache_mem[index].state
                                    <= MOESI_O;

                            end

                            // -----------------------------
                            // DEFAULT -> I
                            // -----------------------------

                            default: begin

                                cache_mem[index].state
                                    <= MOESI_I;

                            end

                        endcase

                    end

                end

                // =========================================
                // CACHE MISS
                // =========================================

                else begin

                    hit <= 0;

                    // -------------------------------------
                    // ALLOCATE NEW CACHE LINE
                    // -------------------------------------

                    cache_mem[index].valid <= 1;

                    cache_mem[index].tag <= req_addr;

                    // -------------------------------------
                    // WRITE MISS -> MODIFIED
                    // -------------------------------------

                    if (req_write)

                        cache_mem[index].state
                            <= MOESI_M;

                    // -------------------------------------
                    // READ MISS -> EXCLUSIVE
                    // -------------------------------------

                    else

                        cache_mem[index].state
                            <= MOESI_E;

                end
            end
        end
    end

endmodule