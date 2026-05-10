/*`timescale 1ns/1ps

module gpu_cache_system_top #(

    parameter NUM_CORES  = 4,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64

)(

    input logic clk,
    input logic rst,

    // REQUEST FROM TESTBENCH / CORE
    input logic req_valid,
    input logic [31:0] req_addr

);

    // ==========================================
    // L1 CACHE SIGNALS
    // ==========================================

    logic l1_hit;

    logic miss_valid_internal;
    logic [31:0] miss_addr_internal;

    // ==========================================
    // DIRECTORY SIGNALS
    // ==========================================

    logic grant;

    logic send_invalidate;
    logic [NUM_CORES-1:0] invalidate_vector;

    // ==========================================
    // AXI SIGNALS
    // ==========================================

    logic        arvalid;
    logic [31:0] araddr;
    logic        arready;

    logic        rvalid;
    logic [63:0] rdata;

    // ==========================================
    // L1 CACHE
    // ==========================================

    l1_cache l1 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),

        .hit(l1_hit)

    );

    // ==========================================
    // CACHE MISS DETECTION
    // ==========================================

    always_comb begin

        miss_valid_internal = 0;
        miss_addr_internal  = 0;

        if (req_valid && !l1_hit) begin

            miss_valid_internal = 1;
            miss_addr_internal  = req_addr;

        end

    end

    // ==========================================
    // DIRECTORY CONTROLLER
    // ==========================================

    directory_controller #(
        .NUM_CORES(NUM_CORES)
    ) directory (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),
        .req_addr(miss_addr_internal),

        .req_type(2'b01),
        .req_core(2'b00),

        .grant(grant),

        .send_invalidate(send_invalidate),
        .invalidate_vector(invalidate_vector)

    );

    // ==========================================
    // MSHR
    // ==========================================

    mshr #(
        .DEPTH(8)
    ) miss_queue (

        .clk(clk),
        .rst(rst),

        .miss_valid(miss_valid_internal),
        .miss_addr(miss_addr_internal),

        .mem_resp_valid(rvalid),
        .mem_resp_addr(araddr)

    );

    // ==========================================
    // AXI MASTER
    // ==========================================

    axi_master axi (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),
        .req_addr(miss_addr_internal),

        .arvalid(arvalid),
        .araddr(araddr),

        .arready(arready)

    );

    // ==========================================
    // AXI MEMORY
    // ==========================================

    axi_memory dram (

        .clk(clk),
        .rst(rst),

        .arvalid(arvalid),
        .araddr(araddr),

        .arready(arready),

        .rvalid(rvalid),
        .rdata(rdata)

    );

endmodule*/


/*`timescale 1ns/1ps

module gpu_cache_system_top #(

    parameter NUM_CORES  = 4,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64

)(

    input logic clk,
    input logic rst,

    // REQUEST FROM TESTBENCH / CORE
    input logic req_valid,
    input logic [31:0] req_addr

);

    // ==========================================
    // L1 CACHE SIGNALS
    // ==========================================

    logic l1_hit;

    logic miss_valid_internal;
    logic [31:0] miss_addr_internal;

    // ==========================================
    // DIRECTORY SIGNALS
    // ==========================================

    logic grant;

    logic send_invalidate;
    logic [NUM_CORES-1:0] invalidate_vector;

    // ==========================================
    // AXI SIGNALS
    // ==========================================

    logic        arvalid;
    logic [31:0] araddr;
    logic        arready;

    logic        rvalid;
    logic [63:0] rdata;

    // ==========================================
    // L1 CACHE
    // ==========================================

    l1_cache l1 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),

        .hit(l1_hit)

    );

    // ==========================================
    // CACHE MISS DETECTION
    // ==========================================

    always_comb begin

        miss_valid_internal = 0;
        miss_addr_internal  = 0;

        if (req_valid && !l1_hit) begin

            miss_valid_internal = 1;
            miss_addr_internal  = req_addr;

        end

    end

    // ==========================================
    // DIRECTORY CONTROLLER
    // ==========================================

    directory_controller #(
        .NUM_CORES(NUM_CORES)
    ) directory (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),
        .req_addr(miss_addr_internal),

        .req_type(2'b01),
        .req_core(2'b00),

        .grant(grant),

        .send_invalidate(send_invalidate),
        .invalidate_vector(invalidate_vector)

    );

    // ==========================================
    // MSHR
    // ==========================================

    mshr #(
        .DEPTH(8)
    ) miss_queue (

        .clk(clk),
        .rst(rst),

        .miss_valid(miss_valid_internal),
        .miss_addr(miss_addr_internal),

        .mem_resp_valid(rvalid),
        .mem_resp_addr(araddr)

    );

    // ==========================================
    // AXI MASTER
    // ==========================================

    axi_master axi (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),
        .req_addr(miss_addr_internal),

        .arvalid(arvalid),
        .araddr(araddr),

        .arready(arready)

    );

    // ==========================================
    // AXI MEMORY
    // ==========================================

    axi_memory dram (

        .clk(clk),
        .rst(rst),

        .arvalid(arvalid),
        .araddr(araddr),

        .arready(arready),

        .rvalid(rvalid),
        .rdata(rdata)

    );

endmodule*/


