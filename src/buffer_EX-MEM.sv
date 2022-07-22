module Buffer_EX_MEM(
    inst_addr_ex,
    register_write_ex,
    register_src_ex,
    ALU_result_ex,
    rt_data_ex,
    rd_num_ex,
    we_cache_ex,
    we_memory_ex,
    cache_input_type_ex,
    set_dirty_ex,
    set_valid_ex,
    memory_address_type_ex,
    is_word_ex,
    halted_controller_ex,
    inst_addr_mem,
    register_write_mem,
    register_src_mem,
    ALU_result_mem,
    rt_data_mem,
    rd_num_mem,
    we_cache_mem,
    we_memory_mem,
    cache_input_type_mem,
    set_dirty_mem,
    set_valid_mem,
    memory_address_type_mem,
    is_word_mem,
    halted_controller_mem,
    clk,
    rst_b

);

    input [31:0] inst_addr_ex;
    input register_write_ex;
    input [1:0] register_src_ex;
    input [31:0] ALU_result_ex;
    input [31:0] rt_data_ex;
    input [4:0] rd_num_ex;
    input we_cache_ex;
    input we_memory_ex;
    input cache_input_type_ex;
    input set_dirty_ex;
    input set_valid_ex;
    input memory_address_type_ex;
    input is_word_ex;
    input halted_controller_ex;
    input clk;
    input rst_b;

    output reg [31:0] inst_addr_mem;
    output reg register_write_mem;
    output reg [1:0] register_src_mem;
    output reg [31:0] ALU_result_mem;
    output reg [31:0] rt_data_mem;
    output reg [4:0] rd_num_mem;
    output reg we_cache_mem;
    output reg we_memory_mem;
    output reg cache_input_type_mem;
    output reg set_dirty_mem;
    output reg set_valid_mem;
    output reg memory_address_type_mem;
    output reg is_word_mem;
    output reg halted_controller_mem;

    dff #(32) inst_addr_dff(
        .d(inst_addr_ex),
        .q(inst_addr_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) register_write_dff(
        .d(register_write_ex),
        .q(register_write_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(2) register_src_dff(
        .d(register_src_ex),
        .q(register_src_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(32) ALU_result_dff(
        .d(ALU_result_ex),
        .q(ALU_result_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(32) rt_data_dff(
        .d(rt_data_ex),
        .q(rt_data_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(5) rd_num_dff(
        .d(rd_num_ex),
        .q(rd_num_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) we_cache_dff(
        .d(we_cache_ex),
        .q(we_cache_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) we_memory_dff(
        .d(we_memory_ex),
        .q(we_memory_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) cache_input_type_dff(
        .d(cache_input_type_ex),
        .q(cache_input_type_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) set_dirty_dff(
        .d(set_dirty_ex),
        .q(set_dirty_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) set_valid_dff(
        .d(set_valid_ex),
        .q(set_valid_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) memory_address_type_dff(
        .d(memory_address_type_ex),
        .q(memory_address_type_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) is_word_dff(
        .d(is_word_ex),
        .q(is_word_mem),
        .clk(clk),
        .rst_b(rst_b)
    );

    dff #(1) halted_controller_dff(
        .d(halted_controller_ex),
        .q(halted_controller_mem),
        .clk(clk),
        .rst_b(rst_b)
    );


endmodule