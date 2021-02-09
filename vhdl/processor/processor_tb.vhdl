
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.sramPkg.all;


entity processor is
    generic(
        clk_period : time     := 20 ns;
        clk_cycles : positive := 20;
        data_len   : positive := 32
    );
end entity processor;


architecture processor_tb of processor is

    signal clk               : std_logic;
    signal const0, const1    : std_logic;
    signal data_nwe, data_we : std_logic;

    signal instr_addr        : std_logic_vector(31 downto 0);
    signal instr_tocpu       : std_logic_vector(31 downto 0);

    signal data_addr         : std_logic_vector(31 downto 0);
    signal data_fromcpu      : std_logic_vector(31 downto 0);
    signal data_tocpu        : std_logic_vector(31 downto 0);

    signal instr_ctrl, data_ctrl   : fileIOty;

begin

    const0 <= '0';
    const1 <= '1';

    data_nwe <= not data_we;

    instr_mem: sram2
        generic map (
            addrWd  => data_len,
            dataWd  => data_len,
            fileID  => "instMem.dat"
        )
        port map (
            nCS     => const0,
            nWE     => const1,

            addr    => instr_addr,
            dataIn  => const0,
            dataOut => instr_tocpu,

            fileIO  => instr_ctrl
        );

    data_mem: sram2
        generic map (
            addrWd  => data_len,
            dataWd  => data_len,
            fileID  => "dataMem.dat"
        )
        port map (
            nCS     => const0,
            nWE     => data_nwe,

            addr    => data_addr,
            dataIn  => data_fromcpu,
            dataOut => data_tocpu,

            fileIO  => data_ctrl
        );

    cpu: cpu
        generic map (
            data_len   => data_len
        )
        port map (
            clk        => clk,

            data_addr  => data_addr,
            data_out   => data_fromcpu,
            data_in    => data_tocpu,
            data_we    => data_we,

            instr_addr => instr_addr,
            instr_in   => instr_tocpu
        );

  -- load instruction/data and run cpu
    stiP: process is
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
    end process stiP;

end architecture processor_tb;
