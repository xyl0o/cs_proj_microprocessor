entity cpu_full is
end cpu_full;


architecture cpu_full_arc of cpu_full is

	signal clk : std_logic;

    component cpu
        port (
            clk: in std_logic;
            data_in: in std_logic_vector(data_len-1 downto 0);
            instr_in: in std_logic_vector(data_len-1 downto 0);

            data_out: out std_logic_vector(data_len-1 downto 0);
            data_addr_out: out std_logic_vector(data_len-1 downto 0);
            instr_addr_out: out std_logic_vector(data_len-1 downto 0);
            data_we: out std_logic

        );
    end component;

    component rom
        port (
            clk: in std_logic;
            addr_in: in std_logic_vector(data_len-1 downto 0);
            data_out: out std_logic_vector(data_len-1 downto 0)

        );
    end component;

    component ram
        port (
            clk: in std_logic;
            addr_in: in std_logic_vector(data_len-1 downto 0);
            data_in: in std_logic_vector(data_len-1 downto 0);
            data_out: out std_logic_vector(data_len-1 downto 0);
            data_we: out std_logic


        );
    end component;
   begin
   	port map(
   		rom.addr_in <= cpu.instr_addr_out;
   		cpu.instr_in <= rom.data_out;
   	)

begin