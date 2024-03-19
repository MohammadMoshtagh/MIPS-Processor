module Buffer_ID_EX(
    inst_addr_id,
    rs_data_id,
    rt_data_id,
    frs_data_id,
    frt_data_id,
    frs_data_ex,
    frt_data_ex,
    inst_id,
    inst_50_id,
    inst_2016_id,
    inst_1511_id,
    inst_106_id,
    inst_id_out,
    inst_ex_in,
    destination_register_id,
    ALU_src_id,
    ALU_OP_id,
    we_memory_id,
    fregister_write_id,
    fregister_write_ex,
    register_write_id,
    register_src_id,
    fregister_src_id,
    is_nop_id,
    halted_controller_id,
    branch_id,
    jump_id,
    jump_register_id,
    jea_id,
    pc_enable_id,
    imm_extend_id,
    cache_input_type_id,
    we_cache_id,
    set_dirty_id,
    set_valid_id,
    memory_address_type_id,
    is_word_id,
    inst_addr_ex,
    rs_data_ex,
    rt_data_ex,
    inst_ex,
    inst_50_ex,
    inst_2016_ex,
    inst_1511_ex,
    inst_106_ex,
    destination_register_ex,
    ALU_src_ex,
    ALU_OP_ex,
    we_memory_ex,
    register_write_ex,
    register_src_ex,
    fregister_src_ex,
    halted_controller_ex,
    branch_ex,
    jump_ex,
    jump_register_ex,
    jea_ex,
    is_nop_ex,
    pc_enable_ex,
    imm_extend_ex,
    cache_input_type_ex,
    we_cache_ex,
    set_dirty_ex,
    set_valid_ex,
    memory_address_type_ex,
    is_word_ex,
    clk,
    rst_b,
    lock
);

    input [31:0] inst_addr_id;
    input [31:0] inst_id;
    input [31:0] inst_id_out;
    input [31:0] rs_data_id;
    input [31:0] rt_data_id;
    input [31:0] frs_data_id;
    input [31:0] frt_data_id;
    input [5:0] inst_50_id;
    input [4:0] inst_2016_id;
    input [4:0] inst_1511_id;
    input [4:0] inst_106_id;
    input [1:0] destination_register_id; // 01 for rd and 00 for rt and 10 for ra
    input ALU_src_id;
    input [4:0] ALU_OP_id;
    input we_memory_id;
    input register_write_id;
    input fregister_write_id;
    input [1:0] register_src_id;
    input [1:0] fregister_src_id;
    input halted_controller_id;
    input jump_id;
    input jump_register_id;
    input pc_enable_id;
    input [25:0] jea_id;
    input branch_id;
    input [31:0] imm_extend_id;
    input cache_input_type_id;
    input we_cache_id;
    input set_dirty_id;
    input set_valid_id;
    input memory_address_type_id;
    input is_word_id;
    input is_nop_id;
    input clk;
    input rst_b;
    input lock;

    output [31:0] inst_ex;
    output [31:0] inst_ex_in;
    output reg [31:0] inst_addr_ex;
    output reg [31:0] rs_data_ex;
    output reg [31:0] rt_data_ex;
    output reg [31:0] frs_data_ex;
    output reg [31:0] frt_data_ex;
    output reg [5:0] inst_50_ex;
    output reg [4:0] inst_2016_ex;
    output reg [4:0] inst_1511_ex;
    output reg [4:0] inst_106_ex;
    output reg [1:0] destination_register_ex; // 01 for rd and 00 for rt and 10 for ra
    output reg ALU_src_ex;
    output reg [4:0] ALU_OP_ex;
    output reg we_memory_ex;
    output reg register_write_ex;
    output reg fregister_write_ex;
    output reg [1:0] register_src_ex;
    output reg [1:0] fregister_src_ex;
    output reg jump_ex;
    output reg jump_register_ex;
    output reg [25:0] jea_ex;
    output reg pc_enable_ex;
    output reg branch_ex;
    output reg [31:0] imm_extend_ex;
    output reg cache_input_type_ex;
    output reg we_cache_ex;
    output reg set_dirty_ex;
    output reg set_valid_ex;
    output reg memory_address_type_ex;
    output reg is_word_ex;
    output is_nop_ex;
    output halted_controller_ex;

    lock_dff halted(
        .d(halted_controller_id),
        .q(halted_controller_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff is_nop(
        .d(is_nop_id),
        .q(is_nop_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(32) inst_lock_dff(
        .d(inst_id),
        .q(inst_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(32) inst_2_lock_dff(
        .d(inst_id_out),
        .q(inst_ex_in),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(32) inst_addr_lock_dff(
        .d(inst_addr_id),
        .q(inst_addr_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(32) rs_data_diff(
        .d(rs_data_id),
        .q(rs_data_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(32) rt_data_lock_dff(
        .d(rt_data_id),
        .q(rt_data_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(32) frs_data_diff(
        .d(frs_data_id),
        .q(frs_data_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(32) frt_data_lock_dff(
        .d(frt_data_id),
        .q(frt_data_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );


    lock_dff #(6) inst_50_lock_dff(
        .d(inst_50_id),
        .q(inst_50_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(5) inst_2016_lock_dff(
        .d(inst_2016_id),
        .q(inst_2016_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(5) inst_1511_lock_dff(
        .d(inst_1511_id),
        .q(inst_1511_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(5) inst_106_lock_dff(
        .d(inst_106_id),
        .q(inst_106_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(2) destination_register_lock_dff(
        .d(destination_register_id),
        .q(destination_register_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) ALU_src_lock_dff(
        .d(ALU_src_id),
        .q(ALU_src_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(5) ALU_OP_lock_dff(
        .d(ALU_OP_id),
        .q(ALU_OP_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) we_memory_lock_dff(
        .d(we_memory_id),
        .q(we_memory_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) register_write_lock_dff(
        .d(register_write_id),
        .q(register_write_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) fregister_write_lock_dff(
        .d(fregister_write_id),
        .q(fregister_write_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(2) register_src_lock_dff(
        .d(register_src_id),
        .q(register_src_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(2) fregister_src_lock_dff(
        .d(fregister_src_id),
        .q(fregister_src_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) handler_controller_lock_dff(
        .d(halted_controller_id),
        .q(halted_controller_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) branch_lock_dff(
        .d(branch_id),
        .q(branch_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) jump_lock_dff(
        .d(jump_id),
        .q(jump_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) pc_enable_lock_dff(
        .d(pc_enable_id),
        .q(pc_enable_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) jump_register_lock_dff(
        .d(jump_register_id),
        .q(jump_register_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(26) jea_lock_dff(
        .d(jea_id),
        .q(jea_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(32) imm_extend_lock_dff(
        .d(imm_extend_id),
        .q(imm_extend_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) cache_input_type_lock_dff(
        .d(cache_input_type_id),
        .q(cache_input_type_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) we_cache_lock_dff(
        .d(we_cache_id),
        .q(we_cache_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) set_dirty_lock_dff(
        .d(set_dirty_id),
        .q(set_dirty_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) set_valid_lock_dff(
        .d(set_valid_id),
        .q(set_valid_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) mempory_address_type_lock_dff(
        .d(memory_address_type_id),
        .q(memory_address_type_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

    lock_dff #(1) is_word_lock_dff(
        .d(is_word_id),
        .q(is_word_ex),
        .clk(clk),
        .rst_b(rst_b),
        .lock(lock)
    );

endmodule