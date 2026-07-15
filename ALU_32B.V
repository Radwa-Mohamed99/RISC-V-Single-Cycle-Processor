module ALU_32B #(
    parameter WIDTH = 32
) (
    input       wire     [WIDTH-1:0]     SrcA,
    input       wire     [WIDTH-1:0]     SrcB,
    input       wire     [2:0]           ALUControl,

    output      wire                      Zero,
    output      wire                      SignFlag,
    output      reg      [WIDTH-1:0]     ALUResult
);

always @(*) begin

    case(ALUControl)
    3'b000:  ALUResult = SrcA  + SrcB;         // Addition
    3'b001:  ALUResult = SrcA << SrcB[4:0];        //  shift left logical
    3'b010:  ALUResult = SrcA  - SrcB;       //   Subtraction
    3'b100:  ALUResult = SrcA ^  SrcB;      //    XOR
    3'b101:  ALUResult = SrcA >> SrcB[4:0];     //     shift right logical
    3'b110:  ALUResult = SrcA  | SrcB;    //      OR
    3'b111:  ALUResult = SrcA  & SrcB;   //       AND
    default: ALUResult = {WIDTH{1'b0}}; //        NOP
    endcase
    
end

assign Zero = (ALUResult == {WIDTH{1'b0}});
assign SignFlag = ALUResult[WIDTH-1];
endmodule