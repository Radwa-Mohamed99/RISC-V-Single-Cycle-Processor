/*
------------------------------------------------------------
Module Name : Reg_File

Description :
- A register file used in the RISC-V processor.
- Contains 32 registers, each with 32-bit width.
- Provides two asynchronous read ports (RD1 and RD2).
- Provides one synchronous write port (WD3).
- The register data is written on the rising edge of the clock
  when the write enable signal (WE3) is high.
- Supports simultaneous reading from two registers and writing
  to one register.
- Register x0 is always read as zero according to RISC-V standard.

------------------------------------------------------------
*/

module Reg_File #(
    parameter WIDTH = 32,
    parameter DEPTH = 32,
    parameter ADDR_WIDTH = $clog2(DEPTH)
) (
    input       wire       [ADDR_WIDTH-1:0]       A1, // Address of the first register to read
    input       wire       [ADDR_WIDTH-1:0]       A2, // Address of the second register to read
    input       wire       [ADDR_WIDTH-1:0]       A3, // Address of the register to write
    input       wire       [WIDTH-1:0]            WD3,// Data to write to the register file
    input       wire                              clk,
    input       wire                              rst_n,
    input       wire                              WE3,// Write Enable for the register file
    output      reg       [WIDTH-1:0]             RD1,// Data read from the first  registers
    output      reg       [WIDTH-1:0]             RD2 // Data read from the second registers
);

reg [WIDTH-1:0] RAM [0:DEPTH-1]; // Register file array

// write synchronously
integer i;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0;i<DEPTH;i=i+1)
            RAM[i] <= 0;
    end
    else if(WE3 && (A3!=0))
        RAM[A3] <= WD3;
end

// read asynchronously
always @(*) begin
    RD1 = (A1 == 0) ? {WIDTH{1'b0}} : RAM[A1];
    RD2 = (A2 == 0) ? {WIDTH{1'b0}} : RAM[A2]; 
end
endmodule