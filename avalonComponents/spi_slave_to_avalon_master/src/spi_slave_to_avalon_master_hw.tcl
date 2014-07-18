# TCL File Generated by Component Editor 13.0sp1
# Fri Jul 18 11:09:01 CEST 2014
# DO NOT MODIFY


# 
# spi_slave_to_avalon_master "SPI Slave to Avalon Master" v0.1.1
# NTB (ntb.ch.inf) 2014.07.18.11:09:01
# Interface between spi slave and avalon master
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module spi_slave_to_avalon_master
# 
set_module_property DESCRIPTION "Interface between spi slave and avalon master"
set_module_property NAME spi_slave_to_avalon_master
set_module_property VERSION 0.1.1
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP fLink
set_module_property AUTHOR "NTB (ntb.ch.inf)"
set_module_property DISPLAY_NAME "SPI Slave to Avalon Master"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL spi_slave_to_avalon_master
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file spi_slave_to_avalon_master.m.vhd VHDL PATH spi_slave_to_avalon_master.m.vhd TOP_LEVEL_FILE
add_fileset_file flink_definitions.vhd VHDL PATH ../../../fLink/core/flink_definitions.vhd
add_fileset_file spi_slave.m.vhd VHDL PATH ../../../functionalBlocks/spi_slave/src/spi_slave.m.vhd


# 
# parameters
# 
add_parameter TRANSFER_WIDTH INTEGER 8
set_parameter_property TRANSFER_WIDTH DEFAULT_VALUE 8
set_parameter_property TRANSFER_WIDTH DISPLAY_NAME TRANSFER_WIDTH
set_parameter_property TRANSFER_WIDTH TYPE INTEGER
set_parameter_property TRANSFER_WIDTH UNITS None
set_parameter_property TRANSFER_WIDTH ALLOWED_RANGES -2147483648:2147483647
set_parameter_property TRANSFER_WIDTH HDL_PARAMETER true
add_parameter CPOL STD_LOGIC 0
set_parameter_property CPOL DEFAULT_VALUE 0
set_parameter_property CPOL DISPLAY_NAME CPOL
set_parameter_property CPOL TYPE STD_LOGIC
set_parameter_property CPOL UNITS None
set_parameter_property CPOL ALLOWED_RANGES 0:1
set_parameter_property CPOL HDL_PARAMETER true
add_parameter CPHA STD_LOGIC 0
set_parameter_property CPHA DEFAULT_VALUE 0
set_parameter_property CPHA DISPLAY_NAME CPHA
set_parameter_property CPHA TYPE STD_LOGIC
set_parameter_property CPHA UNITS None
set_parameter_property CPHA ALLOWED_RANGES 0:1
set_parameter_property CPHA HDL_PARAMETER true
add_parameter SSPOL STD_LOGIC 0
set_parameter_property SSPOL DEFAULT_VALUE 0
set_parameter_property SSPOL DISPLAY_NAME SSPOL
set_parameter_property SSPOL TYPE STD_LOGIC
set_parameter_property SSPOL UNITS None
set_parameter_property SSPOL ALLOWED_RANGES 0:1
set_parameter_property SSPOL HDL_PARAMETER true


# 
# display items
# 


# 
# connection point avalon_master
# 
add_interface avalon_master avalon start
set_interface_property avalon_master addressUnits SYMBOLS
set_interface_property avalon_master associatedClock clock_sink
set_interface_property avalon_master associatedReset reset_sink
set_interface_property avalon_master bitsPerSymbol 8
set_interface_property avalon_master burstOnBurstBoundariesOnly false
set_interface_property avalon_master burstcountUnits WORDS
set_interface_property avalon_master doStreamReads false
set_interface_property avalon_master doStreamWrites false
set_interface_property avalon_master holdTime 0
set_interface_property avalon_master linewrapBursts false
set_interface_property avalon_master maximumPendingReadTransactions 0
set_interface_property avalon_master readLatency 0
set_interface_property avalon_master readWaitTime 1
set_interface_property avalon_master setupTime 0
set_interface_property avalon_master timingUnits Cycles
set_interface_property avalon_master writeWaitTime 0
set_interface_property avalon_master ENABLED true
set_interface_property avalon_master EXPORT_OF ""
set_interface_property avalon_master PORT_NAME_MAP ""
set_interface_property avalon_master SVD_ADDRESS_GROUP ""

add_interface_port avalon_master oslv_writedata writedata Output 32
add_interface_port avalon_master oslv_write write Output 1
add_interface_port avalon_master islv_readdata readdata Input 32
add_interface_port avalon_master oslv_read read Output 1
add_interface_port avalon_master oslv_address address Output 32
add_interface_port avalon_master islv_waitrequest waitrequest Input 1


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink isl_clk clk Input 1


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

add_interface_port reset_sink isl_reset_n reset_n Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock ""
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end osl_miso export Output 1
add_interface_port conduit_end isl_mosi export Input 1
add_interface_port conduit_end isl_ss export Input 1
add_interface_port conduit_end isl_sclk export Input 1

