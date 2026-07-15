module Adder_32B #(
    parameter WIDTH = 32
) (
    input       wire     [WIDTH-1:0]     A,
    input       wire     [WIDTH-1:0]     B,
    output      wire     [WIDTH-1:0]     Sum
);

assign Sum = A + B;

endmodule