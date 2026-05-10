module qos_controller(
    input  logic clk,
    input  logic rst,

    input  logic high_priority_req,
    input  logic low_priority_req,

    output logic grant_high,
    output logic grant_low
);

    always_comb begin

        grant_high = 0;
        grant_low  = 0;

        if (high_priority_req)
            grant_high = 1;

        else if (low_priority_req)
            grant_low = 1;

    end

endmodule