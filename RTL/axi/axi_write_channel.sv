module axi_write_channel(
    input logic clk,
    input logic rst,

    input logic awvalid,
    input logic [31:0] awaddr,

    input logic wvalid,
    input logic [63:0] wdata,

    output logic awready,
    output logic wready
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            awready <= 0;
            wready  <= 0;

        end else begin

            awready <= awvalid;
            wready  <= wvalid;

        end
    end

endmodule