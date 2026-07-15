module MUX_2X1 #(
    parameter WIDTH = 32
) (
    input       wire     [WIDTH-1:0]     A,
    input       wire     [WIDTH-1:0]     B,
    input       wire                     Sel,
    output      reg      [WIDTH-1:0]     Y
);

always @(*) begin
    case(Sel)
        1'b0:   Y = A;
        1'b1:   Y = B;
        default: Y = {WIDTH{1'b0}};
    endcase
end 

endmodule