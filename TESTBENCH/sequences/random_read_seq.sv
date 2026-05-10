class random_read_seq;

    task run();

        repeat (100) begin

            tb.dut.req_valid = 1;
            tb.dut.req_addr  = $random;

            #10;

        end

    endtask

endclass