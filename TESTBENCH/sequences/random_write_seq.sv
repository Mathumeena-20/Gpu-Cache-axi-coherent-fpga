class random_write_seq;

    task run();

        repeat (100) begin

            tb.dut.req_valid = 1;
            tb.dut.req_write = 1;

            tb.dut.req_addr  = $random;
            tb.dut.req_wdata = $random;

            #10;

        end

    endtask

endclass