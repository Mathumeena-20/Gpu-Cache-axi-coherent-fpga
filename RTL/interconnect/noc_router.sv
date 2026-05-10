module noc_router(
    input  logic clk,
    input  logic rst,

    input  logic valid_in,
    input  logic [63:0] packet_in,

    output logic valid_out,
    output logic [63:0] packet_out
);

    logic route_sel;

    route_compute route (

        .addr(packet_in[31:0]),
        .route(route_sel)

    );

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            valid_out <= 0;
            packet_out <= 0;
        end else begin

            valid_out <= valid_in;
            packet_out <= packet_in;

        end
    end

endmodule