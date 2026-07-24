    I2C Slave Controller Reference Design
=====================================================================================

File List :

1.  \rd1140\docs\rd1140.pdf                                        									--> rd1140 document
    \rd1140\docs\rd1140_readme.txt                                 									--> read me file (this file)
	\rd1140\docs\revision_history.xls																--> Revision History
	
2.  \rd1140\project\ice40\verilog\ice40_verilog_lse.prj												--> iCEcube2 project strategy file 
	\rd1140\project\ice40\verilog\ice40_verilog_sbt.project                               			--> iCEcube2 project file
    \rd1140\project\ice40\verilog\ice40_timing.sdc                                 				--> Timing constraint file
	
3.  \rd1140\simulation\ice40\verilog\rtl_verilog.do				 		          					--> RTL simulation script file for verilog
	\rd1140\simulation\ice40\verilog\timing_verilog.do			 		          					--> Timing simulation script file for verilog  
	
4.  \rd1140\source\verilog\i2cslave_controller_top.v                             					-->  Verilog source code file
    \rd1140\source\verilog\i2cslave_controller.v                                      				-->  Verilog source code file
	
5.  \rd1140\testbench\verilog\i2cslave_controller_tb.v                     							-->  Verilog testbench for simulation
    \rd1140\testbench\verilog\testcase.v															-->  Verilog testbench file
	\rd1140\testbench\verilog\tasks.v																-->  Verilog testbench file
===================================================================================================  
Using iCEcube2 Software
---------------------------------------------------------------------------------------------------  
HOW TO CREATE A PROJECT IN iCEcube2:
1. Launch iCEcube2 software, in the GUI, select Project >> New Project.
2. In the New Project popup, select the Project Directory and provide a Project name. Select appropriate device. Click Next
3. Add the necessary source files from the rd1140\source\verilog directory. 
4. Click Finish. Now the project is successfully created. 
5. Under P&R Flow> Add P&R Input Files> Constraint Files, right click and select Add Files.
	Add the timing constraint file from the location rd1139\project\ice40\verilog directory.
----------------------------------------------------------------------------------------------------      
HOW TO RUN SIMULATION UNDER iCEcube2:
1. Bring up the Simulation Wizard by clicking on the Active HDL icon. 
2. Next provide a name for simulation project, and select RTL or post-route simulation
	2.1 For post-route simulation, must export verilog or vhdl simulation file after Place and Route
3. Next add the test bench files form the rd1140\testBench\verilog directory. Click Next.
	3.1 For VHDL, make sure the top-level test bench is last to be added
4. Next click Finish, this will bring up the Aldec simulator automatically
5. In Aldec environment, you can manually activate the simulation or you can use a script
	5.1 Use the provided script in the rd1140\Simulation\ice40\verilog directory
	  a. For functional simulation, 
			i) Open the rtl_verilog.do file and provide the path to the simulation folder in the rtl_verilog.do file	
	  b. For POST-ROUTE simulation, open the script and change the following:
			i) Run the Place and Route in iCEcube2 to generate the verilog netlist file and the timing delay file required for timing simulations.
			ii) Provide the path to the simulation folder in the timing_verilog.do file
	  c. Click Tools > Execute Macro and select the xxx.do file to run the simulation
	  d. This will run the simulation until finish
	5.2 Manually activate the simulation
		a. Click Design> Compile All
		b. Click Design> Settings.In the Design Settings Window,General > Top-level, select the top level testbench in the right column and click Apply
		c. Click Simulation > Initialize Simulation
		d. Click File > New > Waveform, this will bring up the Waveform panel
		c. Click on the top-level testbench, drag all the signals into the Waveform panel
		d. At the Console panel, type "run 5500us" for VHDL simulation, or "run -all" for Verilog 
		   simulation
		e. For timing simulation, Run the Place and Route for the Project in the iCEcube2 software for generating the sbt.v and sdf files
6. Simulation Test Result "SBT_Pass" or "SBT_Fail" will appear, depending upon the simulation results.
                      







































