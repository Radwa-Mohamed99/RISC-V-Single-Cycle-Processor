/*
------------------------------------------------------------
Module Name : Data_Memory

Description :
- A data memory module used in the RISC-V processor.
- Implements a single read/write memory port.
- Supports asynchronous read operation and synchronous write
  operation on the rising edge of the clock.
- Data is written to address A when Write Enable (WE) is high.
- The memory stores 64 entries, each with a 32-bit word width.
- The address input A is 32-bit, matching the processor datapath.
- Word-aligned addressing is used, where address bits [7:2]
  are used to access the 64 memory locations.
- The read data output (RD) is available without waiting for
  a clock edge.
------------------------------------------------------------
*/

module Data_Memory #(
    parameter WIDTH = 32,
    parameter DEPTH = 64
) (
    input       wire     [WIDTH-1:0]     A,
    input       wire     [WIDTH-1:0]     WD,
    input       wire                     WE,
    input       wire                     clk,
    input       wire                     rst_n,
    output      wire      [WIDTH-1:0]     RD
);

reg [WIDTH-1:0] mem [0:DEPTH-1]; // Memory array

integer i;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0; i<DEPTH; i=i+1)
            mem[i] <= 0;
    end
    else if(WE)
        mem[A[7:2]] <= WD;
end

assign RD = mem[A[7:2]]; // Asynchronous read access

endmodule