class env_config extends uvm_object;

    `uvm_object_utils(env_config)

    bit enable_axi;
    bit enable_coherency;

    function new(string name="env_config");
        super.new(name);
    endfunction

endclass