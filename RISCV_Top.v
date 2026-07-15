module RISCV_Top #(
    parameter WIDTH = 32,
    parameter DEPTH = 64,
    parameter ADDR_WIDTH = $clog2(DEPTH)
) (
    input       wire     clk,
    input       wire     rst_n
);

//////////////////////////////////////////////////////////////////////
// internal Sign_Flagals
//////////////////////////////////////////////////////////////////////

wire [WIDTH-1:0] PC;
wire [WIDTH-1:0] PCNext;
wire [WIDTH-1:0] Instr;

wire [WIDTH-1:0] RD1;
wire [WIDTH-1:0] RD2;

wire [WIDTH-1:0] ImmExt;

wire [WIDTH-1:0] SrcB;

wire [WIDTH-1:0] ALUResult;

wire Zero;
wire Sign_Flag;

wire [WIDTH-1:0] ReadData;

wire [WIDTH-1:0] Result;

//////////////////////////////////////////////////////////////////////
// Control Sign_Flagals
//////////////////////////////////////////////////////////////////////

wire RegWrite;
wire ALUSrc;
wire MemWrite;
wire ResultSrc;
wire Branch;
wire PCSrc;
wire Load;

wire [1:0] ImmSrc;
wire [2:0] ALUControl;

//////////////////////////////////////////////////////////////////////
// Module Instantiations
//////////////////////////////////////////////////////////////////////

Next_PC_Calc #(
    .WIDTH(WIDTH)
) Next_PC (
    .PC(PC),
    .ImmExt(ImmExt),
    .PCSrc(PCSrc),
    .PCNext(PCNext)
);

PC_Reg #(
    .WIDTH(WIDTH)
) PC_Register (
    .PCNext(PCNext),
    .load(1'b1), // Always load the next PC value
    .clk(clk),
    .rst_n(rst_n),
    .PC(PC)
);

Instruction_Memory #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) Instruction_Mem (
    .A(PC),
    .RD(Instr)
);

Reg_File #(
    .WIDTH(WIDTH),
    .DEPTH(32)
) Register_File (
    .clk(clk),
    .rst_n(rst_n),
    .WE3(RegWrite),
    .A1(Instr[19:15]),
    .A2(Instr[24:20]),
    .A3(Instr[11:7]),
    .WD3(Result),
    .RD1(RD1),
    .RD2(RD2)
);

MUX_2X1 #(
    .WIDTH(WIDTH)
) ALUSrc_MUX (
    .A(RD2),
    .B(ImmExt),
    .Sel(ALUSrc),
    .Y(SrcB)
);

ALU_32B #(
    .WIDTH(WIDTH)
) ALU (
    .SrcA(RD1),
    .SrcB(SrcB),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult),
    .Zero(Zero),
    .SignFlag(Sign_Flag)
);

Data_Memory #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
) Data_Mem (
    .A(ALUResult),
    .WD(RD2),
    .WE(MemWrite),
    .clk(clk),
    .rst_n(rst_n),
    .RD(ReadData)
);

MUX_2X1 #(
    .WIDTH(WIDTH)
) ResultSrc_MUX (
    .A(ALUResult),
    .B(ReadData),
    .Sel(ResultSrc),
    .Y(Result)
);

Control_Unit Control (
    .Opcode(Instr[6:0]),
    .Funct3(Instr[14:12]),
    .Funct7_5(Instr[30]),
    .zero(Zero),
    .Sign_Flag(Sign_Flag),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .PCSrc(PCSrc),
    .ImmSrc(ImmSrc),
    .ALUControl(ALUControl),
    .Load(Load)
);

signExtend #(
    .INSTR_WIDTH(WIDTH),
    .IMM_WIDTH(WIDTH)
) Sign_Ext (
    .Instr(Instr[31:7]),
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt)
);



endmodule 