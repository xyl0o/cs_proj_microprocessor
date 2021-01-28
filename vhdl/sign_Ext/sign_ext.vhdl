library ieee;
use ieee.numeric_std.all;



-- this entity should extend the immediate input value
-- to a 32 signed bit value
entity sign_ext is
	generic (
		data_len: integer -- data width
	);
	port (
		imm_in: in t_op_imm;
		op_out: out t_data
	);
end sign_ext;
