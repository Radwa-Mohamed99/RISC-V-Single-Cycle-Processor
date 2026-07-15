module Control_Unit (
    input       wire     [6:0]           Opcode,
    input       wire     [2:0]           Funct3,
    input       wire                     Funct7_5,
    input       wire                     zero,
    input       wire                     Sign_Flag,

    output      wire      [1:0]           ImmSrc,
    output      wire                      Branch,
    output      wire                      Load,
    output      wire                      ResultSrc,
    output      wire                      MemWrite,
    output      wire                      ALUSrc,
    output      wire                      RegWrite,
    output      wire      [2:0]           ALUControl,
    output      wire                      PCSrc
);

wire  [1:0]  ALUOp;
wire Op5;

assign Op5 = Opcode[5];

Main_Decoder main_decoder_inst (
    .Opcode(Opcode),
    .ImmSrc(ImmSrc),
    .Branch(Branch),
    .Load(Load),
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
);

ALU_Decoder alu_decoder_inst (
    .ALUOp(ALUOp),
    .funct3(Funct3),
    .Op5(Op5),
    .funct7_5(Funct7_5),
    .ALUControl(ALUControl)
);

Branch_Decoder branch_decoder_inst (
    .funct3(Funct3),
    .Branch(Branch),
    .Zero(zero),
    .Sign_Flag(Sign_Flag),
    .PCSrc(PCSrc)
);

endmodule




