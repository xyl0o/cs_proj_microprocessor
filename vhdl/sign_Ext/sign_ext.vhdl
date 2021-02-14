library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;





-- this entity should extend the immediate input value
-- to a 32 signed bit value
entity sign_ext is
	generic (
		data_len: integer := 32 -- data width
	);
	port (
		imm_in: in std_logic_vector(15 downto 0);
		op_out: out std_logic_vector(data_len-1 downto 0)
	);
end sign_ext;




architecture behave of sign_ext is

	begin
 
	process(imm_in)

		variable u_imm_in: unsigned(imm_in'length downto 0);
		variable tmp_result: unsigned(data_len downto 0);

		begin

			u_imm_in := unsigned(imm_in);

			-- kein Sign ext => anstatt der "00..=" muss MSB von imm_in extended werden
			tmp_result := u_imm_in(u_imm_in'length -1) & "000000000000000" & u_imm_in(u_imm_in'length -2 downto 0);
			op_out <= std_logic_vector(tmp_result);
	
		

		end process;

end behave;