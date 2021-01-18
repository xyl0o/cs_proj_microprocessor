package reg_types is
begin
	constant data_len: integer := 32;
	subtype t_data: std_logic_vector(data_len - 1 downto 0);
	subtype t_op_imm: std_logic_vector(15 downto 0);
	subtype t_reg_sel: std_logic_vector(5 downto 0);
end package reg_types;
