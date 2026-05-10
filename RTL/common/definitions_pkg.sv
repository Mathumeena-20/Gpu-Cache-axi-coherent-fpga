package definitions_pkg;

    parameter ADDR_WIDTH = 32;
    parameter DATA_WIDTH = 64;
    parameter ID_WIDTH   = 4;

    parameter NUM_CORES  = 4;

    typedef enum logic [1:0] {

        REQ_READ  = 2'b00,
        REQ_WRITE = 2'b01,
        REQ_UPG   = 2'b10

    } req_t;

endpackage