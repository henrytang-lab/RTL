quietly set ACTELLIBNAME ProASIC3
quietly set PROJECT_DIR "C:/Project/7000-0300 PWA SEED DRIVER/SPI_Serial_Peripheral_Interface_Verilog_Modules-main/SPI"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap proasic3 "C:/Microsemi/Libero_SoC_v11.9/Designer/lib/modelsim/precompiled/vlog/proasic3"

vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/spi_clgen.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/spi_shift_reg.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/spi_top.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/spi_slave.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/wishbone_master.v"
vlog "+incdir+${PROJECT_DIR}/hdl" "+incdir+${PROJECT_DIR}/stimulus" -vlog01compat -work presynth "${PROJECT_DIR}/stimulus/tb.v"

vsim -L proasic3 -L presynth  -t 1ps presynth.tb
add wave /tb/*
run 1000ns
