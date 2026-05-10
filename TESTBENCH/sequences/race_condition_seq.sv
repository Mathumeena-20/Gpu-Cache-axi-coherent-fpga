class race_condition_seq;

    task run();

        fork

            begin
                tb.dut.req_addr = 32'h1000;
                tb.dut.req_valid = 1;
            end

            begin
                tb.dut.req_addr = 32'h1000;
                tb.dut.req_write = 1;
            end

        join

    endtask

endclass