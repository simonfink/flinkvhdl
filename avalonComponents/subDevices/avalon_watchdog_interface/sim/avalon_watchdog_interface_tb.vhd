-------------------------------------------------------------------------------
--     ____  _____          __    __    ________    _______
--    |    | \    \        |   \ |  |  |__    __|  |   __  \
--    |____|  \____\       |    \|  |     |  |     |  |__>  ) 
--     ____   ____         |  |\ \  |     |  |     |   __  <
--    |    | |    |        |  | \   |     |  |     |  |__>  )
--    |____| |____|        |__|  \__|     |__|     |_______/
--
--    NTB University of Applied Sciences in Technology
--
--    Campus Buchs - Werdenbergstrasse 4 - 9471 Buchs - Switzerland
--    Campus Waldau - Schoenauweg 4 - 9013 St. Gallen - Switzerland
--
--    Web http://www.ntb.ch        Tel. +41 81 755 33 11
--
-------------------------------------------------------------------------------
-- Copyright 2013 NTB University of Applied Sciences in Technology
-------------------------------------------------------------------------------
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
-- 
-- http://www.apache.org/licenses/LICENSE-2.0
--   
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL;

USE work.fLink_definitions.ALL;
USE work.avalon_watchdog_interface_pkg.ALL;

ENTITY avalon_watchdog_interface_tb IS
END ENTITY avalon_watchdog_interface_tb;

ARCHITECTURE sim OF avalon_watchdog_interface_tb IS
	
	CONSTANT main_period : TIME := 8 ns; -- 125MHz
	CONSTANT number_of_watchdogs : INTEGER := 1;
	CONSTANT unique_id: STD_LOGIC_VECTOR (c_fLink_avs_data_width-1 DOWNTO 0) := x"00007764"; --wd

	SIGNAL sl_clk					: STD_LOGIC := '0';
	SIGNAL sl_reset_n				: STD_LOGIC := '1';
	SIGNAL slv_avs_address		: STD_LOGIC_VECTOR (c_watchdog_interface_address_width-1 DOWNTO 0):= (OTHERS =>'0');
	SIGNAL sl_avs_read			: STD_LOGIC:= '0';
	SIGNAL sl_avs_write			: STD_LOGIC:= '0';
	SIGNAL slv_avs_write_data	: STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 DOWNTO 0):= (OTHERS =>'0');
	SIGNAL slv_avs_read_data	: STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 DOWNTO 0):= (OTHERS =>'0');
	SIGNAL sl_watchdog_pwm			: STD_LOGIC := '0';
	SIGNAL sl_granted			: STD_LOGIC := '0';
	SIGNAL slv_avs_byteenable	: STD_LOGIC_VECTOR(c_fLink_avs_data_width_in_byte-1 DOWNTO 0) := (OTHERS =>'1');
	
	
	
BEGIN
	--create component
	my_unit_under_test : avalon_watchdog_interface 
	GENERIC MAP(
		base_clk => 125000000,
		unique_id => unique_id
	)
	PORT MAP(
			isl_clk					=> sl_clk,
			isl_reset_n				=> sl_reset_n,
			islv_avs_address 		=> slv_avs_address,
			isl_avs_read 			=> sl_avs_read,
			isl_avs_write			=> sl_avs_write,
			islv_avs_write_data		=> slv_avs_write_data,
			islv_avs_byteenable		=> slv_avs_byteenable,
			oslv_avs_read_data		=> slv_avs_read_data,
			osl_watchdog_pwm 		=> sl_watchdog_pwm,	
			osl_granted				=> sl_granted
		
	);
	
	
	sl_clk 		<= NOT sl_clk after main_period/2;

	tb_main_proc : PROCESS
	BEGIN
			sl_reset_n	<=	'1';
		WAIT FOR 100*main_period;
			sl_reset_n	<=	'0';
		WAIT FOR 100*main_period;
			sl_reset_n	<=	'1';
		WAIT FOR main_period/2;		

