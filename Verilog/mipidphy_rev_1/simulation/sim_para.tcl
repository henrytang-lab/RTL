lappend auto_path "C:/lscc/diamond/3.13/data/script"
package require simulation_generation
set ::bali::simulation::Para(DEVICEFAMILYNAME) {LIFMD}
set ::bali::simulation::Para(PROJECT) {simulation}
set ::bali::simulation::Para(PROJECTPATH) {C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0}
set ::bali::simulation::Para(FILELIST) {"C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/dphy_rx_eval/csi_dphy/src/beh_rtl/capture_ctrl_beh.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_capture_ctrl.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/dphy_rx_eval/csi_dphy/src/beh_rtl/rx_global_ctrl_beh.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_rx_global_ctrl.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/dphy_rx_eval/csi_dphy/src/beh_rtl/soft_dphy_rx_beh.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_soft_dphy_rx.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_dphy_wrapper.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/dphy_rx_eval/csi_dphy/src/beh_rtl/dphy_rx_wrap_beh.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_dphy_rx_wrap.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_dphy_rx.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/simulation/csi_dphy_tb.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/mipiphy_rev_0.v" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/dphy_rx_eval/testbench/csi_dphy_tb.v" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" "work" }
set ::bali::simulation::Para(COMPLIST) {"VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" }
set ::bali::simulation::Para(LANGSTDLIST) {"Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" "Verilog 2001" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_lifmd}
set ::bali::simulation::Para(MACROLIST) {}
set ::bali::simulation::Para(SIMULATIONTOPMODULE) {tb}
set ::bali::simulation::Para(SIMULATIONINSTANCE) {}
set ::bali::simulation::Para(LANGUAGE) {VERILOG}
set ::bali::simulation::Para(SDFPATH)  {}
set ::bali::simulation::Para(INSTALLATIONPATH) {C:/lscc/diamond/3.13}
set ::bali::simulation::Para(ADDTOPLEVELSIGNALSTOWAVEFORM)  {1}
set ::bali::simulation::Para(RUNSIMULATION)  {1}
set ::bali::simulation::Para(HDLPARAMETERS) {}
set ::bali::simulation::Para(POJO2LIBREFRESH)    {}
set ::bali::simulation::Para(POJO2MODELSIMLIB)   {}
::bali::simulation::ModelSim_Run
