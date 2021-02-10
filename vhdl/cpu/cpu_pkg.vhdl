library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.decoder_pkg.all;
use work.alu_pkg.all;

package cpu_pkg is
    constant reg_addr_zero  : t_reg_addr := "00000"; -- R0
    constant reg_addr_flags : t_reg_addr := "00001"; -- R1
    constant reg_addr_link  : t_reg_addr := "11110"; -- R30
    constant reg_addr_pc    : t_reg_addr := "11111"; -- R31

    component cpu is
        generic (
            data_len : positive := 32
        );
        port (
            clk : in std_logic;

            data_in  : in std_logic_vector(data_len - 1 downto 0);
            instr_in : in std_logic_vector(data_len - 1 downto 0);

            data_addr  : out std_logic_vector(data_len - 1 downto 0);
            data_out   : out std_logic_vector(data_len - 1 downto 0);
            data_we    : out std_logic;
            instr_addr : out std_logic_vector(data_len - 1 downto 0)
        );
    end component cpu;
end package cpu_pkg;