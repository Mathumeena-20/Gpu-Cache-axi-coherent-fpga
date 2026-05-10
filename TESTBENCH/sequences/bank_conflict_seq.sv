class bank_conflict_seq;

    task run();

        repeat (32) begin

            tb.dut.req_addr = 32'h1000;

            #5;

        end

    endtask

endclass