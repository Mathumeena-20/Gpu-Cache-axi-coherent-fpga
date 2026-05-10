module miss_handler(
    input  logic clk,
    input  logic rst,

    input  logic miss,

    output logic mem_request
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            mem_request <= 0;
        else
            mem_request <= miss;

    end

endmodule