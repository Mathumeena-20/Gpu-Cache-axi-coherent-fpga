module bank_machine(
    input logic clk,
    input logic rst,

    input logic activate,
    input logic precharge,

    output logic bank_open
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            bank_open <= 0;

        else begin

            if (activate)
                bank_open <= 1;

            if (precharge)
                bank_open <= 0;

        end
    end

endmodule