module cache_reference_model #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64,
    parameter LINES      = 256
)(
    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic req_write,

    input  logic [ADDR_WIDTH-1:0] addr,
    input  logic [DATA_WIDTH-1:0] wdata,

    output logic hit,
    output logic [DATA_WIDTH-1:0] rdata
);

    typedef struct packed {

        logic valid;
        logic [ADDR_WIDTH-1:0] tag;
        logic [DATA_WIDTH-1:0] data;

    } cache_line_t;

    cache_line_t cache [0:LINES-1];

    logic [7:0] index;

    assign index = addr[9:2];

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            hit <= 0;

        end else begin

            if (req_valid) begin

                if (cache[index].valid &&
                    cache[index].tag == addr) begin

                    hit   <= 1;
                    rdata <= cache[index].data;

                    if (req_write)
                        cache[index].data <= wdata;

                end else begin

                    hit <= 0;

                    cache[index].valid <= 1;
                    cache[index].tag   <= addr;
                    cache[index].data  <= wdata;

                end
            end
        end
    end

endmodule