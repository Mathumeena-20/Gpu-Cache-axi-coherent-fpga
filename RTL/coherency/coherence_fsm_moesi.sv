module coherence_fsm_moesi(
    input logic clk,
    input logic rst,

    input logic read_req,
    input logic write_req,
    input logic invalidate,

    output logic [2:0] state
);

    typedef enum logic [2:0] {

        I = 3'b000,
        S = 3'b001,
        E = 3'b010,
        O = 3'b011,
        M = 3'b100

    } moesi_state_t;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            state <= I;

        else begin

            case(state)

                I:
                    if (read_req)
                        state <= E;

                E:
                    if (write_req)
                        state <= M;

                M:
                    if (invalidate)
                        state <= I;

            endcase
        end
    end

endmodule