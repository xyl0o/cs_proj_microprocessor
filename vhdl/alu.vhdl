
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