module coherence_fsm_mesi(
    input  logic clk,
    input  logic rst,

    input  logic read_hit,
    input  logic write_hit,
    input  logic invalidate,

    output logic [1:0] state
);

    typedef enum logic [1:0] {

        INVALID   = 2'b00,
        SHARED    = 2'b01,
        EXCLUSIVE = 2'b10,
        MODIFIED  = 2'b11

    } mesi_state_t;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            state <= INVALID;

        else begin

            case(state)

                INVALID:
                    if (read_hit)
                        state <= EXCLUSIVE;

                EXCLUSIVE:
                    if (write_hit)
                        state <= MODIFIED;

                MODIFIED:
                    if (invalidate)
                        state <= INVALID;

            endcase
        end
    end

endmodule