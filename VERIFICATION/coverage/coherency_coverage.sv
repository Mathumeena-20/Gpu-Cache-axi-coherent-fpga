`timescale 1ns/1ps

module coherency_coverage (

    input logic clk,

    input logic [1:0] req_type,
    input logic [1:0] req_core,

    input logic grant,

    input logic send_invalidate,
    input logic [3:0] invalidate_vector

);

    // ==========================================
    // COVERGROUP
    // ==========================================

    covergroup coherency_cg @(posedge clk);

        // ======================================
        // REQUEST TYPE COVERAGE
        // ======================================

        cp_req_type : coverpoint req_type {

            bins READ  = {2'b01};
            bins WRITE = {2'b10};

        }

        // ======================================
        // CORE COVERAGE
        // ======================================

        cp_core : coverpoint req_core {

            bins CORE0 = {2'b00};
            bins CORE1 = {2'b01};
            bins CORE2 = {2'b10};
            bins CORE3 = {2'b11};

        }

        // ======================================
        // GRANT COVERAGE
        // ======================================

        cp_grant : coverpoint grant {

            bins granted = {1};

        }

        // ======================================
        // INVALIDATION COVERAGE
        // ======================================

        cp_invalidate : coverpoint send_invalidate {

            bins invalidate_sent = {1};

        }

        // ======================================
        // INVALIDATE VECTOR COVERAGE
        // ======================================

        cp_inv_vector : coverpoint invalidate_vector {

            bins core0 = {4'b0001};
            bins core1 = {4'b0010};
            bins core2 = {4'b0100};
            bins core3 = {4'b1000};

            bins multi_core = {[4'b0011:4'b1111]};

        }

        // ======================================
        // CROSS COVERAGE
        // ======================================

        cross_req_core :

            cross cp_req_type, cp_core;

    endgroup

    // ==========================================
    // CREATE COVERGROUP INSTANCE
    // ==========================================

    coherency_cg cg = new();

endmodule