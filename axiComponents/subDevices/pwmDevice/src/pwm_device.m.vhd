-------------------------------------------------------------------------------
--  _________     _____      _____    ____  _____    ___  ____               --
-- |_   ___  |  |_   _|     |_   _|  |_   \|_   _|  |_  ||_  _|              --
--   | |_  \_|    | |         | |      |   \ | |      | |_/ /                --
--   |  _|        | |   _     | |      | |\ \| |      |  __'.                --
--  _| |_        _| |__/ |   _| |_    _| |_\   |_    _| |  \ \_              --
-- |_____|      |________|  |_____|  |_____|\____|  |____||____|             --
--                                                                           --
-------------------------------------------------------------------------------
--                                                                           --
-- Avalon MM interface for FQD                                               --
--                                                                           --
-------------------------------------------------------------------------------
-- Copyright 2014 NTB University of Applied Sciences in Technology           --
--                                                                           --
-- Licensed under the Apache License, Version 2.0 (the "License");           --
-- you may not use this file except in compliance with the License.          --
-- You may obtain a copy of the License at                                   --
--                                                                           --
-- http://www.apache.org/licenses/LICENSE-2.0                                --
--                                                                           --
-- Unless required by applicable law or agreed to in writing, software       --
-- distributed under the License is distributed on an "AS IS" BASIS,         --
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  --
-- See the License for the specific language governing permissions and       --
-- limitations under the License.                                            --
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL;
USE work.fLink_definitions.ALL;
USE work.axi_slave_pkg.ALL;



