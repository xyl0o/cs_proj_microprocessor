
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sramPkg.all;
use work.cpu_pkg.all;


entity processor is
    generic(
        clk_period     : time     := 200 ns;
        clk_cycles     : positive := 50;
        data_len       : positive := 32;
        instr_addr_len : positive := 8;
        data_addr_len  : positive := 10
    );
end entity processor;


architecture processor_tb of processor is
    subtype t_data is std_logic_vector(data_len - 1 downto 0);

    signal clk               : std_logic;
    signal const0, const1    : std_logic;
    signal data_nwe, data_we : std_logic;

    signal instr_addr       : t_data;
    signal instr_short_addr : std_logic_vector(instr_addr_len - 1 downto 0);
    signal instr_fromcpu    : t_data;
    signal instr_tocpu      : t_data;

    signal data_addr       : t_data;
    signal data_short_addr : std_logic_vector(data_addr_len - 1 downto 0);
    signal data_fromcpu    : t_data;
    signal data_tocpu      : t_data;

    signal instr_ctrl, data_ctrl : fileIOty;

begin

    const0 <= '0';
    const1 <= '1';

    --instr_fromcpu <= "0";

    data_nwe <= not data_we;

    instr_short_addr <= instr_addr(
        instr_short_addr'length - 1 downto 0);

    data_short_addr <= data_addr(
        data_short_addr'length - 1 downto 0);

    instr_mem_instance: sram2
        generic map (
            addrWd => instr_addr_len,
            dataWd => data_len,
            fileID => "instMem.dat"
        )
        port map (
            nCS => const0,
            nWE => const1,

            addr    => instr_short_addr,
            dataIn  => instr_fromcpu,
            dataOut => instr_tocpu,

            fileIO  => instr_ctrl
        );

    data_mem_instance: sram2
        generic map (
            addrWd => data_addr_len,
            dataWd => data_len,
            fileID => "dataMem.dat"
        )
        port map (
            nCS => const0,
            nWE => data_nwe,

            addr    => data_short_addr,
            dataIn  => data_fromcpu,
            dataOut => data_tocpu,

            fileIO => data_ctrl
        );

    cpu_instance: cpu
        generic map (
            data_len => data_len
        )
        port map (
            clk => clk,

            data_addr => data_addr,
            data_out  => data_fromcpu,
            data_in   => data_tocpu,
            data_we   => data_we,

            instr_addr => instr_addr,
            instr_in   => instr_tocpu
        );

    -- load instruction/data and run cpu
    stimulus_process: process is
    begin
        clk        <= '0';
        instr_ctrl <= load,  none after 5 ns;
        data_ctrl  <= load,  none after 5 ns;

        wait for clk_period / 2;
        for n in 1 to clk_cycles loop
            clk <= '0', '1' after clk_period / 2;
            wait for clk_period;
        end loop;
        wait;
    end process stimulus_process;

end architecture processor_tb;
