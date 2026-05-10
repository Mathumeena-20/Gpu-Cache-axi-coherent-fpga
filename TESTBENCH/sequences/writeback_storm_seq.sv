class writeback_storm_seq;

    task run();

        repeat (64) begin

            tb.dut.wb_valid = 1;

            #5;

        end

    endtask

endclass