/*`timescale 1ns/1ps

module gpu_cache_system_top #(

    parameter NUM_CORES  = 4,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64

)(

    input logic clk,
    input logic rst

);

    // =========================================================
    // CORE REQUEST INTERFACE
    // =========================================================

    logic [NUM_CORES-1:0]                    req_valid;
    logic [NUM_CORES-1:0][ADDR_WIDTH-1:0]   req_addr;

    logic [NUM_CORES-1:0]                    resp_valid;
    logic [NUM_CORES-1:0][DATA_WIDTH-1:0]   resp_data;

    // =========================================================
    // L1 CACHE SIGNALS
    // =========================================================

    logic [NUM_CORES-1:0] l1_hit;

    // =========================================================
    // MISS DETECTION SIGNALS
    // =========================================================

    logic        miss_valid_internal;
    logic [31:0] miss_addr_internal;

    // =========================================================
    // DIRECTORY SIGNALS
    // =========================================================

    logic grant;

    logic send_invalidate;

    logic [NUM_CORES-1:0] invalidate_vector;

    // =========================================================
    // AXI SIGNALS
    // =========================================================

    logic        arvalid;
    logic [31:0] araddr;
    logic        arready;

    logic        rvalid;
    logic [63:0] rdata;

    // =========================================================
    // LOOP VARIABLE
    // =========================================================

    integer i;

    // =========================================================
    // SIMPLE MULTI-CORE TRAFFIC GENERATION
    // =========================================================

    always_comb begin

        // -----------------------------------------
        // CORE0
        // -----------------------------------------

        req_valid[0] = 1'b1;
        req_addr[0]  = 32'h1000;

        // -----------------------------------------
        // CORE1
        // -----------------------------------------

        req_valid[1] = 1'b1;
        req_addr[1]  = 32'h2000;

        // -----------------------------------------
        // CORE2
        // -----------------------------------------

        req_valid[2] = 1'b1;
        req_addr[2]  = 32'h3000;

        // -----------------------------------------
        // CORE3
        // -----------------------------------------

        req_valid[3] = 1'b1;
        req_addr[3]  = 32'h4000;

    end

    // =========================================================
    // L1 CACHE ARRAY
    // =========================================================

    l1_cache l1 [NUM_CORES-1:0] (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),

        .hit(l1_hit)

    );

    // =========================================================
    // MULTI-CORE MISS DETECTION
    // =========================================================

    always_comb begin

        miss_valid_internal = 0;
        miss_addr_internal  = 0;

        for (i = 0; i < NUM_CORES; i = i + 1) begin

            if (req_valid[i] && !l1_hit[i]) begin

                miss_valid_internal = 1;
                miss_addr_internal  = req_addr[i];

            end
        end
    end

    // =========================================================
    // DIRECTORY CONTROLLER
    // =========================================================

    directory_controller #(
        .NUM_CORES(NUM_CORES)
    ) directory (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),
        .req_addr(miss_addr_internal),

        .req_type(2'b01),
        .req_core(2'b00),

        .grant(grant),

        .send_invalidate(send_invalidate),
        .invalidate_vector(invalidate_vector)

    );

    // =========================================================
    // MSHR
    // =========================================================

    mshr #(
        .DEPTH(8)
    ) miss_queue (

        .clk(clk),
        .rst(rst),

        .miss_valid(miss_valid_internal),
        .miss_addr(miss_addr_internal),

        .mem_resp_valid(rvalid),
        .mem_resp_addr(araddr),

        .full()

    );

    // =========================================================
    // AXI MASTER
    // =========================================================

    axi_master axi (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),
        .req_addr(miss_addr_internal),

        .arvalid(arvalid),
        .araddr(araddr),

        .arready(arready)

    );

    // =========================================================
    // AXI MEMORY
    // =========================================================

    axi_memory dram (

        .clk(clk),
        .rst(rst),

        .arvalid(arvalid),
        .araddr(araddr),

        .arready(arready),

        .rvalid(rvalid),
        .rdata(rdata)

    );

endmodule*/


