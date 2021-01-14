
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.reg_types.all;
use work.op_codes.all;
use work.alu_op_sel.all;

entity alu is
	generic (
		data_len: integer -- data width
	);
	port (
		alu_op_sel: in t_alu_op_sel;
		op_1: in t_data;
		op_2: in t_data;

		result: out t_data;
		
		carry: out std_logic;
		overflow: out std_logic;
		compare: out std_logic
	);
end alu;

architecture alu_arc of alu is

begin
	arithmetic : process (op_1, op_2, alu_op_sel)
		variable tmp_result: std_ulogic := '0'; -- TODO
		variable tmp_compare: std_logic := '0';
		variable uop_1: unsigned := unsigned(op_1);
		variable uop_2: unsigned := unsigned(op_2);
	begin
		case sel is
			when aluADD =>
				tmp_result := uop_1 + uop_2;
			when aluADC =>
				tmp_result := uop_1 + uop_2 + unsigned(carry);
			when aluSBC =>
				tmp_result := uop_1 - uop_2 - 1 + unsigned(carry);
			when aluSL =>
				tmp_result := shift_left(uop_1, uop_2);
			when aluSRA =>
				tmp_result := uop_1(w) & shift_right(uop_1, uop_2)(w downto 1);
			when aluSRL =>
				tmp_result := shift_right(uop_1, uop_2);
			when aluAND =>
				tmp_result := uop_1 and uop_2;
			when aluORR =>
				tmp_result := uop_1 or uop_2;
			when aluXOR =>
				tmp_result := uop_1 xor uop_2;
			when aluCMPEQ =>
				tmp_compare <= to_integer(uop_1) == to_integer(uop_2);
			when aluCMPGT =>
				tmp_compare <= to_integer(uop_1) > to_integer(uop_2);
			when aluIDOP2 =>
				tmp_result := uop_2;
			when aluNOOP =>
				null;
			when others =>
				null;

			result <= tmp_result(w downto 0);
			carry <= tmp_result(w + 1);
			compare <= tmp_compare;
		end case;
	end process arithmetic;
end alu_arc;
