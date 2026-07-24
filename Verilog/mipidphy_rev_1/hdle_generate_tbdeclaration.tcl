lappend auto_path "C:/lscc/diamond/3.13/data/script"
package require tbdeclaration_generation

set ::bali::Para(MODNAME) mipiphy_rev_0
set ::bali::Para(PROJECT) mipidphy_rev_0
set ::bali::Para(PACKAGE) {"C:/lscc/diamond/3.13/cae_library/vhdl_packages/vdbs"}
set ::bali::Para(PRIMITIVEFILE) {"C:/lscc/diamond/3.13/cae_library/synthesis/verilog/lifmd.v"}
set ::bali::Para(TFT) {"C:/lscc/diamond/3.13/data/templates/tfi_f.tft"}
set ::bali::Para(FILELIST) {"C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy.v=work,Verilog_2001" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_dphy_rx.v=work,Verilog_2001" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_dphy_wrapper.v=work,Verilog_2001" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_capture_ctrl_bb.v=work,Verilog_2001" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_dphy_rx_wrap_bb.v=work,Verilog_2001" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_rx_global_ctrl_bb.v=work,Verilog_2001" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy/csi_dphy_soft_dphy_rx_bb.v=work,Verilog_2001" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/mipiphy_rev_0.v=work,Verilog_2001" }
set ::bali::Para(INCLUDEPATH) {"C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0/csi_dphy" "C:/Project/Working/FPGA/HOME/FPGA/mipidphy_rev_0/mipiphy_rev_0" }
puts "set parameters done"
::bali::GenerateTbDeclaration
