module EX(
    rs_data,
    rt_data_in,
    rt_data_out,
    pc4,
    inst_50,
    inst_2016,
    inst_1511,
    inst_106,
    destination_register,
    ALU_src,
    ALU_OP,
    register_write_in,
    register_write_out,
    register_src_in,
    register_src_out,
    branch,
    //mem_write_in, // Need to be replaced
    //mem_write_out,
    //mem_read_in, // Need to be replaced
    //mem_read_out,
    imm_extend,
    pc_src,
    baddr,
    ALU_result,
    rd_num,
    clk
);

    input [31:0] rs_data;
    input [31:0] rt_data_in;
    input [31:0] pc4;
    input [6:0] inst_50;
    input [4:0] inst_2016;
    input [4:0] inst_1511;
    input [4:0] inst_106;
    input [1:0] destination_register; // 01 for rd and 00 for rt and 10 for ra
    input ALU_src;
    input [4:0] ALU_OP;
    input register_write_in;
    input [1:0] register_src_in;
    input branch;
    input [31:0] imm_extend;
    //input mem_write_in;
    //input mem_read_in;
    input clk;

    output register_write_out;
    output [1:0] register_src_out;
    output reg pc_src;
    output reg [31:0] baddr;
    output reg [31:0] ALU_result;
    output [31:0] rt_data_out;
    output reg [4:0] rd_num;
    //output mem_write_out;
    //output mem_read_out;

    assign mem_write_out = mem_write_in;
    assign mem_read_out = mem_read_in;
    assign register_write_out = register_write_in;
    assign register_src_out = register_src_in;
    assign rt_data_out = rt_data_in;

    // create pc controller EX
    
    wire zero;
    
    pc_controller_EX pc_controller_EX(
        .pc4(pc4),
        .branch(branch),
        .imm_sign_extend(imm_extend),
        .pc_src(pc_src),
        .baddr(baddr),
        .zero(zero),
        .clk(clk)
    );

    // Create ALU
    reg [31:0] data_in2;

    ALU alu(
        .data_out(ALU_result),
        .zero(zero),
        .ALU_OP(ALU_OP),
        .data_in1(rs_data),
        .data_in2(data_in2),
        .shift_amount(inst_106)
    );

    always @(ALU_src)
    begin
        if (ALU_src) begin
            data_in2 = imm_extend;
        end else
            data_in2 = rt_data;
    end

    always @(inst_1511 || inst_2016)
        begin

            case (destination_register)
                2'b00: rd_num = inst_2016;
                2'b01: rd_num = inst_1511;
                2'b10: rd_num = 5'b11111;
                default:
                    rd_num = inst_2016;
            endcase

        end
    endmodule
   