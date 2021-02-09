-- procTst.vhd
--
-- entity	procTst			-testbench for pipeline processor
-- architecture	testbench		-
------------------------------------------------------------------------------
library ieee;						-- packages:
use ieee.std_logic_1164.all;				--   std_logic
use ieee.numeric_std.all;				--   (un)signed
use work.sramPkg.all;					--   sram
use work.procPkg.all;					--   pipeProc

-- entity	--------------------------------------------------------------
------------------------------------------------------------------------------
entity procTst is
generic(clkPeriod	: time		:= 20 ns;	-- clock period
	clkCycles	: positive	:= 20);		-- clock cycles
end entity procTst;


-- architecture	--------------------------------------------------------------
------------------------------------------------------------------------------
architecture testbench of procTst is
  signal clk, nRst	: std_logic;
  signal const0, const1	: std_logic;
  signal dnWE, dnOE	: std_logic;
  signal iAddr, dAddr	: std_logic_vector( 7 downto 0);
  signal iData, dData	: std_logic_vector(15 downto 0);
  signal iCtrl, dCtrl	: fileIOty;

begin
  const0 <= '0';
  const1 <= '1';

  -- memories		------------------------------------------------------
  instMemI: sram	generic map (	addrWd	=> 8,
					dataWd	=> 16,
					fileID	=> "instMem.dat")
			port map    (	nCS	=> const0,
					nWE	=> const1,
					nOE	=> const0,
					addr	=> iAddr,
					data	=> iData,
					fileIO	=> iCtrl);
  dataMemI: sram	generic map (	addrWd	=> 8,
					dataWd	=> 16,
					fileID	=> "dataMem.dat")
			port map    (	nCS	=> const0,
					nWE	=> dnWE,
					nOE	=> dnOE,
					addr	=> dAddr,
					data	=> dData,
					fileIO	=> dCtrl);

  -- pipe processor	------------------------------------------------------
  pipeProcI: pipeProc	port map    (	clk	=> clk,
					nRst	=> nRst,
					iAddr	=> iAddr,
					iData	=> iData,
					dnWE	=> dnWE,
					dnOE	=> dnOE,
					dAddr	=> dAddr,
					dData	=> dData);

  -- stimuli		------------------------------------------------------
  stiP: process is
  begin
    clk		<= '0';
    nRst	<= '0',   '1'  after 5 ns;
    iCtrl	<= load,  none after 5 ns;
    dCtrl	<= load,  none after 5 ns;
    wait for clkPeriod/2;
    for n in 1 to clkCycles loop
	clk <= '0', '1' after clkPeriod/2;
	wait for clkPeriod;
    end loop;
    wait;
  end process stiP;

end architecture testbench;
------------------------------------------------------------------------------
-- procTst.vhd	- end
