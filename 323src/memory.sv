// Word-addressable memory module.
// (addr[1:0] is ignored)
// addr must be in range [start, top]
module memory(
    data_out,
    addr,
    data_in,
    we,
    clk,
    rst_b
);
    output [7:0] data_out[0:3];
    input [31:0] addr;
    input  [7:0] data_in[0:3];
    input we;
    input clk;
    input rst_b;

    parameter start = 0, top = (1<<16) - 1;
    parameter last_index = top >> 2;
    parameter has_default=0;
    parameter default_file="";

    reg [7:0] mem[start:top];
    wire [31:0] ea = addr & 32'hfffffffc;

    assign data_out[0] = mem[ea];
    assign data_out[1] = mem[ea + 1];
    assign data_out[2] = mem[ea + 2];
    assign data_out[3] = mem[ea + 3];

    always_ff @(posedge clk, negedge rst_b) begin
        if (rst_b == 0) begin
            integer i;
            if (has_default) begin
                $readmemh(default_file, mem);
                // for (i = start; i <= top; i++)
                //     $display(i, mem[i]);
            end else begin
                for (i = start; i <= top; i++)
                    mem[i] <= 0;
            end
        end else begin
            if (we) begin
                mem[ea + 0] <= data_in[0];
                mem[ea + 1] <= data_in[1];
                mem[ea + 2] <= data_in[2];
                mem[ea + 3] <= data_in[3];
            end
        end
    end

    // always $display("time: %d ------------------- addr: %h, we: %b, mem[10000000]: %h", $time, addr, we, mem[(32'h10000000 & 32'hfffffffc) + 0]);

    // always @(posedge clk) $display("%h", {
    //     mem[(32'h10020100 & 32'hfffffffc) + 3],
    //     mem[(32'h10020100 & 32'hfffffffc) + 2],
    //     mem[(32'h10020100 & 32'hfffffffc) + 1],
    //     mem[(32'h10020100 & 32'hfffffffc) + 0]
    // });
endmodule