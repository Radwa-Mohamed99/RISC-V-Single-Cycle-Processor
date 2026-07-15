vsim -voptargs=+acc work.RISCV_Top_tb
add wave -r sim:/RISCV_Top_tb/DUT/*
run -all