module IF(
    input CTR, CLK, RST,//制御信号にあたるけど命令そのもの
    input [4:0] BADR,
    output [32:0] INST,
    output [4:0] NADR
);
`include "common_param.vh"
reg [31:0] IMEM [0:63];//命令メモリ
integer  i;
initial begin
    for (i = 0; i < 64; i = i + 1) begin
          IMEM[i] = 32'd0;
    end
    IMEM[0] = {R_FORM, t1, t2, t3, 5'd0, ADD};
    IMEM[1] = {ADDI, s1, s2, 16'd256};
    IMEM[2] = {LW, s1, s2, 16'd128};
    IMEM[3] = {BEQ, s1, s2, 16'd64};
end
reg [31:0] inst = 32'b0;//pipeline_reg
reg [4:0] nadr = 5'd0;//pipeline_reg
wire [4:0] next_pc, mux1;
assign mux1 = CTR ? next_pc : BADR;

reg [4:0] PC = 0;
always @(posedge CLK or posedge RST) begin
    if(RST)begin
        PC <= 5'd0;
    end
    else begin
        PC <= mux1;
    end
end

assign next_pc = PC + 1;//計算しとく

always @(posedge CLK or posedge RST) begin
    if(RST)begin
        inst <= 32'd0;
        nadr <= 5'd0;
    end
    else begin
        inst <= IMEM[PC];
        nadr <= next_pc;
    end
end

assign INST = inst;
assign NADR = nadr;
endmodule