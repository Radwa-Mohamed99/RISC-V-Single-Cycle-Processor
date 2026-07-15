/*
------------------------------------------------------------
Module Name : PC_Reg

Description :
- 32-bit Program Counter (PC) register.
- Stores the address of the current instruction.
- Loads the next program counter value (PCNext) on the rising
  edge of the clock when the load signal is asserted.
- Supports an active-low asynchronous reset that clears the
  program counter to zero.
------------------------------------------------------------
*/

module PC_Reg #(
    parameter WIDTH = 32
) (
    input       wire       [WIDTH-1:0]       PCNext,
    input       wire                         load,
    input       wire                         clk,
    input       wire                         rst_n,
    output      reg       [WIDTH-1:0]        PC
);
    
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        PC <= {WIDTH{1'b0}};
    end else if(load) begin
        PC <= PCNext;
    end
end 
endmodule