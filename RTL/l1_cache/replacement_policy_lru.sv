module replacement_policy_lru #(
    parameter WAYS = 4
)(
    input  logic clk,
    input  logic access_valid,
    input  logic [$clog2(WAYS)-1:0] access_way,

    output logic [$clog2(WAYS)-1:0] victim_way
);

    logic [$clog2(WAYS)-1:0] lru_ptr;

    always_ff @(posedge clk) begin

        if (access_valid)
            lru_ptr <= access_way + 1;

    end

    assign victim_way = lru_ptr;

endmodule