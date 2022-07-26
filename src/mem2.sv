module MEM2(
    inst_mem_in,
    inst_mem_out,
    register_write_in,
    register_write_out,
    register_src_in,
    register_src_out,
    ALU_result_in,
    ALU_result_out,
    rd_num_in,
    rd_num_out,
    we_cache,
    we_memory,
    cache_input_type,
    set_dirty,
    set_valid,
    memory_address_type,
    is_word_in,
    is_word_out,
    mem_addr,
    mem_data_out,
    mem_data_in,
    cache_hit,
    cache_dirty,
    inst_addr_in,
    inst_addr_out,
    cache_data_out,
    rt_data,
    byte_number,
    halted_controller_in,
    halted_controller_out,
    clk
);

    input [31:0] inst_mem_in;
    input [31:0] inst_addr_in;
    input [7:0] mem_data_out[0:3];
    input [31:0] ALU_result_in;
    input we_cache;
    input cache_input_type;
    input set_dirty;
    input set_valid;
    input memory_address_type;
    input is_word_in;
    input [4:0] rd_num_in;
    input [1:0] register_src_in;
    input register_write_in;
    input [31:0] rt_data;
    input halted_controller_in;
    input clk;

    output we_memory;
    output [31:0] inst_mem_out;
    output [31:0] inst_addr_out;
    output reg cache_hit;
    output reg cache_dirty;
    output reg [31:0] mem_addr;
    output [31:0] ALU_result_out;
    output [4:0] rd_num_out;
    output [1:0] register_src_out;
    output register_write_out;
    output is_word_out;
    output [7:0] mem_data_in[0:3];
    output reg [7:0] cache_data_out[0:3];
    output reg [1:0] byte_number;
    output halted_controller_out;

    assign register_write_out = register_write_in;
    assign register_src_out = register_src_in;
    assign rd_num_out = rd_num_in;
    assign ALU_result_out = ALU_result_in;
    assign inst_addr_out = inst_addr_in;
    assign is_word_out = is_word_in;
    assign halted_controller_out = halted_controller_in;
    assign inst_mem_out = inst_mem_in;

    assign mem_data_in[0] = cache_data_out[0];
    assign mem_data_in[1] = cache_data_out[1];
    assign mem_data_in[2] = cache_data_out[2];
    assign mem_data_in[3] = cache_data_out[3];

    // Create cache

    wire [31:0] memory_write_address;
    reg [31:0] cache_data_in;
    wire [5:0] opcode;
    wire we_cache2;
    wire cache_input_type2;
    wire memory_address_type2;
    wire is_word2;
    wire register_write2;

    assign opcode = inst_mem_out == 32'b0 ? 6'b111111 : inst_mem_out[31:26];

    Cache cache(
        .cache_hit(cache_hit),
        .cache_dirty(cache_dirty),
        .data_out(cache_data_out),
        .memory_write_address(memory_write_address),
        .byte_number(byte_number),
        .we_cache(we_cache),
        .data_in2(),
        .cache_addr(ALU_result_in),
        .data_in(cache_data_in),
        .set_valid(set_valid),
        .set_dirty(set_dirty),
        .is_word(is_word_in),
        .clk(clk)
    );

    CacheController cache_controller(
        .cache_hit(cache_hit),
        .cache_dirty(cache_dirty),
        .opcode(opcode),
        .we_memory(we_memory),
        .we_cache(we_cache2),
        .cache_input_type(cache_input_type2),
        .memory_address_type(memory_address_type2),
        .is_word(is_word2),
        .register_write(register_write2),
        .lock(),
        .set_dirty(),
        .set_valid(),
        .pc_enable(),
        .clk(clk)
    );

    always @(memory_address_type2)
    begin
        if (memory_address_type2) begin
            mem_addr = memory_write_address;
        end
        else begin
            mem_addr = ALU_result_in;
        end
    end

    always @(cache_input_type2)
    begin
        if(cache_input_type2 == 1'b0)
        begin
            cache_data_in = {mem_data_out[3], mem_data_out[2], mem_data_out[1], mem_data_out[0]};
        end
        else
            cache_data_in = rt_data;
    end

    // always $display("time: %d, ALU_result_out_mem: %d", $time, ALU_result_out);

endmodule