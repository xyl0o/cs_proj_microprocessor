
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- https://www.csee.umbc.edu/portal/help/VHDL/packages/numeric_std.vhd

use work.alu_op_codes.all;

package alu_pkg is
    component alu is
        port(
            alu_op_code: in t_alu_op_code;

            -- Inputs
            op_1: in t_data;
            op_2: in t_data;

            carry_in: in std_logic;
            of_in: in std_logic;
            comp_in: in std_logic;

            -- Outputs
            result: out t_data;

            carry_out: out std_logic;
            of_out: out std_logic;
            comp_out: out std_logic
        );
    end component;
end package alu_pkg;

entity alu is
	generic (
		data_len: integer := 32 -- data width
	);
	port (
		alu_op_code: in t_alu_op_code;

		op_1: in std_logic_vector(data_len - 1 downto 0);
		op_2: in std_logic_vector(data_len - 1 downto 0);
		carry_in: in std_logic;
		of_in: in std_logic;
		comp_in: in std_logic;

		result: out std_logic_vector(data_len - 1 downto 0);
		carry_out: out std_logic;
		of_out: out std_logic;
		comp_out: out std_logic
	);
end alu;

architecture alu_arc of alu is

begin
	arithmetic : process (op_1, op_2, alu_op_code)
		variable tmp_result: unsigned(data_len downto 0);
		variable uop_1: unsigned(data_len downto 0);
		variable uop_2: unsigned(data_len downto 0);
	begin

		carry_out <= carry_in;
		comp_out <= comp_in;

		-- ignore for now.
		-- needs special handling
		of_out <= of_in;

		uop_1 := '0' & unsigned(op_1);
		uop_2 := '0' & unsigned(op_2);

		case alu_op_code is

			when aluop_ADD =>
				tmp_result := uop_1 + uop_2;

			when aluop_ADC =>
			    -- https://electronics.stackexchange.com/questions/463586/vhdl-convert-std-logic-to-std-logic-vector
				tmp_result := uop_1 + uop_2 + "0" & carry_in;
				carry_out <= tmp_result(data_len);

			when aluop_SBC =>
				tmp_result := uop_1 - uop_2 - 1 + "0" & carry_in;
				carry_out <= tmp_result(data_len);

			when aluop_SL =>
				tmp_result := shift_left(uop_1, to_integer(uop_2));

			when aluop_SRA =>
				tmp_result := uop_1(data_len) & shift_right(uop_1, to_integer(uop_2))(data_len downto 1);

			when aluop_SRL =>
				tmp_result := shift_right(uop_1, to_integer(uop_2));

			when aluop_AND =>
				tmp_result := uop_1 and uop_2;

			when aluop_ORR =>
				tmp_result := uop_1 or uop_2;

			when aluop_XOR =>
				tmp_result := uop_1 xor uop_2;

			when aluop_CMPEQ =>
				if to_integer(uop_1) = to_integer(uop_2) then
					comp_out <= '1';
				else
					comp_out <= '0';
				end if;

			when aluop_CMPGT =>
				if to_integer(uop_1) > to_integer(uop_2) then
					comp_out <= '1';
				else
					comp_out <= '0';
				end if;

			when aluop_IDOP2 =>
				tmp_result := uop_2;

			when aluop_NOOP =>
				null;

			when others =>
				null;

		end case;

		result <= std_logic_vector(tmp_result(data_len - 1 downto 0));

	end process arithmetic;
end alu_arc;