PACKAGE pwm_device_pkg IS
	CONSTANT c_max_number_of_PWMs : INTEGER := 16; --Depens off the address with and the number of registers per pwm
	CONSTANT c_pwm_interface_address_width				: INTEGER := 7;
	
	
	COMPONENT pwm_device IS
			GENERIC (
				number_of_pwms: INTEGER RANGE 0 TO c_max_number_of_PWMs := 1;--number of pwms which will be generated
				base_clk: INTEGER := 125000000;--clock frequency which is used on the clock input signal of this block
				unique_id: STD_LOGIC_VECTOR (c_fLink_avs_data_width-1 DOWNTO 0) := (OTHERS => '0')--unique id
			);
			PORT (
					-- Clock and Reset
				axi_aclk 		: IN STD_LOGIC;
				axi_areset_n 	: IN STD_LOGIC;
				-- Write Address Channel
				axi_awid 		: IN STD_LOGIC_VECTOR(c_axi_id_width-1 downto 0); -- Write Address ID
				axi_awaddr 		: IN STD_LOGIC_VECTOR(c_pwm_interface_address_width-1 downto 0); -- Write address
				axi_awlen 		: IN STD_LOGIC_VECTOR(7 downto 0); -- Burst length. The burst length gives the exact number of transfers in a burst
				axi_awsize 		: IN STD_LOGIC_VECTOR(2 downto 0); -- Burst size. This signal indicates the size of each transfer in the burst
				axi_awburst 	: IN STD_LOGIC_VECTOR(1 downto 0); -- Burst type. The burst type and the size information, determine how the address for each transfer within the burst is calculated.
				axi_awvalid 	: IN STD_LOGIC; -- Write address valid. This signal indicates that the channel is signaling valid write address and control information.
				axi_awready 	: OUT STD_LOGIC; -- Write address ready. This signal indicates that the slave is ready to accept an address and associated control signals.

				-- Write Data Channel
				axi_wdata 		: IN STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 downto 0); -- Write Data
				axi_wstrb 		: IN STD_LOGIC_VECTOR(3 downto 0); -- Write strobes. This signal indicates which byte lanes hold valid data. There is one write strobe bit for each eight bits of the write data bus.
				axi_wvalid 		: IN STD_LOGIC; -- Write valid. This signal indicates that valid write data and strobes are available.
				axi_wready 		: OUT STD_LOGIC; -- Write ready. This signal indicates that the slave can accept the write data.
				-- Read Address Channel
				axi_araddr 		: IN STD_LOGIC_VECTOR(c_pwm_interface_address_width-1 downto 0); -- Read address. This signal indicates the initial address of a read burst transaction.
				axi_arvalid 	: IN STD_LOGIC; -- Read address valid. This signal indicates that the channel is signaling valid read address and control information.
				axi_arready		: OUT STD_LOGIC; -- Read address ready. This signal indicates that the slave is ready to accept an address and associated  control signals.
				axi_arid 		: IN STD_LOGIC_VECTOR(c_axi_id_width-1 downto 0); -- Read address ID. This signal is the identification tag for the read address group of signals.
				axi_arlen 		: IN STD_LOGIC_VECTOR(7 downto 0); -- Burst length. The burst length gives the exact number of transfers in a burst
				axi_arsize 		: IN STD_LOGIC_VECTOR(2 downto 0); -- Burst size. This signal indicates the size of each transfer in the burst
				axi_arburst 	: IN STD_LOGIC_VECTOR(1 downto 0); -- Burst type. The burst type and the size information,  determine how the address for each transfer within the burst is calculated.
				-- Read Data Channel
				axi_rdata 		: OUT STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 downto 0); -- Read Data
				axi_rresp 		: OUT STD_LOGIC_VECTOR(1 downto 0); -- Read response. This signal indicates the status of the read transfer.
				axi_rvalid 		: OUT STD_LOGIC; -- Read valid. This signal indicates that the channel is signaling the required read data.
				axi_rready 		: IN STD_LOGIC; -- Read ready. This signal indicates that the master can accept the read data and response information
				axi_rid 		: OUT STD_LOGIC_VECTOR(c_axi_id_width-1 downto 0); -- Read ID tag. This signal is the identification tag for the read data group of signals generated by the slave.
				axi_rlast 		: OUT STD_LOGIC; -- Read last. This signal indicates the last transfer in a read burst.
				-- Write Response Channel
				axi_bresp 		: OUT STD_LOGIC_VECTOR(1 downto 0); -- Write response. This signal indicates the status of the write transaction.
				axi_bvalid 		: OUT STD_LOGIC; -- Write response valid. This signal indicates that the channel is signaling a valid write response.
				axi_bready 		: IN STD_LOGIC;	-- Response ready. This signal indicates that the master can accept a write response.
				axi_bid 		: OUT STD_LOGIC_VECTOR(c_axi_id_width-1 downto 0); -- Response ID tag. This signal is the ID tag of the write response.
				-- External Signals	
				oslv_pwm				: OUT STD_LOGIC_VECTOR(number_of_pwms-1 DOWNTO 0)
			);
	END COMPONENT;
	
	CONSTANT c_pwm_subtype_id : INTEGER := 0;
	CONSTANT c_pwm_interface_version : INTEGER := 0;

END PACKAGE pwm_device_pkg;

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.math_real.ALL;
USE work.adjustable_pwm_pkg.ALL;
USE work.pwm_device_pkg.ALL;
USE work.fLink_definitions.ALL;
USE work.axi_slave_pkg.ALL;

