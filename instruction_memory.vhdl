library ieee;

use ieee.std_logic_1164.all;
use.ieee.std.logic_unsigned.all;

entity instruction_memory_32x128 is

    port   (
            clock : in std_logic;
            pc : in std_logic;
            instruction: out std_logic_vector( 31 down to 0);
            )

end entity instruction_memory_32x128;

architecture get_instruction of instruction_memory_32x128 is

    type data_instruction_array is array( 0 to 127) of std_logic_vector ( 31 down to 0);

    begin

        process (clock)
        signal new_pc : std_logic_unsigned;
        signal new_instruction : std_logic_unsigned;

        begin

            new_pc <= pc ;
            new_instruction <= data_instruction_array((new_pc/4)) ;
            instruction <= new_instruction ;
        end


    end

end architecture instruction_memory_32x128;
