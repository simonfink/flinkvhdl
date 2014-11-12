# TCL File Generated by Component Editor 13.0sp1
# Wed Nov 12 13:34:57 CET 2014
# DO NOT MODIFY


# 
# adcad7606_4 "ADCAD7606_4" v0.1.0
# NTB (ch.ntb.inf) 2014.11.12.13:34:57
# Interface for adc ad7606-4
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module adcad7606_4
# 
set_module_property DESCRIPTION "Interface for adc ad7606-4"
set_module_property NAME adcad7606_4
set_module_property VERSION 0.1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP fLink/ADC
set_module_property AUTHOR "NTB (ch.ntb.inf)"
set_module_property DISPLAY_NAME ADCAD7606_4
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL avalon_adcad7606_4_interface
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file avalon_adcad7606_4_interface.m.vhd VHDL PATH avalon_adcad7606_4_interface.m.vhd TOP_LEVEL_FILE
add_fileset_file flink_definitions.vhd VHDL PATH ../../../../fLink/core/flink_definitions.vhd
add_fileset_file adcad7606_4.m.vhd VHDL PATH ../../../../functionalBlocks/adcad7606_4/src/adcad7606_4.m.vhd
add_fileset_file spi_master.m.vhd VHDL PATH ../../../../functionalBlocks/spi_master/src/spi_master.m.vhd


# 
# parameters
# 
add_parameter BASE_CLK INTEGER 33000000 ""
set_parameter_property BASE_CLK DEFAULT_VALUE 33000000
set_parameter_property BASE_CLK DISPLAY_NAME BASE_CLK
set_parameter_property BASE_CLK TYPE INTEGER
set_parameter_property BASE_CLK UNITS None
set_parameter_property BASE_CLK ALLOWED_RANGES -2147483648:2147483647
set_parameter_property BASE_CLK DESCRIPTION ""
set_parameter_property BASE_CLK HDL_PARAMETER true
add_parameter SCLK_FREQUENCY INTEGER 10000000 ""
set_parameter_property SCLK_FREQUENCY DEFAULT_VALUE 10000000
set_parameter_property SCLK_FREQUENCY DISPLAY_NAME SCLK_FREQUENCY
set_parameter_property SCLK_FREQUENCY TYPE INTEGER
set_parameter_property SCLK_FREQUENCY UNITS None
set_parameter_property SCLK_FREQUENCY ALLOWED_RANGES -2147483648:2147483647
set_parameter_property SCLK_FREQUENCY DESCRIPTION ""
set_parameter_property SCLK_FREQUENCY HDL_PARAMETER true
add_parameter UNICE_ID STD_LOGIC_VECTOR 0
set_parameter_property UNICE_ID DEFAULT_VALUE 0
set_parameter_property UNICE_ID DISPLAY_NAME UNICE_ID
set_parameter_property UNICE_ID TYPE STD_LOGIC_VECTOR
set_parameter_property UNICE_ID UNITS None
set_parameter_property UNICE_ID ALLOWED_RANGES 0:4294967295
set_parameter_property UNICE_ID HDL_PARAMETER true


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
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock_sink
set_interface_property avalon_slave associatedReset reset_sink
set_interface_property avalon_slave bitsPerSymbol 8
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 0
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitTime 1
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave writeWaitTime 0
set_interface_property avalon_slave ENABLED true
set_interface_property avalon_slave EXPORT_OF ""
set_interface_property avalon_slave PORT_NAME_MAP ""
set_interface_property avalon_slave SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave islv_avs_address address Input 5
add_interface_port avalon_slave islv_avs_write_data writedata Input 32
add_interface_port avalon_slave osl_avs_waitrequest waitrequest Output 1
add_interface_port avalon_slave oslv_avs_read_data readdata Output 32
add_interface_port avalon_slave isl_avs_write write Input 1
add_interface_port avalon_slave isl_avs_read read Input 1
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0


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

add_interface_port conduit_end osl_adc_reset export Output 1
add_interface_port conduit_end osl_mosi export Output 1
add_interface_port conduit_end osl_range export Output 1
add_interface_port conduit_end osl_sclk export Output 1
add_interface_port conduit_end osl_stby_n export Output 1
add_interface_port conduit_end oslv_conv_start export Output 2
add_interface_port conduit_end oslv_os export Output 3
add_interface_port conduit_end oslv_Ss export Output 1
add_interface_port conduit_end isl_miso export Input 1
add_interface_port conduit_end isl_first_data export Input 1
add_interface_port conduit_end isl_d_out_b export Input 1
add_interface_port conduit_end isl_busy export Input 1

