
library ieee;
use ieee.std_logic_1164.all;

use work.constants.alu_op_code_len;

package alu_op_codes is
	subtype t_alu_op_code is std_logic_vector(alu_op_code_len - 1 downto 0);
	constant aluop_NOOP:  t_alu_op_code := "00000";
	constant aluop_ADD:   t_alu_op_code := "00001";
	constant aluop_ADC:   t_alu_op_code := "00010";
	constant aluop_SBC:   t_alu_op_code := "00011";
	constant aluop_SL:    t_alu_op_code := "00100";
	constant aluop_SRA:   t_alu_op_code := "00101";
	constant aluop_SRL:   t_alu_op_code := "00110";
	constant aluop_AND:   t_alu_op_code := "00111";
	constant aluop_ORR:   t_alu_op_code := "01000";
	constant aluop_XOR:   t_alu_op_code := "01001";
	constant aluop_CMPEQ: t_alu_op_code := "01010";
	constant aluop_CMPGT: t_alu_op_code := "01011";
	constant aluop_IDOP2: t_alu_op_code := "01100";
end package alu_op_codes;
