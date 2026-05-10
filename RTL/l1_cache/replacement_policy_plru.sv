module replacement_policy_plru(
    input  logic clk,
    input  logic rst,

    input  logic access,

    output logic victim
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            victim <= 0;
        else if (access)
            victim <= ~victim;

    end

endmodule