library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

--pakage einbinndung

-- ALU Pocess Einbindung

imm_in: in std_logic_vector(15 downto 0);
op_out: out std_logic_vector(31 downto 0);

op_out(15 downto 0) <= imm_in;

op_out(31 downto 16) <= (others  => imm_in() 15);
