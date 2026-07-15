/*
------------------------------------------------------------
Branch Decision Logic

Description :
- Determines whether a branch should be taken.
- Uses the Branch control signal from the Main Decoder together
  with the ALU status flags.
- The branch operation is selected using the funct3 field.
- Supported branch instructions:
    * BEQ : Branch if Zero flag is asserted.
    * BNE : Branch if Zero flag is deasserted.
    * BLT : Branch if Sign flag is asserted.
- Implemented using a case statement controlled by funct3.
------------------------------------------------------------
*/

module Branch_Decoder (
    input       wire     [2:0]     funct3,    //instr[14:12]
    input       wire               Zero,      // ALU Zero flag
    input       wire               Sign_Flag,      // ALU Sign flag
    input       wire               Branch,    // Branch control signal from Main Decoder
    output      reg                PCSrc      // Program Counter Source signal
);

always @(*) begin
    PCSrc = 1'b0; // Default to not taking the branch
    case (funct3)
        3'b000: PCSrc = Branch & Zero;    // BEQ: Branch if Zero flag is asserted
        3'b001: PCSrc = Branch & ~Zero; // BNE: Branch if Zero flag is deasserted
        3'b100: PCSrc = Branch & Sign_Flag; // BLT: Branch if Sign flag is asserted
        default: PCSrc = 1'b0;
    endcase
end
endmodule