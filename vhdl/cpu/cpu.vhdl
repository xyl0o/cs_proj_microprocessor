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
    type t_register_file is array(0 to 31) of t_data;

    signal register_file : t_register_file := (others => (others => '0'));

    -- debug
    signal debug_flags : t_data;
    signal debug_pc    : t_data;
    signal debug_link  : t_data;

    -- fetch
    signal fetch_next_seq_pc : t_data := (others => '0');

    -- inst_decode
    signal indec_op_code          : t_op_code := op_NOP;
    signal indec_op_sel           : t_alu_op_code;
    signal indec_target           : t_reg_addr;
    signal indec_datastore        : t_data;
    signal indec_op_1             : t_data;
    signal indec_op_2             : t_data;
    signal indec_flags_comp       : std_logic;
    signal indec_flags_carry      : std_logic;
    signal indec_flags_of         : std_logic;
    signal indec_reg_write_enable : std_logic;
    signal indec_next_seq_pc      : t_data := (others => '0');

    -- internal signals to inst_decode
    signal indec_reg_select_1 : t_reg_addr;
    signal indec_reg_select_2 : t_reg_addr;
    signal indec_reg_select_3 : t_reg_addr;
    signal indec_op2_sel      : std_logic;
    signal indec_immediate    : t_op_imm;

    -- execute
    signal exec_op_code          : t_op_code := op_NOP;
    signal exec_target           : t_reg_addr;
    signal exec_datastore        : t_data;
    signal exec_result           : t_data;
    signal exec_flags_comp       : std_logic;
    signal exec_flags_carry      : std_logic;
    signal exec_flags_of         : std_logic;
    signal exec_reg_write_enable : std_logic;
    signal exec_next_seq_pc      : t_data := (others => '0');

    -- mem_access
    signal macc_op_code          : t_op_code := op_NOP;
    signal macc_target           : t_reg_addr;
    signal macc_result           : t_data;
    signal macc_flags_comp       : std_logic;
    signal macc_flags_carry      : std_logic;
    signal macc_flags_of         : std_logic;
    signal macc_reg_write_enable : std_logic;

    -- write_back

    function sign_extend(imm_value : t_op_imm) return t_data is
        variable result: t_data;
    begin
        result(imm_value'length - 1 downto 0)             := imm_value;
        result(result'length - 1 downto imm_value'length) := (others => imm_value(imm_value'length - 1));
        return result;
    end function;

begin

    -- debug output
    debug_flags <= register_file(to_integer(unsigned(reg_addr_flags)));
    debug_pc    <= register_file(to_integer(unsigned(reg_addr_pc)));
    debug_link  <= register_file(to_integer(unsigned(reg_addr_link)));

    fetch: process (clk) is
        variable pc : t_data;
    begin
        if rising_edge(clk) then

            pc := register_file(to_integer(unsigned(reg_addr_pc)));

            instr_addr        <= pc;
            fetch_next_seq_pc <= std_logic_vector(unsigned(pc) + 1);

        end if;
    end process fetch;

    decoder_instance: decoder
        generic map (
            data_len => data_len
        )
        port map (
            -- Inputs
            instr => instr_in,

            -- Outputs
            op_code      => indec_op_code,
            alu_op_sel   => indec_op_sel,
            reg_select_1 => indec_reg_select_1,
            reg_select_2 => indec_reg_select_2,
            reg_select_3 => indec_reg_select_3,
            reg_target   => indec_target,
            write_en     => indec_reg_write_enable,
            immediate    => indec_immediate,
            op2_sel      => indec_op2_sel
        );

    inst_decode: process (clk) is
        variable reg_flags: t_data;
    begin
        if rising_edge(clk) then
            --decoder.instr <= instr_in;

            reg_flags := register_file(to_integer(unsigned(reg_addr_flags)));

            --indec_op_code <= decoder.op_code;
            --indec_op_sel <= decoder.alu_op_sel;
            --indec_target <= decoder.reg_target;

            indec_op_1      <= register_file(to_integer(unsigned(indec_reg_select_1)));
            indec_datastore <= register_file(to_integer(unsigned(indec_reg_select_3)));

            if indec_op2_sel = '1' then
                indec_op_2 <= register_file(to_integer(unsigned(indec_reg_select_2)));

            elsif indec_op2_sel = '0' then
                -- sign extend
                --indec_op_2 <= sign_extend(decoder.immediate);
                indec_op_2 <= sign_extend(indec_immediate);

            else
                -- TODO is just else sufficient?
                report "indec_op2_sel was neither 0 nor 1"
                severity error;
            end if;

            -- Read flags
            -- 00000000000000000000000000000000
            --                                ^compare
            --                               ^carry
            --                              ^overflow
            indec_flags_comp  <= reg_flags(0);
            indec_flags_carry <= reg_flags(1);
            indec_flags_of    <= reg_flags(2);

            --indec_reg_write_enable <= decoder.write_en;
            indec_next_seq_pc <= fetch_next_seq_pc;
        end if;
    end process inst_decode;

    alu_instance: alu
        generic map (
            data_len => data_len
        )
        port map (
            -- Inputs
            alu_op_code => indec_op_sel,
            op_1        => indec_op_1,
            op_2        => indec_op_2,
            carry_in    => indec_flags_carry,
            of_in       => indec_flags_of,
            comp_in     => indec_flags_comp,

            -- Outputs
            result    => exec_result,
            carry_out => exec_flags_carry,
            of_out    => exec_flags_of,
            comp_out  => exec_flags_comp
        );

    execute: process (clk) is
    begin
        if rising_edge(clk) then
            exec_op_code          <= indec_op_code;
            exec_target           <= indec_target;
            exec_datastore        <= indec_datastore;
            exec_next_seq_pc      <= indec_next_seq_pc;
            exec_reg_write_enable <= indec_reg_write_enable;

            --alu.alu_op_sel <= indec_op_sel;
            
            
            --alu.op_1 <= indec_op_1
		    --alu.op_2 <= indec_op_2
            --alu.carry_in <= indec_flags_carry;
            --alu.of_in <= indec_flags_of
            --alu.comp_in <= indec_flags_comp;

            --wait;

            --exec_flags_carry <= alu.carry_out;
            --exec_flags_of <= alu.of_out;
            --exec_flags_comp <=  alu.comp_out;


            --exec_result <= alu.result;

        end if;
    end process execute;

    mem_access: process (clk) is
    begin
        if rising_edge(clk) then

            macc_op_code     <= exec_op_code;
            macc_target      <= exec_target;
            macc_result      <= exec_result;
            macc_flags_comp  <= exec_flags_comp;
            macc_flags_carry <= exec_flags_carry;
            macc_flags_of    <= exec_flags_of;

            macc_reg_write_enable <= exec_reg_write_enable;

            case macc_op_code is

                when op_JMP =>
                    register_file(to_integer(unsigned(reg_addr_pc)))   <= exec_result;
                    register_file(to_integer(unsigned(reg_addr_link))) <= exec_next_seq_pc;
                    --instr_addr <= exec_result;

                when op_B =>
                    if exec_flags_comp = '1' then
                        register_file(to_integer(unsigned(reg_addr_pc)))   <= exec_result;
                        register_file(to_integer(unsigned(reg_addr_link))) <= exec_next_seq_pc;
                        --instr_addr <= exec_result;

                    elsif exec_flags_comp = '0' then
                        register_file(to_integer(unsigned(reg_addr_pc))) <= exec_next_seq_pc;
                        --instr_addr <= exec_next_seq_pc;

                    else
                        -- TODO is just else sufficient?
                        report "exec_flags_comp was neither 0 nor 1"
                        severity error;
                    end if;

                when op_LDR =>
                    --macc_result <= memory_get(result);
                    data_we     <= '0';
                    data_addr   <= exec_result;
                    macc_result <= data_in;  -- TODO does this work (-> timing)?

                    register_file(to_integer(unsigned(reg_addr_pc))) <= exec_next_seq_pc;
                    --instr_addr <= exec_next_seq_pc;
                    
                when op_STR =>
                    --memory_write(result, exec_datastore); --addr then value
                    data_addr <= exec_result;
                    data_out  <= exec_datastore;
                    data_we   <= '1';

                    register_file(to_integer(unsigned(reg_addr_pc))) <= exec_next_seq_pc;
                    --instr_addr <= exec_next_seq_pc;
                    
                when others =>
                    register_file(to_integer(unsigned(reg_addr_pc))) <= exec_next_seq_pc;
                    --instr_addr <= exec_next_seq_pc;

            end case;
        end if;
    end process mem_access;

    write_back: process (clk) is
    begin
        if rising_edge(clk) then

            -- Write back flags
            -- 00000000000000000000000000000000
            --                                ^compare
            --                               ^carry
            --                              ^overflow
            register_file(to_integer(unsigned(reg_addr_flags))) <= (
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