ENTITY pwm_device IS
	GENERIC (
		number_of_pwms: INTEGER RANGE 0 TO c_max_number_of_PWMs := 1;--number of pwms which will be generated
		base_clk: INTEGER := 125000000;--clock frequency which is used on the clock input signal of this block
		unique_id: STD_LOGIC_VECTOR (c_fLink_avs_data_width-1 DOWNTO 0) := (OTHERS => '0')--unique id
	);
	PORT (
			-- Clock and Reset
		axi_aclk 		: IN STD_LOGIC;
		axi_areset_n 	: IN STD_LOGIC;
		-- Write Address Channel
		axi_awid 		: IN STD_LOGIC_VECTOR(c_axi_id_width-1 downto 0); -- Write Address ID
		axi_awaddr 		: IN STD_LOGIC_VECTOR(c_pwm_interface_address_width-1 downto 0); -- Write address
		axi_awlen 		: IN STD_LOGIC_VECTOR(7 downto 0); -- Burst length. The burst length gives the exact number of transfers in a burst
		axi_awsize 		: IN STD_LOGIC_VECTOR(2 downto 0); -- Burst size. This signal indicates the size of each transfer in the burst
		axi_awburst 	: IN STD_LOGIC_VECTOR(1 downto 0); -- Burst type. The burst type and the size information, determine how the address for each transfer within the burst is calculated.
		axi_awvalid 	: IN STD_LOGIC; -- Write address valid. This signal indicates that the channel is signaling valid write address and control information.
		axi_awready 	: OUT STD_LOGIC; -- Write address ready. This signal indicates that the slave is ready to accept an address and associated control signals.

		-- Write Data Channel
		axi_wdata 		: IN STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 downto 0); -- Write Data
		axi_wstrb 		: IN STD_LOGIC_VECTOR(3 downto 0); -- Write strobes. This signal indicates which byte lanes hold valid data. There is one write strobe bit for each eight bits of the write data bus.
		axi_wvalid 		: IN STD_LOGIC; -- Write valid. This signal indicates that valid write data and strobes are available.
		axi_wready 		: OUT STD_LOGIC; -- Write ready. This signal indicates that the slave can accept the write data.
		-- Read Address Channel
		axi_araddr 		: IN STD_LOGIC_VECTOR(c_pwm_interface_address_width-1 downto 0); -- Read address. This signal indicates the initial address of a read burst transaction.
		axi_arvalid 	: IN STD_LOGIC; -- Read address valid. This signal indicates that the channel is signaling valid read address and control information.
		axi_arready		: OUT STD_LOGIC; -- Read address ready. This signal indicates that the slave is ready to accept an address and associated  control signals.
		axi_arid 		: IN STD_LOGIC_VECTOR(c_axi_id_width-1 downto 0); -- Read address ID. This signal is the identification tag for the read address group of signals.
		axi_arlen 		: IN STD_LOGIC_VECTOR(7 downto 0); -- Burst length. The burst length gives the exact number of transfers in a burst
		axi_arsize 		: IN STD_LOGIC_VECTOR(2 downto 0); -- Burst size. This signal indicates the size of each transfer in the burst
		axi_arburst 	: IN STD_LOGIC_VECTOR(1 downto 0); -- Burst type. The burst type and the size information,  determine how the address for each transfer within the burst is calculated.
		-- Read Data Channel
		axi_rdata 		: OUT STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 downto 0); -- Read Data
		axi_rresp 		: OUT STD_LOGIC_VECTOR(1 downto 0); -- Read response. This signal indicates the status of the read transfer.
		axi_rvalid 		: OUT STD_LOGIC; -- Read valid. This signal indicates that the channel is signaling the required read data.
		axi_rready 		: IN STD_LOGIC; -- Read ready. This signal indicates that the master can accept the read data and response information
		axi_rid 		: OUT STD_LOGIC_VECTOR(c_axi_id_width-1 downto 0); -- Read ID tag. This signal is the identification tag for the read data group of signals generated by the slave.
		axi_rlast 		: OUT STD_LOGIC; -- Read last. This signal indicates the last transfer in a read burst.
		-- Write Response Channel
		axi_bresp 		: OUT STD_LOGIC_VECTOR(1 downto 0); -- Write response. This signal indicates the status of the write transaction.
		axi_bvalid 		: OUT STD_LOGIC; -- Write response valid. This signal indicates that the channel is signaling a valid write response.
		axi_bready 		: IN STD_LOGIC;	-- Response ready. This signal indicates that the master can accept a write response.
		axi_bid 		: OUT STD_LOGIC_VECTOR(c_axi_id_width-1 downto 0); -- Response ID tag. This signal is the ID tag of the write response.
		-- External Signals	
		oslv_pwm				: OUT STD_LOGIC_VECTOR(number_of_pwms-1 DOWNTO 0)
	);
	
	CONSTANT c_configuration_reg_address: UNSIGNED(c_pwm_interface_address_width-1 DOWNTO 0) := to_unsigned(c_fLink_configuration_address*4, c_pwm_interface_address_width);
	CONSTANT c_usig_base_clk_address	: UNSIGNED(c_pwm_interface_address_width-1 DOWNTO 0) := to_unsigned(c_fLink_number_of_std_registers*4, c_pwm_interface_address_width);
	CONSTANT c_usig_frequency_address	: UNSIGNED(c_pwm_interface_address_width-1 DOWNTO 0) := c_usig_base_clk_address + 4;
	CONSTANT c_usig_ratio_address		: UNSIGNED(c_pwm_interface_address_width-1 DOWNTO 0) := c_usig_frequency_address + number_of_pwms*4;
	CONSTANT c_usig_max_address			: UNSIGNED(c_pwm_interface_address_width-1 DOWNTO 0) := c_usig_ratio_address + number_of_pwms*4;
	
