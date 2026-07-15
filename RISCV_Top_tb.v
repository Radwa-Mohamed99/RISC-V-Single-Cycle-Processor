`timescale 1ns/1ps

module RISCV_Top_tb;

reg clk;
reg rst_n;
integer i;

//====================================================
// Instantiate DUT
//====================================================
RISCV_Top DUT (
    .clk(clk),
    .rst_n(rst_n)
);

//====================================================
// Clock Generation
//====================================================
always #5 clk = ~clk;

//====================================================
// Initialization
//====================================================
initial begin
    clk   = 0;
    rst_n = 0;

    // Load Program
    $readmemh("program.txt", DUT.Instruction_Mem.ROM);

    #20;
    rst_n = 1;
end

//====================================================
// Monitor
//====================================================
initial begin
    $monitor(
    "t=%0t | PC=%h | Instr=%h | RD1=%0d | RD2=%0d | Imm=%0d | ALUCtrl=%b | ALU=%0d | Result=%0d | Zero=%b | Branch=%b | PCSrc=%b",
    $time,
    DUT.PC,
    DUT.Instr,
    $signed(DUT.RD1),
    $signed(DUT.RD2),
    $signed(DUT.ImmExt),
    DUT.ALUControl,
    $signed(DUT.ALUResult),
    $signed(DUT.Result),
    DUT.Zero,
    DUT.Branch,
    DUT.PCSrc
    );
end

//====================================================
// Print Final Results
//====================================================
initial begin

    #1000;

    $display("\n======================================");
    $display("      Final Register File");
    $display("======================================");

    for(i=0;i<8;i=i+1)
        $display("x%0d = %0d", i, DUT.Register_File.RAM[i]);

    $display("\n======================================");
    $display("      Final Data Memory");
    $display("======================================");

    for(i=0;i<10;i=i+1)
        $display("MEM[%0d] = %0d", i, DUT.Data_Mem.mem[i]);

    $display("\n======================================");

    $stop;

end

endmodule