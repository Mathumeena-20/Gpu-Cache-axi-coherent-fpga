class cache_thrash_seq;

    task run();

        repeat (128) begin

            tb.dut.req_addr = {$random} % 64;

            #5;

        end

    endtask

endclass