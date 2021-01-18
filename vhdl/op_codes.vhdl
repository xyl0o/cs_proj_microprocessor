
library ieee;
use ieee.std_logic_1164.all;

package op_codes is
	subtype t_op_code is std_logic_vector(4 downto 0);
	constant op_CMPEQ: t_op_code := "01001";
	constant op_CMPGT: t_op_code := "01010";
	constant op_MOV:   t_op_code := "01011";
	constant op_JMP:   t_op_code := "01100";
	constant op_B:     t_op_code := "01101";
	constant op_ADC:   t_op_code := "10001";
	constant op_ADD:   t_op_code := "10010";
	constant op_SBC:   t_op_code := "10011";
	constant op_SUB:   t_op_code := "10100";
	constant op_SL:    t_op_code := "10101";
	constant op_SRA:   t_op_code := "10110";
	constant op_SRL:   t_op_code := "10111";
	constant op_AND:   t_op_code := "11000";
	constant op_ORR:   t_op_code := "11001";
	constant op_XOR:   t_op_code := "11010";
	constant op_LDR:   t_op_code := "11011";
	constant op_STR:   t_op_code := "11100";
	constant op_NOP:   t_op_code := "11111";
end package op_codes;
