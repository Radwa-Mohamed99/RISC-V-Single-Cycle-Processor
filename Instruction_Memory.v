/*
------------------------------------------------------------
Module Name : Instruction_Memory

Description :
- Read-only memory (ROM) used to store program instructions.
- Provides asynchronous read access.
- Stores 64 instructions, each 32 bits wide.
- The Program Counter (PC) is connected directly to the
  address input.
- Memory is word-aligned; therefore, address bits [31:2]
  are used to index the ROM.

    Byte Address:
    0   4   8   12   16  20   24   28   32

    ROM Index:
    0   1   2    3   4   5    6   7    8
------------------------------------------------------------
*/

module Instruction_Memory #(
    parameter WIDTH = 32,
    parameter DEPTH = 64,
    parameter ADDR_WIDTH = $clog2(DEPTH)
) (
    input       wire     [WIDTH-1:0]     A,   // 32-bit Program Counter address
    output      wire     [WIDTH-1:0]    RD   // Instruction output
);

reg [WIDTH-1:0] ROM [0:DEPTH-1];


/*  Test bench
integer i;
initial begin

    // Initialize ROM locations to zero before loading instructions
    // to avoid unknown values in unused memory addresses  
    for(i = 0; i < DEPTH; i = i + 1)
        ROM[i] = 32'b0;

    $readmemh("program.txt", ROM);

end
*/
// Asynchronous read access
assign RD = ROM[A[ADDR_WIDTH+1:2]]; // Ignore bits [1:0] for word alignment

endmodule

