library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.decoder_pkg.all;
use work.alu_pkg.all;
use work.cpu_pkg.all;

entity cpu is
    generic (
        data_len : positive := 32
    );
    port (
        clk : in std_logic;

        data_addr : out std_logic_vector(data_len - 1 downto 0);
        data_out  : out std_logic_vector(data_len - 1 downto 0);
        data_in   : in std_logic_vector(data_len - 1 downto 0);
        data_we   : out std_logic;

        instr_addr : out std_logic_vector(data_len - 1 downto 0);
        instr_in   : in std_logic_vector(data_len - 1 downto 0)
    );
end cpu;

architecture cpu_arc of cpu is

    subtype t_data is std_logic_vector(data_len - 1 downto 0);



    -- debug
    signal debug_flags : t_data;
    signal debug_pc    : t_data;
    signal debug_link  : t_data;


    ----------------------------------------------------------------------------
    --- Registers

    type t_register_file is array(0 to 31) of t_data;

    signal register_file : t_register_file := (others => (others => '0'));

    alias reg_zero : t_data is register_file(to_integer(unsigned(reg_addr_zero)));
    alias reg_flag : t_data is register_file(to_integer(unsigned(reg_addr_flags)));
    alias reg_link : t_data is register_file(to_integer(unsigned(reg_addr_link)));
    alias reg_pc   : t_data is register_file(to_integer(unsigned(reg_addr_pc)));

    -- fetch
    signal fetch_out_next_seq_pc : t_data := (others => '0');


    ----------------------------------------------------------------------------
    --- Instruction decode signals

    -- Inputs
    signal indec_in_instr       : t_data := (others => '1');
    signal indec_in_next_seq_pc : t_data := (others => '0');

    -- internal signals to inst_decode
    signal indec_reg_select_1 : t_reg_addr;
    signal indec_reg_select_2 : t_reg_addr;
    signal indec_reg_select_3 : t_reg_addr;
    signal indec_op2_sel      : std_logic;
    signal indec_immediate    : t_op_imm;

    -- Outputs
    signal indec_out_op_code          : t_op_code := op_NOP;
    signal indec_out_op_sel           : t_alu_op_code;
    signal indec_out_target           : t_reg_addr;
    signal indec_out_datastore        : t_data;
    signal indec_out_op_1             : t_data;
    signal indec_out_op_2             : t_data;
    signal indec_out_flags_comp       : std_logic;
    signal indec_out_flags_carry      : std_logic;
    signal indec_out_flags_of         : std_logic;
    signal indec_out_reg_write_enable : std_logic;
    signal indec_out_next_seq_pc      : t_data := (others => '0');


    ----------------------------------------------------------------------------
    --- Execute signals

    -- Inputs
    signal exec_in_op_code          : t_op_code := op_NOP;
    signal exec_in_op_sel           : t_alu_op_code;
    signal exec_in_target           : t_reg_addr;
    signal exec_in_datastore        : t_data;
    signal exec_in_op_1             : t_data;
    signal exec_in_op_2             : t_data;
    signal exec_in_flags_comp       : std_logic;
    signal exec_in_flags_carry      : std_logic;
    signal exec_in_flags_of         : std_logic;
    signal exec_in_reg_write_enable : std_logic;
    signal exec_in_next_seq_pc      : t_data := (others => '0');



    signal exec_out_op_code          : t_op_code := op_NOP;
    signal exec_out_target           : t_reg_addr;
    signal exec_out_datastore        : t_data;
    signal exec_out_result           : t_data;
    signal exec_out_flags_comp       : std_logic;
    signal exec_out_flags_carry      : std_logic;
    signal exec_out_flags_of         : std_logic;
    signal exec_out_reg_write_enable : std_logic;
    signal exec_out_next_seq_pc      : t_data := (others => '0');


    ----------------------------------------------------------------------------
    --- Memory access signals

    signal macc_op_code          : t_op_code := op_NOP;
    signal macc_target           : t_reg_addr;
    signal macc_result           : t_data;
    signal macc_flags_comp       : std_logic;
    signal macc_flags_carry      : std_logic;
    signal macc_flags_of         : std_logic;
    signal macc_reg_write_enable : std_logic;


    ----------------------------------------------------------------------------
    --- Write back signals


    ----------------------------------------------------------------------------
    --- Functions



    function sign_extend(imm_value : t_op_imm) return t_data is
        variable result: t_data;
    begin
        result(imm_value'length - 1 downto 0)             := imm_value;
        result(result'length - 1 downto imm_value'length) := (others => imm_value(imm_value'length - 1));
        return result;
    end function;

begin

    -- debug output
    debug_flags <= reg_flag;
    debug_pc    <= reg_pc;
    debug_link  <= reg_link;

    fetch: process (clk) is
        variable pc : t_data;
    begin
        if rising_edge(clk) then

            pc := reg_pc;

            instr_addr        <= pc;
            fetch_out_next_seq_pc <= std_logic_vector(unsigned(pc) + 1);

        end if;
    end process fetch;

    ----------------------------------------------------------------------------
    --- Instruction decode

    indec_pipeline: process (clk) is
    begin
        if rising_edge(clk) then
            indec_in_instr       <= instr_in;
            indec_in_next_seq_pc <= fetch_out_next_seq_pc;
        end if;
    end process indec_pipeline;

    -- passthrough
    indec_out_next_seq_pc <= indec_in_next_seq_pc;

    decoder_instance: decoder
        generic map (
            data_len => data_len
        )
        port map (
            -- Inputs
            instr => indec_in_instr,

            -- Outputs
            op_code      => indec_out_op_code,
            alu_op_sel   => indec_out_op_sel,
            reg_select_1 => indec_reg_select_1,
            reg_select_2 => indec_reg_select_2,
            reg_select_3 => indec_reg_select_3,
            reg_target   => indec_out_target,
            write_en     => indec_out_reg_write_enable,
            immediate    => indec_immediate,
            op2_sel      => indec_op2_sel
        );


    -- assign op_1, op_2, datastore, flags
    indec_out_op_1 <= register_file(to_integer(unsigned(indec_reg_select_1)));

    with indec_op2_sel select indec_out_op_2 <=
        register_file(to_integer(unsigned(indec_reg_select_2))) when '0',
        sign_extend(indec_immediate)                            when '1',
        (others => '0')                                         when others;

    indec_out_datastore   <= register_file(to_integer(unsigned(indec_reg_select_3)));
    indec_out_flags_comp  <= reg_flag(0);
    indec_out_flags_carry <= reg_flag(1);
    indec_out_flags_of    <= reg_flag(2);


    ----------------------------------------------------------------------------
    --- Execute

    exec_pipeline: process (clk) is
    begin
        if rising_edge(clk) then
            exec_in_datastore        <= indec_out_datastore;
            exec_in_flags_carry      <= indec_out_flags_carry;
            exec_in_flags_comp       <= indec_out_flags_comp;
            exec_in_flags_of         <= indec_out_flags_of;
            exec_in_next_seq_pc      <= indec_out_next_seq_pc;
            exec_in_op_1             <= indec_out_op_1;
            exec_in_op_2             <= indec_out_op_2;
            exec_in_op_code          <= indec_out_op_code;
            exec_in_op_sel           <= indec_out_op_sel;
            exec_in_reg_write_enable <= indec_out_reg_write_enable;
            exec_in_target           <= indec_out_target;
        end if;
    end process exec_pipeline;

    -- passthrough
    exec_out_op_code          <= exec_in_op_code;
    exec_out_target           <= exec_in_target;
    exec_out_datastore        <= exec_in_datastore;
    exec_out_next_seq_pc      <= exec_in_next_seq_pc;
    exec_out_reg_write_enable <= exec_in_reg_write_enable;

    alu_instance: alu
        generic map (
            data_len => data_len
        )
        port map (
            -- Inputs
            alu_op_code => exec_in_op_sel,
            op_1        => exec_in_op_1,
            op_2        => exec_in_op_2,
            carry_in    => exec_in_flags_carry,
            of_in       => exec_in_flags_of,
            comp_in     => exec_in_flags_comp,

            -- Outputs
            result    => exec_out_result,
            carry_out => exec_out_flags_carry,
            of_out    => exec_out_flags_of,
            comp_out  => exec_out_flags_comp
        );


    ----------------------------------------------------------------------------
    --- Memory access

    mem_access: process (clk) is
    begin
        if rising_edge(clk) then

            macc_op_code     <= exec_out_op_code;
            macc_target      <= exec_out_target;
            macc_result      <= exec_out_result;
            macc_flags_comp  <= exec_out_flags_comp;
            macc_flags_carry <= exec_out_flags_carry;
            macc_flags_of    <= exec_out_flags_of;

            macc_reg_write_enable <= exec_out_reg_write_enable;

            case macc_op_code is

                when op_JMP =>
                    reg_pc   <= exec_out_result;
                    reg_link <= exec_out_next_seq_pc;
                    --instr_addr <= exec_out_result;

                when op_B =>
                    if exec_out_flags_comp = '1' then
                        reg_pc   <= exec_out_result;
                        reg_link <= exec_out_next_seq_pc;
                        --instr_addr <= exec_out_result;

                    elsif exec_out_flags_comp = '0' then
                        reg_pc <= exec_out_next_seq_pc;
                        --instr_addr <= exec_out_next_seq_pc;

                    else
                        -- TODO is just else sufficient?
                        report "exec_out_flags_comp was neither 0 nor 1"
                        severity error;
                    end if;

                when op_LDR =>
                    --macc_result <= memory_get(result);
                    data_we     <= '0';
                    data_addr   <= exec_out_result;
                    macc_result <= data_in;  -- TODO does this work (-> timing)?

                    reg_pc <= exec_out_next_seq_pc;
                    --instr_addr <= exec_out_next_seq_pc;
                    
                when op_STR =>
                    --memory_write(result, exec_out_datastore); --addr then value
                    data_addr <= exec_out_result;
                    data_out  <= exec_out_datastore;
                    data_we   <= '1';

                    reg_pc <= exec_out_next_seq_pc;
                    --instr_addr <= exec_out_next_seq_pc;
                    
                when others =>
                    reg_pc <= exec_out_next_seq_pc;
                    --instr_addr <= exec_out_next_seq_pc;

            end case;
        end if;
    end process mem_access;


    ----------------------------------------------------------------------------
    --- Write back

    write_back: process (clk) is
    begin
        if rising_edge(clk) then

            -- Write back flags
            -- 00000000000000000000000000000000
            --                                ^compare
            --                               ^carry
            --                              ^overflow
            reg_flag <= (
                0      => macc_flags_comp,
                1      => macc_flags_carry,
                2      => macc_flags_of,
                others => '0'
            );

            if macc_reg_write_enable = '1' then

                -- disallow writes to pc and zero register
                case macc_target is
                    when reg_addr_pc =>
                        null;
                    when reg_addr_zero =>
                        null;
                    when others =>
                        null;
                        --register_file(to_integer(unsigned(macc_target))) <= macc_result;
                end case;
            end if;
        end if;
    end process write_back;

end cpu_arc;
