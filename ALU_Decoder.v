/*
------------------------------------------------------------
Module Name : ALU_Decoder

Description :
- Generates the ALU control signal based on:
    * ALUOp from the Main Decoder.
    * funct3 field.
    * Instr[30] (funct7 bit 5).
- Implements combinational logic.
- Supports the following ALU operations:
    * ADD
    * SUB
    * Shift Left Logical (SLL)
    * Shift Right Logical (SRL)
    * XOR
    * OR
    * AND
- For memory instructions (lw, sw), the ALU performs addition.
- For branch instructions, the ALU performs subtraction for
  comparison.
- Unsupported combinations default to the ADD operation.
------------------------------------------------------------
*/

module ALU_Decoder (
    input       wire     [1:0]     ALUOp,
    input       wire     [2:0]     funct3,    //instr[14:12]
    input       wire               Op5,       // Opcode[5]
    input       wire               funct7_5,  //instr[30]
    output      reg      [2:0]     ALUControl
);

  // ALU operation codes
    localparam ADD = 3'b000;
    localparam SHL = 3'b001;
    localparam SUB = 3'b010;
    localparam XOR = 3'b100;
    localparam SHR = 3'b101;
    localparam OR  = 3'b110;
    localparam AND = 3'b111;

always @(*) begin
    ALUControl = ADD;

    case (ALUOp)
        2'b00: ALUControl = ADD; // For lw and sw instructions
        2'b01: ALUControl = SUB; // For branch instructions
        2'b10: begin // R-Type and I-Type instructions
            case (funct3)
                3'b000: ALUControl = (Op5 && funct7_5) ? SUB : ADD; // ADD or SUB
                3'b001: ALUControl = SHL; // Shift Left Logical
                3'b100: ALUControl = XOR; // XOR
                3'b101: ALUControl = SHR; // Shift Right Logical
                3'b110: ALUControl = OR;  // OR
                3'b111: ALUControl = AND; // AND
                default: ALUControl = ADD; // Default to ADD for unsupported funct3 values
            endcase
        end
        default: ALUControl = ADD; // Default to ADD for unsupported ALUOp values
    endcase
end

endmodule