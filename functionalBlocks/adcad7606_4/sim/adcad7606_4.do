transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {../../spi_master/src/spi_master.m.vhd}
vcom -93 -work work {../src/adcad7606_4.m.vhd}
vcom -93 -work work {../sim/adcad7606_4_rtl_tb.vhd}

vsim -t 1ps -L rtl_work -L work -voptargs="+acc" adcad7606_4_rtl_tb

if {[file exists wave.do]} {
	do wave.do 
}

view structure
view signals
run 150 ms
