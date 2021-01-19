
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
		variable tmp_result: unsigned(data_len downto 0) := "0"; -- TODO
		variable tmp_compare: std_logic := '0';
		variable uop_1: unsigned(data_len - 1 downto 0) := unsigned(op_1);
		variable uop_2: unsigned(data_len - 1 downto 0) := unsigned(op_2);
	begin
		case alu_op_code is
			when aluop_ADD =>
				tmp_result := uop_1 + uop_2;
			when aluop_ADC =>
			    -- https://electronics.stackexchange.com/questions/463586/vhdl-convert-std-logic-to-std-logic-vector
				tmp_result := uop_1 + uop_2 + "0" & carryin;
			when aluop_SBC =>
				tmp_result := uop_1 - uop_2 - 1 + "0" & carryin;
			when aluop_SL =>
				tmp_result := shift_left(uop_1, uop_2);
			when aluop_SRA =>
				tmp_result := uop_1(data_len) & shift_right(uop_1, uop_2)(data_len downto 1);
			when aluop_SRL =>
				tmp_result := shift_right(uop_1, uop_2);
			when aluop_AND =>
				tmp_result := uop_1 and uop_2;
			when aluop_ORR =>
				tmp_result := uop_1 or uop_2;
			when aluop_XOR =>
				tmp_result := uop_1 xor uop_2;
			when aluop_CMPEQ =>
				tmp_compare <= to_integer(uop_1) = to_integer(uop_2);
			when aluop_CMPGT =>
				tmp_compare <= to_integer(uop_1) > to_integer(uop_2);
			when aluop_IDOP2 =>
				tmp_result := uop_2;
			when aluop_NOOP =>
				null;
			when others =>
				null;

			result <= tmp_result(data_len - 1 downto 0);
			carryout <= tmp_result(data_len);
			compare <= tmp_compare;
		end case;
	end process arithmetic;
end alu_arc;
