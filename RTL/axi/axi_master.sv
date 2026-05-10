`timescale 1ns/1ps

module axi_master(

    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic [31:0] req_addr,

    output logic arvalid,
    output logic [31:0] araddr,

    input  logic arready
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            arvalid <= 0;
            araddr  <= 0;

        end
        else begin

            // =====================================
            // ISSUE AXI READ REQUEST
            // =====================================

            if (req_valid && !arvalid) begin

                arvalid <= 1;
                araddr  <= req_addr;

            end

            // =====================================
            // AXI HANDSHAKE COMPLETE
            // =====================================

            if (arvalid && arready) begin

                arvalid <= 0;
            end
        end
    end

endmodule