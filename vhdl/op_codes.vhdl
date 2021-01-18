
package op_codes is
begin
	subtype t_op_code: std_logic_vector(4 downto 0);
	constant CMPEQ: t_op_code := "01001";
	constant CMPGT: t_op_code := "01010";
	constant MOV:   t_op_code := "01011";
	constant JMP:   t_op_code := "01100";
	constant B:     t_op_code := "01101";
	constant ADC:   t_op_code := "10001";
	constant ADD:   t_op_code := "10010";
	constant SBC:   t_op_code := "10011";
	constant SUB:   t_op_code := "10100";
	constant SL:    t_op_code := "10101";
	constant SRA:   t_op_code := "10110";
	constant SRL:   t_op_code := "10111";
	constant AND:   t_op_code := "11000";
	constant ORR:   t_op_code := "11001";
	constant XOR:   t_op_code := "11010";
	constant LDR:   t_op_code := "11011";
	constant STR:   t_op_code := "11100";
	constant NOP:   t_op_code := "11111";
end package op_codes;

package alu_op_sel is
begin
	subtype t_alu_op_sel: std_logic_vector(4 downto 0);
	constant aluNOOP:  t_alu_op_sel := "00000";
	constant aluADD:   t_alu_op_sel := "00001";
	constant aluADC:   t_alu_op_sel := "00010";
	constant aluSBC:   t_alu_op_sel := "00011";
	constant aluSL:    t_alu_op_sel := "00100";
	constant aluSRA:   t_alu_op_sel := "00101";
	constant aluSRL:   t_alu_op_sel := "00110";
	constant aluAND:   t_alu_op_sel := "00111";
	constant aluORR:   t_alu_op_sel := "01000";
	constant aluXOR:   t_alu_op_sel := "01001";
	constant aluCMPEQ: t_alu_op_sel := "01010";
	constant aluCMPGT: t_alu_op_sel := "01011";
	constant aluIDOP2: t_alu_op_sel := "01100";
end package alu_op_sel;
