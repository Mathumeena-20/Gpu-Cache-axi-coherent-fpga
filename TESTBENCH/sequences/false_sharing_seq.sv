class false_sharing_seq;

    task run();

        tb.dut.req_addr = 32'h2000;

        #10;

        tb.dut.req_addr = 32'h2004;

    endtask

endclass