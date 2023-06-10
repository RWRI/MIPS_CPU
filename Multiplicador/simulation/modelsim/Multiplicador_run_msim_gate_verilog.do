transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {Multiplicador.vo}

vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD05/Trabalho2/MIPS_CPU/Multiplicador {D:/UNIFEI/7Periodo/ELTD05/Trabalho2/MIPS_CPU/Multiplicador/Multiplicador_TB.v}

vsim -t 1ps -L altera_mf_ver -L altera_ver -L lpm_ver -L sgate_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L gate_work -L work -voptargs="+acc"  Multiplicador_TB

add wave *
view structure
view signals
run -all
