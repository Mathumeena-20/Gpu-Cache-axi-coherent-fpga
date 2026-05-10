module axi_read_channel(
    input logic clk,
    input logic rst,

    input logic arvalid,
    input logic [31:0] araddr,

    output logic arready
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            arready <= 0;

        else
            arready <= arvalid;

    end

endmodule