/*`timescale 1ns/1ps

module gpu_cache_system_top #(

    parameter NUM_CORES  = 4,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64

)(

    input logic clk,
    input logic rst

);

    // =========================================================
    // CORE REQUESTS
    // =========================================================

    logic [NUM_CORES-1:0]                    req_valid;
    logic [NUM_CORES-1:0]                    req_write;

    logic [NUM_CORES-1:0][ADDR_WIDTH-1:0]   req_addr;

    // =========================================================
    // CACHE HIT SIGNALS
    // =========================================================

    logic [NUM_CORES-1:0] hit;

    // =========================================================
    // MOESI STATES
    // =========================================================

    logic [2:0] state0;
    logic [2:0] state1;
    logic [2:0] state2;
    logic [2:0] state3;

    // =========================================================
    // MISS DETECTION
    // =========================================================

    logic        miss_valid_internal;
    logic [31:0] miss_addr_internal;

    // =========================================================
    // DIRECTORY SIGNALS
    // =========================================================

    logic grant;

    logic send_invalidate;

    logic [NUM_CORES-1:0] invalidate_vector;

    // =========================================================
    // AXI SIGNALS
    // =========================================================

    logic        arvalid;
    logic [31:0] araddr;
    logic        arready;

    logic        rvalid;
    logic [63:0] rdata;

    // =========================================================
    // LOOP VARIABLE
    // =========================================================

    integer i;

    // =========================================================
    // MULTI-CORE TRAFFIC
    // =========================================================

    always_comb begin

        // ======================================
        // CORE0 READ
        // ======================================

        req_valid[0] = 1'b1;
        req_write[0] = 1'b0;

        req_addr[0]  = 32'h1000;

        // ======================================
        // CORE1 READ SAME LINE
        // ======================================

        req_valid[1] = 1'b1;
        req_write[1] = 1'b0;

        req_addr[1]  = 32'h1000;

        // ======================================
        // CORE2 WRITE SAME LINE
        // ======================================

        req_valid[2] = 1'b1;
        req_write[2] = 1'b1;

        req_addr[2]  = 32'h1000;

        // ======================================
        // CORE3 DIFFERENT LINE
        // ======================================

        req_valid[3] = 1'b1;
        req_write[3] = 1'b0;

        req_addr[3]  = 32'h4000;

    end

    // =========================================================
    // CORE0 L1 CACHE
    // =========================================================

    l1_cache l1_core0 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid[0]),
        .req_write(req_write[0]),

        .req_addr(req_addr[0]),

        .invalidate(send_invalidate &&
                    invalidate_vector[0]),

        .hit(hit[0]),

        .current_state(state0)

    );

    // =========================================================
    // CORE1 L1 CACHE
    // =========================================================

    l1_cache l1_core1 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid[1]),
        .req_write(req_write[1]),

        .req_addr(req_addr[1]),

        .invalidate(send_invalidate &&
                    invalidate_vector[1]),

        .hit(hit[1]),

        .current_state(state1)

    );

    // =========================================================
    // CORE2 L1 CACHE
    // =========================================================

    l1_cache l1_core2 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid[2]),
        .req_write(req_write[2]),

        .req_addr(req_addr[2]),

        .invalidate(send_invalidate &&
                    invalidate_vector[2]),

        .hit(hit[2]),

        .current_state(state2)

    );

    // =========================================================
    // CORE3 L1 CACHE
    // =========================================================

    l1_cache l1_core3 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid[3]),
        .req_write(req_write[3]),

        .req_addr(req_addr[3]),

        .invalidate(send_invalidate &&
                    invalidate_vector[3]),

        .hit(hit[3]),

        .current_state(state3)

    );

    // =========================================================
    // MULTI-CORE MISS DETECTION
    // =========================================================

    always_comb begin

        miss_valid_internal = 0;
        miss_addr_internal  = 0;

        for (i = 0; i < NUM_CORES; i = i + 1) begin

            if (req_valid[i] && !hit[i]) begin

                miss_valid_internal = 1;

                miss_addr_internal = req_addr[i];

            end
        end
    end

    // =========================================================
    // DIRECTORY CONTROLLER
    // =========================================================

    directory_controller #(
        .NUM_CORES(NUM_CORES)
    ) directory (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),

        .req_addr(miss_addr_internal),

        .req_type(2'b01),

        .req_core(2'b00),

        .grant(grant),

        .send_invalidate(send_invalidate),

        .invalidate_vector(invalidate_vector)

    );

    // =========================================================
    // MSHR
    // =========================================================

    mshr #(
        .DEPTH(8)
    ) miss_queue (

        .clk(clk),
        .rst(rst),

        .miss_valid(miss_valid_internal),

        .miss_addr(miss_addr_internal),

        .mem_resp_valid(rvalid),

        .mem_resp_addr(araddr)

    );

    // =========================================================
    // AXI MASTER
    // =========================================================

    axi_master axi (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),

        .req_addr(miss_addr_internal),

        .arvalid(arvalid),

        .araddr(araddr),

        .arready(arready)

    );

    // =========================================================
    // AXI MEMORY
    // =========================================================

    axi_memory dram (

        .clk(clk),
        .rst(rst),

        .arvalid(arvalid),

        .araddr(araddr),

        .arready(arready),

        .rvalid(rvalid),

        .rdata(rdata)

    );

endmodule*/


