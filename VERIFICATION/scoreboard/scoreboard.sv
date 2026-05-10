`timescale 1ns/1ps

class scoreboard extends uvm_scoreboard;

    `uvm_component_utils(scoreboard)

    int total_checks;
    int total_errors;

    function new(string name, uvm_component parent);

        super.new(name, parent);

        total_checks = 0;
        total_errors = 0;

    endfunction

    virtual function void check_result(bit condition,
                                       string msg);

        total_checks++;

        if (!condition) begin

            total_errors++;

            `uvm_error("SCOREBOARD", msg)

        end
        else begin

            `uvm_info("SCOREBOARD",
                      msg,
                      UVM_LOW)

        end

    endfunction

    function void report_phase(uvm_phase phase);

        `uvm_info("SCOREBOARD",

                  $sformatf(
                  "Checks=%0d Errors=%0d",
                  total_checks,
                  total_errors),

                  UVM_NONE)

    endfunction

endclass