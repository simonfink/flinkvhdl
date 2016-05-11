# TCL File Generated by Component Editor 13.0sp1
# Wed Apr 20 09:22:16 CEST 2016
# DO NOT MODIFY


# 
# pwm_device "PWM Device" v1.0
#  2016.04.20.09:22:16
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module pwm_device
# 
set_module_property DESCRIPTION ""
set_module_property NAME pwm_device
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP fLink/axi/subDevices
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME "PWM Device"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL pwm_device
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file pwm_device.m.vhd VHDL PATH pwm_device.m.vhd TOP_LEVEL_FILE
add_fileset_file axi_slave.m.vhd VHDL PATH ../../axiSlave/src/axi_slave.m.vhd
add_fileset_file adjustable_pwm.m.vhd VHDL PATH ../../../../functionalBlocks/adjustable_pwm/src/adjustable_pwm.m.vhd
add_fileset_file flink_definitions.vhd VHDL PATH ../../../../fLink/core/flink_definitions.vhd


# 
# parameters
# 
add_parameter number_of_pwms INTEGER 1 "Number of pwms which will be generated"
set_parameter_property number_of_pwms DEFAULT_VALUE 1
set_parameter_property number_of_pwms DISPLAY_NAME number_of_pwms
set_parameter_property number_of_pwms TYPE INTEGER
set_parameter_property number_of_pwms UNITS None
set_parameter_property number_of_pwms ALLOWED_RANGES -2147483648:2147483647
set_parameter_property number_of_pwms DESCRIPTION "Number of pwms which will be generated"
set_parameter_property number_of_pwms HDL_PARAMETER true
add_parameter base_clk INTEGER 125000000 "Clock frequency which is used on the clock input signal of this block"
set_parameter_property base_clk DEFAULT_VALUE 125000000
set_parameter_property base_clk DISPLAY_NAME base_clk
set_parameter_property base_clk TYPE INTEGER
set_parameter_property base_clk UNITS None
set_parameter_property base_clk ALLOWED_RANGES -2147483648:2147483647
set_parameter_property base_clk DESCRIPTION "Clock frequency which is used on the clock input signal of this block"
set_parameter_property base_clk HDL_PARAMETER true
add_parameter unique_id STD_LOGIC_VECTOR 0 "Unique ID"
set_parameter_property unique_id DEFAULT_VALUE 0
set_parameter_property unique_id DISPLAY_NAME unique_id
set_parameter_property unique_id WIDTH 32
set_parameter_property unique_id TYPE STD_LOGIC_VECTOR
set_parameter_property unique_id UNITS None
set_parameter_property unique_id ALLOWED_RANGES 0:4294967295
set_parameter_property unique_id DESCRIPTION "Unique ID"
set_parameter_property unique_id HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink axi_aclk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink axi_areset_n reset_n Input 1


# 
# connection point altera_axi4_slave
# 
add_interface altera_axi4_slave axi4 end
set_interface_property altera_axi4_slave associatedClock clock_sink
set_interface_property altera_axi4_slave associatedReset reset_sink
set_interface_property altera_axi4_slave readAcceptanceCapability 1
set_interface_property altera_axi4_slave writeAcceptanceCapability 1
set_interface_property altera_axi4_slave combinedAcceptanceCapability 1
set_interface_property altera_axi4_slave readDataReorderingDepth 1
set_interface_property altera_axi4_slave bridgesToMaster ""
set_interface_property altera_axi4_slave ENABLED true
set_interface_property altera_axi4_slave EXPORT_OF ""
set_interface_property altera_axi4_slave PORT_NAME_MAP ""
set_interface_property altera_axi4_slave SVD_ADDRESS_GROUP ""

add_interface_port altera_axi4_slave axi_awaddr awaddr Input 7
add_interface_port altera_axi4_slave axi_awlen awlen Input 8
add_interface_port altera_axi4_slave axi_awsize awsize Input 3
add_interface_port altera_axi4_slave axi_awburst awburst Input 2
add_interface_port altera_axi4_slave axi_awvalid awvalid Input 1
add_interface_port altera_axi4_slave axi_awready awready Output 1
add_interface_port altera_axi4_slave axi_wdata wdata Input 32
add_interface_port altera_axi4_slave axi_wstrb wstrb Input 4
add_interface_port altera_axi4_slave axi_wvalid wvalid Input 1
add_interface_port altera_axi4_slave axi_wready wready Output 1
add_interface_port altera_axi4_slave axi_araddr araddr Input 7
add_interface_port altera_axi4_slave axi_arvalid arvalid Input 1
add_interface_port altera_axi4_slave axi_arready arready Output 1
add_interface_port altera_axi4_slave axi_arid arid Input 1
add_interface_port altera_axi4_slave axi_arlen arlen Input 8
add_interface_port altera_axi4_slave axi_arsize arsize Input 3
add_interface_port altera_axi4_slave axi_arburst arburst Input 2
add_interface_port altera_axi4_slave axi_rdata rdata Output 32
add_interface_port altera_axi4_slave axi_rresp rresp Output 2
add_interface_port altera_axi4_slave axi_rvalid rvalid Output 1
add_interface_port altera_axi4_slave axi_rready rready Input 1
add_interface_port altera_axi4_slave axi_rid rid Output 1
add_interface_port altera_axi4_slave axi_rlast rlast Output 1
add_interface_port altera_axi4_slave axi_bresp bresp Output 2
add_interface_port altera_axi4_slave axi_bvalid bvalid Output 1
add_interface_port altera_axi4_slave axi_bready bready Input 1
add_interface_port altera_axi4_slave axi_bid bid Output 1
add_interface_port altera_axi4_slave axi_awid awid Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock_sink
set_interface_property conduit_end associatedReset reset_sink
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end oslv_pwm export Output number_of_pwms