END ENTITY pwm_device;

ARCHITECTURE rtl OF pwm_device IS
	Type t_pwm_regs IS ARRAY(number_of_pwms-1 DOWNTO 0) OF UNSIGNED(c_fLink_avs_data_width-1 DOWNTO 0);

	TYPE t_internal_register IS RECORD
		  	frequency_regs				: t_pwm_regs;	  
			ratio_regs					: t_pwm_regs;	
			conf_reg  					: STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 DOWNTO 0);
	END RECORD;
	
	CONSTANT INTERNAL_REG_RESET : t_internal_register := (
							  frequency_regs=> ((OTHERS=> (OTHERS=>'0'))),
							  ratio_regs=> ((OTHERS=> (OTHERS=>'0'))),
                              conf_reg=> (OTHERS=>'0')
	);
	
	SIGNAL slv_read_address	: UNSIGNED(c_pwm_interface_address_width-1 downto 0);
	SIGNAL sl_write_valid : STD_LOGIC;
	SIGNAL slv_write_address : UNSIGNED(c_pwm_interface_address_width-1 downto 0);
	SIGNAL slv_write_data : STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 downto 0);
	SIGNAL axi_rdata_internal 	: STD_LOGIC_VECTOR(c_fLink_avs_data_width-1 downto 0);	
	
	SIGNAL pwm_reset_n : STD_LOGIC; 
	SIGNAL ri,ri_next : t_internal_register := INTERNAL_REG_RESET;
	
	
