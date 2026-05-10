module l1_cache_controller(
    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic hit,

    output logic stall,
    output logic allocate
);

    always_comb begin

        stall    = 0;
        allocate = 0;

        if (req_valid && !hit)
            allocate = 1;

    end

endmodule