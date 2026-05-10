module axi_slave_mem #(
    parameter DEPTH = 1024
)(
    input logic clk,
    input logic rst,

    input logic arvalid,
    input logic [31:0] araddr,

    output logic rvalid,
    output logic [63:0] rdata
);

    logic [63:0] mem [DEPTH-1:0];

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            rvalid <= 0;

        else begin

            if (arvalid) begin

                rdata  <= mem[araddr[11:2]];
                rvalid <= 1;

            end else
                rvalid <= 0;

        end
    end

endmodule