library ieee;

use ieee.std_logic_1164.all;
use.ieee.std.logic_unsigned.all;

entity data_memory_32x128 is

    port   (
            // clock : in std_logic;
            data_addr: in integer range 0 to 127;
            data_in: in std_logic_vector( 31 down to 0);
            data_out: out std_logic_vector( 31 down to 0);
            write_enable: in bit;
            )

end entity data_memory_32x128;

architecture mem_op of data_memory_32x128 is

    type data_mem_array is array( 0 to 127) of std_logic_vector ( 31 down to 0);
    signal mem: data_mem_array;
    signal read_addr: std_logic_vector(data_addr);


    begin
        if write_enable = '1' then
        mem(to_integer(unsigned(data_addr))) <= data_in;
        else
        read_addr <= data_addr;
        data_out <= mem(to_integer(unsigned(read_addr)));
    end

end architecture mem_op;
