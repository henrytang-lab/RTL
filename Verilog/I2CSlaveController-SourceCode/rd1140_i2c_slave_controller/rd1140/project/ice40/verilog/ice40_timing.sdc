# ##############################################################################

# iCEcube SDC

# Version:            2014.08.26723

# File Generated:     Jan 7 2015 18:28:41

# ##############################################################################

####---- CreateClock list ----2
create_clock  -period 2500.00 -name {i_scl} [get_ports {i_scl}] 
create_clock  -period 31.00 -name {i_sys_clk} [get_ports {i_sys_clk}] 

