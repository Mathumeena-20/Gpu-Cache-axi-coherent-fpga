/*`timescale 1ns/1ps

module axi_memory(

    input  logic        clk,
    input  logic        rst,

    // ==========================================
    // AXI READ ADDRESS CHANNEL
    // ==========================================

    input  logic        arvalid,
    input  logic [31:0] araddr,

    output logic        arready,

    // ==========================================
    // AXI READ DATA CHANNEL
    // ==========================================

    output logic        rvalid,
    output logic [63:0] rdata

);

    // ==========================================
    // MEMORY ARRAY
    // ==========================================

    logic [63:0] mem [0:1023];

    integer i;

    integer delay_counter;

    // ==========================================
    // INITIALIZE MEMORY
    // ==========================================

    initial begin

        for (i = 0; i < 1024; i = i + 1) begin

            mem[i] = i;

        end

    end

    // ==========================================
    // AXI MEMORY LOGIC
    // ==========================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            arready <= 0;

            rvalid  <= 0;
            rdata   <= 0;

            delay_counter <= 0;

        end
        else begin

            // Default outputs

            arready <= 0;
            rvalid  <= 0;

            // ==================================
            // ACCEPT READ ADDRESS
            // ==================================

            if (arvalid) begin

                arready <= 1;

                // Random DRAM latency

                //delay_counter <= $urandom_range(1,5);
                delay_counter <= 4;

            end

            // ==================================
            // DELAY COUNTER
            // ==================================

            if (delay_counter > 0)

                delay_counter <= delay_counter - 1;

            // ==================================
            // SEND READ RESPONSE
            // ==================================

            if (delay_counter == 1) begin

                rvalid <= 1;

                rdata <= mem[araddr[11:2]];

            end

        end
    end

endmodule*/


`timescale 1ns/1ps

module axi_memory(

    input  logic        clk,
    input  logic        rst,

    // ==========================================
    // AXI READ ADDRESS CHANNEL
    // ==========================================

    input  logic        arvalid,
    input  logic [31:0] araddr,

    output logic        arready,

    // ==========================================
    // AXI READ DATA CHANNEL
    // ==========================================

    output logic        rvalid,
    output logic [63:0] rdata

);

    // ==========================================
    // MEMORY ARRAY
    // ==========================================

    logic [63:0] mem [0:1023];

    integer i;

    // ==========================================
    // SYNTHESIZABLE COUNTER
    // ==========================================

    logic [2:0] delay_counter;

    // ==========================================
    // MEMORY INITIALIZATION
    // ==========================================

    initial begin

        for (i = 0; i < 1024; i = i + 1) begin

            mem[i] = i;
        end

    end

    // ==========================================
    // AXI MEMORY MODEL
    // ==========================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            arready       <= 1'b0;
            rvalid        <= 1'b0;
            rdata         <= 64'b0;
            delay_counter <= 3'b0;

        end
        else begin

            // ==================================
            // DEFAULTS
            // ==================================

            arready <= 1'b0;
            rvalid  <= 1'b0;

            // ==================================
            // ACCEPT ADDRESS
            // ==================================

            if (arvalid && delay_counter == 0) begin

                arready       <= 1'b1;
                delay_counter <= 3'd4;

            end

            // ==================================
            // DELAY COUNTDOWN
            // ==================================

            else if (delay_counter > 0) begin

                delay_counter <= delay_counter - 1'b1;

            end

            // ==================================
            // SEND RESPONSE
            // ==================================

            if (delay_counter == 1) begin

                rvalid <= 1'b1;
                rdata  <= mem[araddr[11:2]];

            end

        end
    end

endmodule