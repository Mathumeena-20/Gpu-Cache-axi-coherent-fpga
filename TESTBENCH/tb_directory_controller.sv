/*`timescale 1ns/1ps

module tb_directory_controller;

    logic clk;
    logic rst;

    logic req_valid;
    logic [31:0] req_addr;
    logic [1:0] req_type;
    logic [1:0] req_core;

    logic grant;

    directory_controller dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),
        .req_type(req_type),
        .req_core(req_core),

        .grant(grant),
        .send_invalidate(),
        .invalidate_vector()

    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst = 1;

        #20 rst = 0;

        req_valid = 1;
        req_addr  = 32'h1000;
        req_type  = 2'b01;
        req_core  = 0;

        #50;

        $finish;

    end

endmodule*/

`timescale 1ns/1ps

module tb_directory_controller;

    // ==========================================
    // SIGNALS
    // ==========================================

    logic clk;
    logic rst;

    logic        req_valid;
    logic [31:0] req_addr;
    logic [1:0]  req_type;
    logic [1:0]  req_core;

    logic grant;

    logic        send_invalidate;
    logic [3:0]  invalidate_vector;


    // ==========================================
    // MANUAL COVERAGE COUNTERS
    // ==========================================

   integer read_count;
   integer write_count;

   integer core0_count;
   integer core1_count;

   integer invalidate_count;

    // ==========================================
    // DIRECTORY CONTROLLER DUT
    // ==========================================

    directory_controller dut (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_addr(req_addr),
        .req_type(req_type),
        .req_core(req_core),

        .grant(grant),

        .send_invalidate(send_invalidate),
        .invalidate_vector(invalidate_vector)

    );

    // ==========================================
    // ASSERTIONS
    // ==========================================

    coherency_sva sva (

        .clk(clk),
        .rst(rst),

        .req_valid(req_valid),
        .req_type(req_type),

        .send_invalidate(send_invalidate),
        .invalidate_vector(invalidate_vector),

        .state(dut.dir_mem[dut.index].state),
        .sharers(dut.dir_mem[dut.index].sharers)

    );



        // ==========================================
       // MANUAL COVERAGE COLLECTION
       // ==========================================

        always @(posedge clk) begin

            if (req_valid) begin

              // READ coverage
               if (req_type == 2'b01)
                   read_count++;

                // WRITE coverage
                if (req_type == 2'b10)
                    write_count++;

                // CORE coverage
                if (req_core == 2'b00)
                    core0_count++;

                if (req_core == 2'b01)
                    core1_count++;

            end

            // INVALIDATION coverage
            if (send_invalidate)
                invalidate_count++;

            end

    



    // ==========================================
    // CLOCK
    // ==========================================

    always #5 clk = ~clk;

    // ==========================================
    // TEST
    // ==========================================

    initial begin

        // --------------------------------------
        // INITIALIZATION
        // --------------------------------------

        clk       = 0;
        rst       = 1;

        req_valid = 0;
        req_addr  = 0;
        req_type  = 0;
        req_core  = 0;

        // --------------------------------------
        // COVERAGE COUNTER RESET
        // --------------------------------------

        read_count       = 0;
        write_count      = 0;

        core0_count      = 0;
        core1_count      = 0;

        invalidate_count = 0;

        // --------------------------------------
        // RESET
        // --------------------------------------

        #20;
        rst = 0;

        // ======================================
        // TEST 1 : CORE0 READ MISS
        // INVALID -> SHARED
        // ======================================

        @(posedge clk);

        req_valid = 1;
        req_addr  = 32'h1000;
        req_type  = 2'b01;   // READ
        req_core  = 2'b00;   // CORE0

        @(posedge clk);

        req_valid = 0;

        #20;

        // ======================================
        // TEST 2 : CORE1 READ SAME LINE
        // SHARED STATE
        // ======================================

        @(posedge clk);

        req_valid = 1;
        req_addr  = 32'h1000;
        req_type  = 2'b01;   // READ
        req_core  = 2'b01;   // CORE1

        @(posedge clk);

        req_valid = 0;

        #20;

        // ======================================
        // TEST 3 : CORE0 WRITE
        // SHOULD INVALIDATE CORE1
        // SHARED -> MODIFIED
        // ======================================

        @(posedge clk);

        req_valid = 1;
        req_addr  = 32'h1000;
        req_type  = 2'b10;   // WRITE
        req_core  = 2'b00;   // CORE0

        @(posedge clk);

        req_valid = 0;

        #50;

                // ======================================
        // COVERAGE REPORT
        // ======================================

        $display("");
        $display("====================================");
        $display("        COVERAGE REPORT");
        $display("====================================");

        $display("READ requests        = %0d", read_count);
        $display("WRITE requests       = %0d", write_count);

        $display("CORE0 accesses       = %0d", core0_count);
        $display("CORE1 accesses       = %0d", core1_count);

        $display("INVALIDATIONS sent   = %0d", invalidate_count);

        $display("====================================");

        // ======================================
        // FINISH
        // ======================================

        $finish;

    end

endmodule