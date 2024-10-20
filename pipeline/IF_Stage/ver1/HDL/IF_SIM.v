`timescale 1ns/100ps
module IF_SIM();
reg CLK, RST, CTR;
reg [4:0] BADR;
wire [31:0] INST;
wire [4:0] NADR;
IF IF(.CLK(CLK), .RST(RST), .CTR(CTR), .BADR(BADR), .INST(INST), .NADR(NADR));

initial begin
    RST = 0;
#50 RST = 1;
#50 RST = 0;
end

always  begin
    CLK = 0;
#50 CLK = 1;
#50;
end

initial begin
    CTR = 1;
#400 CTR = 0;
end

initial begin
    BADR = 5'd3;
end
endmodule