class mshr_overflow_seq;

    task run();

        repeat (64) begin

            tb.dut.miss_valid = 1;
            tb.dut.miss_addr  = $random;

            #2;

        end

    endtask

endclass