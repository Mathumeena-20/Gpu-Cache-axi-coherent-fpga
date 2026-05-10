module axi_id_tracker #(
    parameter ID_WIDTH = 4
)(
    input logic clk,
    input logic rst,

    input logic alloc,

    output logic [ID_WIDTH-1:0] id_out
);

    logic [ID_WIDTH-1:0] counter;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            counter <= 0;

        else if (alloc)
            counter <= counter + 1;

    end

    assign id_out = counter;

endmodule