--test id register:
		WAIT FOR 10*main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(to_unsigned(c_fLink_typdef_address,c_watchdog_interface_address_width));				
		WAIT FOR main_period;
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data(c_fLink_interface_version_length-1 DOWNTO 0) = STD_LOGIC_VECTOR(to_unsigned(c_watchdog_interface_version,c_fLink_interface_version_length)) 
			REPORT "Interface Version Missmatch" SEVERITY FAILURE;
			
			ASSERT slv_avs_read_data(c_fLink_interface_version_length+c_fLink_subtype_length-1 DOWNTO c_fLink_interface_version_length) = STD_LOGIC_VECTOR(to_unsigned(c_watchdog_subtype_id,c_fLink_subtype_length)) 
			REPORT "Subtype ID Missmatch" SEVERITY FAILURE;

			ASSERT slv_avs_read_data(c_fLink_avs_data_width-1 DOWNTO c_fLink_interface_version_length+c_fLink_interface_version_length) = STD_LOGIC_VECTOR(to_unsigned(c_fLink_watchdog_id,c_fLink_id_length)) 
			REPORT "Type ID Missmatch" SEVERITY FAILURE;

--test mem size register register:
		WAIT FOR 10*main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(to_unsigned(c_fLink_mem_size_address,c_watchdog_interface_address_width));
		WAIT FOR main_period;
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT to_integer(UNSIGNED(slv_avs_read_data)) = 4*INTEGER(2**c_watchdog_interface_address_width)
			REPORT "Memory Size Error: "&INTEGER'IMAGE(4*INTEGER(2**number_of_watchdogs))&"/"&INTEGER'IMAGE(to_integer(UNSIGNED(slv_avs_read_data))) 				SEVERITY FAILURE;

--test number of chanels register:
		WAIT FOR 10*main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(to_unsigned(c_fLink_number_of_channels_address,c_watchdog_interface_address_width));				
		WAIT FOR main_period;
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data(c_fLink_interface_version_length-1 DOWNTO 0) = STD_LOGIC_VECTOR(to_unsigned(number_of_watchdogs,c_fLink_interface_version_length)) 
			REPORT "Number of Channels Error" SEVERITY FAILURE;

--test unic id register:
		WAIT FOR 10*main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(to_unsigned(c_fLink_unique_id_address,c_watchdog_interface_address_width));
		WAIT FOR main_period;
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data = unique_id
			REPORT "Unic Id Error" SEVERITY FAILURE;
			
--test base clock register
		WAIT FOR 10*main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_base_clk_address);
		WAIT FOR main_period;	
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data(c_fLink_interface_version_length-1 DOWNTO 0) = STD_LOGIC_VECTOR(to_unsigned(125000000,c_fLink_interface_version_length)) 
			REPORT "Base clock Error" SEVERITY FAILURE;
--test status register
		WAIT FOR 10*main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_wd_status_conf_address);
		WAIT FOR main_period;	
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data(c_int_status_bit) = '0' REPORT "osl_granted should be zero at this point" SEVERITY FAILURE;
			ASSERT slv_avs_read_data(c_int_rearm_bit) = '0' REPORT "Rearm not set to zero after reset" SEVERITY FAILURE;
-- test set counter register 
		WAIT FOR 10*main_period;
			sl_avs_write <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_counter_address);
			slv_avs_write_data <= STD_LOGIC_VECTOR(to_unsigned(100,c_fLink_avs_data_width));
		WAIT FOR main_period;	
			sl_avs_write <= '0';
			slv_avs_address <= (OTHERS =>'0');
			slv_avs_write_data <= (OTHERS =>'0');
		WAIT FOR main_period;	
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_counter_address);
		WAIT FOR main_period;
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data = STD_LOGIC_VECTOR(to_unsigned(100,c_fLink_avs_data_width))
			REPORT "counter not stayed at set value" SEVERITY FAILURE;
