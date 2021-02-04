library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use.ieee.std.logic_unsigned.all;




-- this entity should extend the immediate input value
-- to a 32 signed bit value
entity sign_ext is
	generic (
		data_len: integer := 32 -- data width
	);
	port (
		imm_in: in t_op_imm;
		op_out: out t_data
	);
end sign_ext;


variable u_imm_in: unsigned(imm_in);
variable tmp_result: unsigned(data_len downto 0);

architecture behave of sign_ext is

	begin
 
	process(Input)

		signal u_imm_in: unsigned(imm_in);
		signal tmp_result: unsigned(data_len downto 0);

		begin

			temp_result <= '0000000000000000' & u_imm_in;
			op_out <= std_logic_vector(temp_result);
	
		end

	end

end behave;