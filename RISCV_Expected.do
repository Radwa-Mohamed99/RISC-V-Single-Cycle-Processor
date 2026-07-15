vlib work

vlog ALU_32B.v
vlog ALU_Decoder.v
vlog Branch_Decoder.v
vlog Control_Unit.v
vlog Main_Decoder.v
vlog Data_Memory.v
vlog Instruction_Memory.v
vlog RISCV_Top.v
vlog Next_PC_Calc.v
vlog PC_Reg.v
vlog Reg_File.v
vlog Adder_32B.v
vlog MUX_2X1.v
vlog SignExtend.v
vlog RISCV_Top_tb.v

vsim -voptargs=+acc work.RISCV_Top_tb

add wave sim:/RISCV_Top_tb/DUT/clk

add wave sim:/RISCV_Top_tb/DUT/Register_File/RAM[0]
add wave sim:/RISCV_Top_tb/DUT/Register_File/RAM[1]
add wave sim:/RISCV_Top_tb/DUT/Register_File/RAM[2]
add wave sim:/RISCV_Top_tb/DUT/Register_File/RAM[3]
add wave sim:/RISCV_Top_tb/DUT/Register_File/RAM[4]
add wave sim:/RISCV_Top_tb/DUT/Register_File/RAM[5]
add wave sim:/RISCV_Top_tb/DUT/Register_File/RAM[6]
add wave sim:/RISCV_Top_tb/DUT/Register_File/RAM[7]

add wave sim:/RISCV_Top_tb/DUT/Data_Mem/mem[0]
add wave sim:/RISCV_Top_tb/DUT/Data_Mem/mem[1]
add wave sim:/RISCV_Top_tb/DUT/Data_Mem/mem[2]
add wave sim:/RISCV_Top_tb/DUT/Data_Mem/mem[3]
add wave sim:/RISCV_Top_tb/DUT/Data_Mem/mem[4]
add wave sim:/RISCV_Top_tb/DUT/Data_Mem/mem[5]
add wave sim:/RISCV_Top_tb/DUT/Data_Mem/mem[6]
add wave sim:/RISCV_Top_tb/DUT/Data_Mem/mem[7]

run -all