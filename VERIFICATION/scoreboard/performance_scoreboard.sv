class performance_scoreboard extends scoreboard;

    `uvm_component_utils(performance_scoreboard)

    int cache_hits;
    int cache_misses;

    int total_latency;
    int txn_count;

    function new(string name,
                 uvm_component parent);

        super.new(name,parent);

        cache_hits   = 0;
        cache_misses = 0;

        total_latency = 0;
        txn_count     = 0;

    endfunction

    virtual function void record_hit();

        cache_hits++;

    endfunction

    virtual function void record_miss();

        cache_misses++;

    endfunction

    virtual function void record_latency(
        int latency
    );

        total_latency += latency;
        txn_count++;

    endfunction

    function void report_phase(
        uvm_phase phase
    );

        real hit_rate;
        real avg_latency;

        if ((cache_hits + cache_misses) != 0)

            hit_rate =
            (cache_hits * 100.0) /
            (cache_hits + cache_misses);

        else
            hit_rate = 0;

        if (txn_count != 0)

            avg_latency =
            total_latency * 1.0 / txn_count;

        else
            avg_latency = 0;

        `uvm_info("PERF_SB",

            $sformatf(
            "HitRate=%0.2f%% AvgLatency=%0.2f",
             hit_rate,
             avg_latency),

             UVM_NONE)

    endfunction

endclass