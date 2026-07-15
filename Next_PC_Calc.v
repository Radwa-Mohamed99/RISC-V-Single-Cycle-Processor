/*
------------------------------------------------------------
Module Name : Next_PC_Calc

Description :
- Calculates the next value of the Program Counter (PC).
- Computes both PC + 4 and PC + ImmExt.
- Uses the PCSrc control signal to select the appropriate
  next PC value.
- PC + 4 is used for sequential execution, while PC + ImmExt
  is used for branch instructions.
------------------------------------------------------------
*/

module Next_PC_Calc #(
    parameter WIDTH = 32
) (
    input       wire     [WIDTH-1:0]     PC,
    input       wire     [WIDTH-1:0]     ImmExt,
    input       wire                     PCSrc,
    output      wire      [WIDTH-1:0]    PCNext
);

wire     [WIDTH-1:0]     PCTarget;
wire     [WIDTH-1:0]     PCPlus4;

localparam [WIDTH-1:0] FOUR = 32'd4;

Adder_32B #(
    .WIDTH(WIDTH)
) PC_Target_Adder (
    .A(PC),
    .B(ImmExt),
    .Sum(PCTarget)
);

Adder_32B #(
    .WIDTH(WIDTH)
) PCPlus4_Adder (
    .A(PC),
    .B(FOUR),
    .Sum(PCPlus4)
);

MUX_2X1 #(
    .WIDTH(WIDTH)
) PC_Select_MUX (
    .A(PCPlus4),
    .B(PCTarget),
    .Sel(PCSrc),
    .Y(PCNext)
);
endmodule