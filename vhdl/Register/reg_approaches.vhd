regType is array (0 to 31) of std_logic_vector(31 downto 0);
signal regArray : regType;

begin regP : process (clk) is
    begin 
    if rising_edge(clk) then 
        if write_en = '1' then
            regAarray(to_integer(unsigned(writeSel)) <= dataIn);
        end if;
    end if;
end process regP;

    porA <= regAarray(to_integer(unsigned(selA));
    porB <= regAarray(to_integer(unsigned(selB));

end architecture