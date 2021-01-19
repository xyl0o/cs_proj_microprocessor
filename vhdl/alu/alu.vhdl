
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.alu_op_codes.all;

entity alu is
	generic (
		data_len: integer -- data width
	);
	port (
		alu_op_code: in t_alu_op_code;

		op_1: in std_logic_vector(data_len - 1 downto 0);
		op_2: in std_logic_vector(data_len - 1 downto 0);
		carryin: in std_logic;

		result: out std_logic_vector(data_len - 1 downto 0);
		carryout: out std_logic;
		overflow: out std_logic;
		compare: out std_logic
	);
end alu;

architecture alu_arc of alu is

begin
	arithmetic : process (op_1, op_2, alu_op_code)
		variable tmp_result: std_logic_vector(data_len downto 0) := "0"; -- TODO
		variable tmp_compare: std_logic := '0';
		variable uop_1: unsigned(data_len - 1 downto 0) := unsigned(op_1);
		variable uop_2: unsigned(data_len - 1 downto 0) := unsigned(op_2);
	begin
		case alu_op_code is
			when aluADD =>
				tmp_result := uop_1 + uop_2;
			when aluADC =>
				tmp_result := uop_1 + uop_2 + unsigned(carryin);
			when aluSBC =>
				tmp_result := uop_1 - uop_2 - 1 + unsigned(carryin);
			when aluSL =>
				tmp_result := shift_left(uop_1, uop_2);
			when aluSRA =>
				tmp_result := uop_1(data_len) & shift_right(uop_1, uop_2)(data_len downto 1);
			when aluSRL =>
				tmp_result := shift_right(uop_1, uop_2);
			when aluAND =>
				tmp_result := uop_1 and uop_2;
			when aluORR =>
				tmp_result := uop_1 or uop_2;
			when aluXOR =>
				tmp_result := uop_1 xor uop_2;
			when aluCMPEQ =>
				tmp_compare <= to_integer(uop_1) = to_integer(uop_2);
			when aluCMPGT =>
				tmp_compare <= to_integer(uop_1) > to_integer(uop_2);
			when aluIDOP2 =>
				tmp_result := uop_2;
			when aluNOOP =>
				null;
			when others =>
				null;

			result <= tmp_result(data_len - 1 downto 0);
			carryout <= tmp_result(data_len);
			compare <= tmp_compare;
		end case;
	end process arithmetic;
end alu_arc;
