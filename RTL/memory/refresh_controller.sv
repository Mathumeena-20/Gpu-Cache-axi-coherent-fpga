module refresh_controller(
    input logic clk,
    input logic rst,

    output logic refresh_req
);

    logic [15:0] refresh_counter;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            refresh_counter <= 0;
            refresh_req     <= 0;

        end else begin

            refresh_counter <= refresh_counter + 1;

            if (refresh_counter == 5000) begin

                refresh_req <= 1;
                refresh_counter <= 0;

            end else begin

                refresh_req <= 0;

            end
        end
    end

endmodule