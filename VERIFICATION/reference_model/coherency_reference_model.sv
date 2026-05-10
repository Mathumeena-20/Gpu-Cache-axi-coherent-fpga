module coherency_reference_model #(
    parameter NUM_CORES = 4,
    parameter LINES     = 256
)(
    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic [31:0] addr,
    input  logic [1:0] req_type,
    input  logic [$clog2(NUM_CORES)-1:0] core_id,

    output logic [NUM_CORES-1:0] sharers,
    output logic [$clog2(NUM_CORES)-1:0] owner
);

    typedef struct packed {

        logic valid;
        logic [NUM_CORES-1:0] sharer_vec;
        logic [$clog2(NUM_CORES)-1:0] owner_id;

    } coh_entry_t;

    coh_entry_t directory [0:LINES-1];

    logic [7:0] index;

    assign index = addr[9:2];

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            sharers <= 0;
            owner   <= 0;

        end else begin

            if (req_valid) begin

                case(req_type)

                    // READ
                    2'b00: begin

                        directory[index]
                            .sharer_vec[core_id] <= 1;

                    end

                    // WRITE
                    2'b01: begin

                        directory[index]
                            .sharer_vec <= (1 << core_id);

                        directory[index]
                            .owner_id <= core_id;

                    end

                endcase

                sharers <=
                    directory[index].sharer_vec;

                owner <=
                    directory[index].owner_id;

            end
        end
    end

endmodule