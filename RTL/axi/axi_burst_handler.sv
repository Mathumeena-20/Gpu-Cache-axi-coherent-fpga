module axi_burst_handler(
    input logic clk,
    input logic rst,

    input logic burst_valid,
    input logic [7:0] burst_len,

    output logic burst_done
);

    logic [7:0] count;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            count <= 0;
            burst_done <= 0;

        end else begin

            if (burst_valid) begin

                if (count == burst_len) begin

                    burst_done <= 1;
                    count <= 0;

                end else begin

                    count <= count + 1;
                    burst_done <= 0;

                end
            end
        end
    end

endmodule