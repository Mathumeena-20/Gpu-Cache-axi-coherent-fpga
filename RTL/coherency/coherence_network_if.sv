module coherence_network_if(
    input logic clk,
    input logic rst,

    input logic send_req,

    output logic net_valid
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            net_valid <= 0;

        else
            net_valid <= send_req;

    end

endmodule