BEGIN
	--create component
	gen_pwm:
	FOR i IN 0 TO number_of_pwms-1 GENERATE
		my_adjustable_pwm :  adjustable_pwm 
			GENERIC MAP (frequency_resolution =>c_fLink_avs_data_width)
			PORT MAP (axi_aclk,pwm_reset_n,ri.frequency_regs(i),ri.ratio_regs(i),oslv_pwm(i));		
	END GENERATE gen_pwm;
	
	axi_slave_interface : axi_slave 
	GENERIC MAP(
		axi_device_address_width => c_pwm_interface_address_width,
		id => c_fLink_pwm_out_id,
		subtype_id => c_pwm_subtype_id, 
		interface_version => c_pwm_interface_version,
		number_of_channels => number_of_pwms,
		unique_id => unique_id
	)
	PORT MAP(
			axi_aclk => axi_aclk,
			axi_areset_n => axi_areset_n,
			axi_awid => axi_awid,
			axi_awaddr => axi_awaddr,
			axi_awlen => axi_awlen,
			axi_awsize => axi_awsize,
			axi_awburst => axi_awburst,
			axi_awvalid => axi_awvalid,
			axi_awready => axi_awready,
			axi_wdata => axi_wdata,
			axi_wstrb => axi_wstrb,
			axi_wvalid => axi_wvalid,
			axi_wready => axi_wready,
			axi_araddr => axi_araddr,
			axi_arvalid => axi_arvalid,
			axi_arready => axi_arready,
			axi_arid => axi_arid,
			axi_arlen => axi_arlen,
			axi_arsize => axi_arsize,
			axi_arburst => axi_arburst,
			axi_rdata => axi_rdata,
			axi_rresp => axi_rresp,
			axi_rvalid => axi_rvalid,
			axi_rready => axi_rready,
			axi_rid => axi_rid,
			axi_rlast => axi_rlast,
			axi_bresp => axi_bresp,
			axi_bvalid => axi_bvalid,
			axi_bready => axi_bready,
			axi_bid => axi_bid,
			oslv_read_address => slv_read_address,
			islv_read_data => axi_rdata_internal,
			osl_write_valid => sl_write_valid,
			oslv_write_address => slv_write_address,
			oslv_write_data => slv_write_data
	);
	
	
	
	
	-- cobinatoric process
	comb_proc : PROCESS (axi_areset_n,ri,sl_write_valid,slv_write_address,slv_write_data,slv_read_address,axi_wstrb)
		VARIABLE vi : t_internal_register;
	BEGIN
		-- keep variables stable
		vi := ri;
		
		--standard values
		pwm_reset_n <= '1';
		
		
		--write part: 
		IF sl_write_valid = '1' THEN
			-- Write to config register
			IF slv_write_address = c_configuration_reg_address THEN
				FOR i IN 0 TO 3 LOOP
					IF axi_wstrb(i) = '1' THEN
							vi.conf_reg((i + 1) * 8 - 1 DOWNTO i * 8) := slv_write_data((i + 1) * 8 - 1 DOWNTO i * 8);
					END IF;
				END LOOP;
			ELSIF slv_write_address >= c_usig_frequency_address AND slv_write_address < c_usig_ratio_address THEN
				FOR i IN 0 TO 3 LOOP	
					IF axi_wstrb(i) = '1' THEN
							vi.frequency_regs(to_integer(slv_write_address-c_usig_frequency_address)/4)((i + 1) * 8 - 1 DOWNTO i * 8) := UNSIGNED(slv_write_data((i + 1) * 8 - 1 DOWNTO i * 8));
					END IF;
				END LOOP;	
			ELSIF slv_write_address >= c_usig_ratio_address AND slv_write_address < c_usig_max_address THEN 
				FOR i IN 0 TO 3 LOOP	
					IF axi_wstrb(i) = '1' THEN
						vi.ratio_regs(to_integer(slv_write_address-c_usig_ratio_address)/4)((i + 1) * 8 - 1 DOWNTO i * 8) := UNSIGNED(slv_write_data((i + 1) * 8 - 1 DOWNTO i * 8));
					END IF;	
				END LOOP;
			END IF;	
		END IF;
			
		--read part:
		IF (slv_read_address = c_configuration_reg_address) THEN
			axi_rdata_internal <= vi.conf_reg;
		ELSIF (slv_read_address = c_usig_base_clk_address) THEN
			axi_rdata_internal <= std_logic_vector(to_unsigned(base_clk,c_fLink_avs_data_width));
		ELSIF slv_read_address >= c_usig_frequency_address AND slv_read_address < c_usig_ratio_address THEN
			axi_rdata_internal <= STD_LOGIC_VECTOR(vi.frequency_regs(to_integer(slv_read_address - c_usig_frequency_address)/4));
		ELSIF slv_read_address >= c_usig_ratio_address AND slv_read_address < c_usig_max_address THEN 
			axi_rdata_internal <= STD_LOGIC_VECTOR(vi.ratio_regs(to_integer(slv_read_address - c_usig_ratio_address)/4));
		ELSE
			axi_rdata_internal <= (OTHERS => '0');
		END IF;	

		
		
		IF axi_areset_n = '0' OR  vi.conf_reg(c_fLink_reset_bit_num) = '1' THEN
			vi := INTERNAL_REG_RESET;
		END IF;
		
		ri_next <= vi;
		
	END PROCESS comb_proc;
	
	reg_proc : PROCESS (axi_aclk)
	BEGIN
		IF rising_edge(axi_aclk) THEN
			ri <= ri_next;
		END IF;
	END PROCESS reg_proc;
		
END rtl;