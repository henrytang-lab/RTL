set SIM_DIR "<ENTER simulation DIRECTORY PATH HERE>"
# Example:
# set SIM_DIR "D:\rd1140_i2c_slave_controller\rd1140\simulation"
cd $SIM_DIR/ice40/verilog
if {![file exists rtl_verilog]} {
vlib rtl_verilog
}
endif

design create rtl_verilog .
design open rtl_verilog
adel -all
cd $SIM_DIR/ice40/verilog
vlog ../../../source/verilog/i2cslave_controller_top.v
vlog ../../../source/verilog/i2cslave_controller.v

vlog ../../../testbench/verilog/i2cslave_controller_tb.v

asim -O5 -L ovi_ice -PL pmi_work +access +r i2cslave_controller_tb
#add wave *
add wave /i2cslave_controller_tb/*
run -all
