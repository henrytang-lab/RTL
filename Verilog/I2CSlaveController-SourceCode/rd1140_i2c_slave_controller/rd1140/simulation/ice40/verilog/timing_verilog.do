set SIM_DIR "<ENTER simulation DIRECTORY PATH HERE>"
# Example:
# set SIM_DIR "D:\rd1140_i2c_slave_controller\rd1140\simulation"
cd $SIM_DIR/ice40/verilog
if {![file exists timing_verilog]} {
vlib timing_verilog
}
endif

design create timing_verilog .
design open timing_verilog
adel -all


cd $SIM_DIR/ice40/verilog

#####Run the Place and Route for the Project in the iCEcube2 software for generating the below mentioned sbt.v and sdf files######

vlog ../../../project/ice40/verilog/ice40_verilog_Implmnt/sbt/outputs/simulation_netlist/i2cslave_controller_top_sbt.v
vlog ../../../testbench/verilog/i2cslave_controller_tb.v

vsim -L ovi_ice_timing -PL pmi_work +access +r i2cslave_controller_tb -noglitch +no_tchk_msg -sdfmax /i2cslave_controller_tb/i2cslave_controller_tb_u1 = "../../../project/ice40/verilog/ice40_verilog_Implmnt/sbt/outputs/simulation_netlist/i2cslave_controller_top_sbt.sdf"

add wave /i2cslave_controller_tb/*

run -all
