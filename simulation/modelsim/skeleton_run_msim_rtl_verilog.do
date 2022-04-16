transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/skeleton.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/dmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/imem.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/frequency_divider_by2.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/pc.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/unsignedExtension.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/signExtension.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/getInsnType.v}
vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/adder32.v}

vlog -vlog01compat -work work +incdir+C:/Users/wg83/Desktop/ECE\ 550/processor\ 3_1112_testManycases {C:/Users/wg83/Desktop/ECE 550/processor 3_1112_testManycases/testProcessor_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testProcessor_tb

add wave *
view structure
view signals
run -all