--rearm 
		WAIT FOR 10*main_period;
			sl_avs_write <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_wd_status_conf_address);
			slv_avs_write_data(c_int_rearm_bit) <= '1';
		WAIT FOR main_period;	
			sl_avs_write <= '0';
			slv_avs_address <= (OTHERS =>'0');
			slv_avs_write_data <= (OTHERS =>'0');
		WAIT FOR main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_wd_status_conf_address);
		WAIT FOR main_period;	
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data(c_int_status_bit) = '1' REPORT "osl_granted should be set at this point" SEVERITY FAILURE;
			ASSERT slv_avs_read_data(c_int_rearm_bit) = '0' REPORT "Rearm not set because self clearing" SEVERITY FAILURE;
-- set counter again
		WAIT FOR 10*main_period;
			sl_avs_write <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_counter_address);
			slv_avs_write_data <= STD_LOGIC_VECTOR(to_unsigned(100,c_fLink_avs_data_width));
		WAIT FOR main_period;	
			sl_avs_write <= '0';
			slv_avs_address <= (OTHERS =>'0');
			slv_avs_write_data <= (OTHERS =>'0');
-- test granted again
		WAIT FOR 10*main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_wd_status_conf_address);
		WAIT FOR main_period;	
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data(c_int_status_bit) = '1' REPORT "osl_granted should be set at this point" SEVERITY FAILURE;
			ASSERT slv_avs_read_data(c_int_rearm_bit) = '0' REPORT "Rearm not set because self clearing" SEVERITY FAILURE;
-- write counter again to see if pwm chages
		WAIT FOR 10*main_period;
			sl_avs_write <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_counter_address);
			slv_avs_write_data <= STD_LOGIC_VECTOR(to_unsigned(100,c_fLink_avs_data_width));
		WAIT FOR main_period;	
			sl_avs_write <= '0';
			slv_avs_address <= (OTHERS =>'0');
			slv_avs_write_data <= (OTHERS =>'0');
-- read counter
		WAIT FOR 10*main_period;	
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_counter_address);
		WAIT FOR main_period;
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');

-- wait and see if osl_granted goes low
		WAIT FOR 91*main_period;
			sl_avs_read <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_wd_status_conf_address);
		WAIT FOR main_period;	
			sl_avs_read <= '0';
			slv_avs_address <= (OTHERS =>'0');
			ASSERT slv_avs_read_data(c_int_status_bit) = '0' REPORT "osl_granted should be zero at this point" SEVERITY FAILURE;
			ASSERT slv_avs_read_data(c_int_rearm_bit) = '0' REPORT "Rearm not set because self clearing" SEVERITY FAILURE;
-- rearm and then reset and see what happends: 
		WAIT FOR 100*main_period;
			sl_avs_write <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_counter_address);
			slv_avs_write_data <= STD_LOGIC_VECTOR(to_unsigned(100,c_fLink_avs_data_width));
		WAIT FOR main_period;	
			sl_avs_write <= '0';
			slv_avs_address <= (OTHERS =>'0');
			slv_avs_write_data <= (OTHERS =>'0');
		WAIT FOR 10*main_period;
			sl_avs_write <= '1';
			slv_avs_address <= STD_LOGIC_VECTOR(c_usig_wd_status_conf_address);
			slv_avs_write_data(c_int_rearm_bit) <= '1';
		WAIT FOR main_period;	
			sl_avs_write <= '0';
			slv_avs_address <= (OTHERS =>'0');
			slv_avs_write_data <= (OTHERS =>'0');
		WAIT FOR 20*main_period;
			sl_reset_n	<=	'0';
		WAIT FOR 100*main_period;
			sl_reset_n	<=	'1';


		WAIT FOR 1000*main_period;
			ASSERT false REPORT "End of simulation" SEVERITY FAILURE;
	END PROCESS tb_main_proc;

END ARCHITECTURE sim;