`timescale 1ns/1ps

module gpu_cache_system_top #(

    parameter NUM_CORES  = 4,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64

)(

    input logic clk,
    input logic rst,

    // =====================================================
    // EXTERNAL CORE REQUESTS
    // =====================================================

    input  logic [NUM_CORES-1:0]                   req_valid,
    input  logic [NUM_CORES-1:0][ADDR_WIDTH-1:0]  req_addr,

    // =====================================================
    // RESPONSE
    // =====================================================

    output logic [NUM_CORES-1:0]                   resp_valid,
    output logic [NUM_CORES-1:0][DATA_WIDTH-1:0]  resp_data

);

    // =====================================================
    // INTERNAL SIGNALS
    // =====================================================

    logic [NUM_CORES-1:0] hit;

    logic [2:0] state0;
    logic [2:0] state1;
    logic [2:0] state2;
    logic [2:0] state3;

    // =====================================================
    // MISS DETECTION
    // =====================================================

    logic        miss_valid_internal;
    logic [31:0] miss_addr_internal;

    // =====================================================
    // DIRECTORY
    // =====================================================

    logic grant;

    logic send_invalidate;

    logic [NUM_CORES-1:0] invalidate_vector;

    // =====================================================
    // AXI
    // =====================================================

    logic        arvalid;
    logic [31:0] araddr;
    logic        arready;

    logic        rvalid;
    logic [63:0] rdata;

    // =====================================================
    // LOOP VARIABLES
    // =====================================================

    integer miss_i;
    integer resp_i;

    // =====================================================
    // CORE0 CACHE
    // =====================================================

    l1_cache l1_core0 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid[0]),
        .req_write(1'b0),

        .req_addr(req_addr[0]),

        .invalidate(send_invalidate &&
                    invalidate_vector[0]),

        .hit(hit[0]),

        .current_state(state0)

    );

    // =====================================================
    // CORE1 CACHE
    // =====================================================

    l1_cache l1_core1 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid[1]),
        .req_write(1'b0),

        .req_addr(req_addr[1]),

        .invalidate(send_invalidate &&
                    invalidate_vector[1]),

        .hit(hit[1]),

        .current_state(state1)

    );

    // =====================================================
    // CORE2 CACHE
    // =====================================================

    l1_cache l1_core2 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid[2]),
        .req_write(1'b1),

        .req_addr(req_addr[2]),

        .invalidate(send_invalidate &&
                    invalidate_vector[2]),

        .hit(hit[2]),

        .current_state(state2)

    );

    // =====================================================
    // CORE3 CACHE
    // =====================================================

    l1_cache l1_core3 (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid[3]),
        .req_write(1'b0),

        .req_addr(req_addr[3]),

        .invalidate(send_invalidate &&
                    invalidate_vector[3]),

        .hit(hit[3]),

        .current_state(state3)

    );

    // =====================================================
    // MISS DETECTION
    // =====================================================

    always_comb begin

        miss_valid_internal = 0;

        miss_addr_internal  = 0;

        for (miss_i = 0;
             miss_i < NUM_CORES;
             miss_i = miss_i + 1) begin

            if (req_valid[miss_i] &&
                !hit[miss_i]) begin

                miss_valid_internal = 1;

                miss_addr_internal =
                    req_addr[miss_i];

            end
        end
    end

    // =====================================================
    // DIRECTORY CONTROLLER
    // =====================================================

    directory_controller #(
        .NUM_CORES(NUM_CORES)
    ) directory (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),

        .req_addr(miss_addr_internal),

        .req_type(2'b01),

        .req_core(2'b00),

        .grant(grant),

        .send_invalidate(send_invalidate),

        .invalidate_vector(invalidate_vector)

    );

    // =====================================================
    // MSHR
    // =====================================================

    mshr #(
        .DEPTH(8)
    ) miss_queue (

        .clk(clk),
        .rst(rst),

        .miss_valid(miss_valid_internal),

        .miss_addr(miss_addr_internal),

        .mem_resp_valid(rvalid),

        .mem_resp_addr(araddr)

    );

    // =====================================================
    // AXI MASTER
    // =====================================================

    axi_master axi (

        .clk(clk),
        .rst(rst),

        .req_valid(miss_valid_internal),

        .req_addr(miss_addr_internal),

        .arvalid(arvalid),

        .araddr(araddr),

        .arready(arready)

    );

    // =====================================================
    // AXI MEMORY
    // =====================================================

    axi_memory dram (

        .clk(clk),
        .rst(rst),

        .arvalid(arvalid),

        .araddr(araddr),

        .arready(arready),

        .rvalid(rvalid),

        .rdata(rdata)

    );

    // =====================================================
    // RESPONSE MODEL
    // =====================================================

    always_comb begin

        for (resp_i = 0;
             resp_i < NUM_CORES;
             resp_i = resp_i + 1) begin

            resp_valid[resp_i] =
                hit[resp_i];

            if (hit[resp_i])

                resp_data[resp_i] =
                    64'hDEADBEEF;

            else

                resp_data[resp_i] =
                    64'h0;

        end
    end

endmodule