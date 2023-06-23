transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {extend_min_1200mv_-40c_fast.vo}

vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD05/Trabalho2/MIPS_CPU/Extend {D:/UNIFEI/7Periodo/ELTD05/Trabalho2/MIPS_CPU/Extend/extend_TB.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_mf_ver -L altera_ver -L lpm_ver -L sgate_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L gate_work -L work -voptargs="+acc"  extend_TB

add wave *
view structure
view signals
run -all
