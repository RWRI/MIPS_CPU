transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD05/Trabalho2/MIPS_CPU/PC {D:/UNIFEI/7Periodo/ELTD05/Trabalho2/MIPS_CPU/PC/pc.v}

vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD05/Trabalho2/MIPS_CPU/PC {D:/UNIFEI/7Periodo/ELTD05/Trabalho2/MIPS_CPU/PC/pc_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  pc_TB

add wave *
view structure
view signals
run -all
