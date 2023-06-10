transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD15/Multiplicador/Counter {D:/UNIFEI/7Periodo/ELTD15/Multiplicador/Counter/Counter.v}
vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD15/Multiplicador/CONTROL {D:/UNIFEI/7Periodo/ELTD15/Multiplicador/CONTROL/CONTROL.v}
vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD15/Multiplicador/Adder {D:/UNIFEI/7Periodo/ELTD15/Multiplicador/Adder/Adder.v}
vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD15/Multiplicador/ACC {D:/UNIFEI/7Periodo/ELTD15/Multiplicador/ACC/ACC.v}
vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD15/Multiplicador {D:/UNIFEI/7Periodo/ELTD15/Multiplicador/Multiplicador.v}

vlog -vlog01compat -work work +incdir+D:/UNIFEI/7Periodo/ELTD15/Multiplicador {D:/UNIFEI/7Periodo/ELTD15/Multiplicador/Multiplicador_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  Multiplicador_TB

add wave *
view structure
view signals
run -all
