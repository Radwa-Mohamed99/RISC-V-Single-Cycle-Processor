/*
------------------------------------------------------------
Module Name : Main_Decoder

Description :
- Decodes the 7-bit instruction opcode to generate the main
  control signals for the RISC-V processor.
- Implements combinational logic using a case statement.
- Supports the following instruction types:
    * Load Word (LW)
    * Store Word (SW)
    * R-Type instructions
    * I-Type instructions
    * Branch instructions
- Generates the following control signals:
    * RegWrite
    * ImmSrc
    * ALUSrc
    * MemWrite
    * ResultSrc
    * Branch
    * ALUOp
- Unsupported opcodes generate safe default control signals.
------------------------------------------------------------
*/

module Main_Decoder (
    input       wire     [6:0]     Opcode,

    output      reg      [1:0]     ImmSrc,
    output      reg                Branch,
    output      reg                Load,
    output      reg                ResultSrc,
    output      reg                MemWrite,
    output      reg                ALUSrc,
    output      reg                RegWrite,
    output      reg      [1:0]     ALUOp
);

  // Opcode definitions
    localparam LW     = 7'b0000011; // Load Word
    localparam SW     = 7'b0100011; // Store Word
    localparam R_TYPE = 7'b0110011; // R-Type instructions
    localparam I_TYPE = 7'b0010011; // I-Type instructions
    localparam BRANCH = 7'b1100011; // Branch instructions

    // Main Decoder Logic
    always @(*) begin
        // Default control signal values
        ImmSrc     = 2'b00;
        Branch     = 1'b0;
        Load       = 1'b1; //// Enable instruction/data access for all valid opcodes
        ResultSrc  = 1'b0;
        MemWrite   = 1'b0;
        ALUSrc     = 1'b0;
        RegWrite   = 1'b0;
        ALUOp      = 2'b00;

        case (Opcode)
            LW: begin
                ImmSrc     = 2'b00; // I-Type immediate
                ResultSrc  = 1'b1;  // Select memory data as result
                ALUSrc     = 1'b1;  // Use immediate for ALU operation
                RegWrite   = 1'b1;  // Enable register write
                ALUOp      = 2'b00; // ALU performs addition for address calculation
            end

            SW: begin
                ImmSrc     = 2'b01; // S-Type immediate
                MemWrite   = 1'b1;  // Enable memory write
                ALUSrc     = 1'b1;  // Use immediate for ALU operation
                ALUOp      = 2'b00; // ALU performs addition for address calculation
            end

            R_TYPE: begin
                RegWrite   = 1'b1;  // Enable register write
                ALUOp      = 2'b10; // ALU operation determined by funct3 and funct7 fields
            end

            I_TYPE: begin
                ImmSrc     = 2'b00; // I-Type immediate
                RegWrite   = 1'b1;  // Enable register write
                ALUSrc     = 1'b1;  // Use immediate for ALU operation
                ALUOp      = 2'b10; // ALU operation determined by funct3 field (I-Type)
            end

            BRANCH: begin
                ImmSrc     = 2'b10; // B-Type immediate
                Branch     = 1'b1;  // Enable branch operation
                ALUOp      = 2'b01; // ALU performs subtraction
            end
            default: begin
                // Default case for unsupported opcodes
                ImmSrc     = 2'b00;
                Branch     = 1'b0;
                Load       = 1'b0;  // Disable load for unsupported opcodes
                ResultSrc  = 1'b0;
                MemWrite   = 1'b0;
                ALUSrc     = 1'b0;
                RegWrite   = 1'b0;
                ALUOp      = 2'b00; // Default to addition
            end
        endcase
    end

endmodule