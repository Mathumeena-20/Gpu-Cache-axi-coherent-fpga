module l2_controller(
    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic hit,

    output logic allocate,
    output logic stall
);

    always_comb begin

        allocate = 0;
        stall    = 0;

        if (req_valid && !hit)
            allocate = 1;

    end

endmodule