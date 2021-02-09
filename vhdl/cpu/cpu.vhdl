library ieee;
use ieee.numeric_std.all;

use work.decoder_pkg.all;
use work.alu_pkg.all;

package cpu_pkg is
    constant data_len: positive := 32;
end package cpu_pkg;

use work.cpu_pkg.all;

entity cpu is
    generic (
        data_len: positive := data_len
    );

    port (
        clk: in std_logic;

        -- instruction memory
        instr_in: in std_logic_vector(data_len - 1 downto 0);

        instr_addr: out std_logic_vector(data_len - 1 downto 0);

        -- data memory
        data_in: in std_logic_vector(data_len - 1 downto 0);

        data_out: out std_logic_vector(data_len - 1 downto 0);
        data_addr: out std_logic_vector(data_len - 1 downto 0);
        data_we: out std_logic
    );
end cpu;

architecture cpu_arc of cpu is

    subtype t_data is std_logic_vector(data_len - 1 downto 0);

    signal PC                     : t_data;
    signal flag_carry             : std_logic;
    signal flag_of                : std_logic;
    signal flag_comp              : std_logic;

    -- fetch
    signal fetch_cmd              : t_data;
    signal fetch_next_seq_pc      : t_data;

    -- inst_decode
    signal indec_op_code          : t_op_code;
    signal indec_op_sel           : t_alu_op_sel;
    signal indec_target           : t_reg_sel;
    signal indec_datastore        : t_data;
    signal indec_op_1             : t_data;
    signal indec_op_2             : t_data;
    signal indec_flags_comp       : std_logic;
    signal indec_flags_carry      : std_logic;
    signal indec_flags_of         : std_logic;
    signal indec_reg_write_enable : std_logic;
    signal indec_next_seq_pc      : t_data;

    -- internal signals to inst_decode
    signal indec_reg_select_1     : t_data;
    signal indec_reg_select_2     : t_data;
    signal indec_reg_select_3     : t_data;
    signal indec_op2_sel          : t_data;
    signal indec_immediate        : t_op_imm;

    -- execute
    signal exec_op_code           : t_op_code;
    signal exec_target            : t_data;
    signal exec_datastore         : t_data;
    signal exec_result            : t_data;
    signal exec_flags_comp        : std_logic;
    signal exec_flags_carry       : std_logic;
    signal exec_flags_of          : std_logic;
    signal exec_reg_write_enable  : std_logic;
    signal exec_next_seq_pc       : t_data;

    -- mem_access
    signal macc_op_code           : t_op_code;
    signal macc_target            : t_data;
    signal macc_result            : t_data;
    signal macc_flags_comp        : std_logic;
    signal macc_flags_carry       : std_logic;
    signal macc_flags_of          : std_logic;
    signal macc_reg_write_enable  : std_logic;
    signal macc_next_seq_pc       : t_data;

    -- write_back

begin

    decoder: decoder
        generic map (
            data_len => data_len
        )
        port map (
            instr        => instr_in,

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

    alu: alu
        generic map (
            data_len => data_len
        )
        port map (
            alu_op_code => indec_op_sel,
            op_1        => indec_op_1,
            op_2        => indec_op_2,
            carry_in    => indec_flags_carry,
            of_in       => indec_flags_of,
            comp_in     => indec_flags_comp,

            -- Outputs
            result      => exec_result,
            carry_out   => exec_flags_carry,
            of_out      => exec_flags_of,
            comp_out    => exec_flags_comp
        );

    fetch: process (clk) is
        if risingEdge(clk) then
            fetch_cmd <= PC;
            fetch_next_seq_pc <= std_logic_vector(unsigned(PC) + 4);
        end if;
    begin
    end process fetch;

    inst_decode: process (clk) is
    begin
        if risingEdge(clk) then
            --decoder.instr <= instr_in;

            --indec_op_code <= decoder.op_code;
            --indec_op_sel <= decoder.alu_op_sel;
            --indec_target <= decoder.reg_target;
            indec_datastore <= regAarray(to_integer(unsigned(indec_reg_select_3)));
            indec_op_1 <= regAarray(to_integer(unsigned(indec_reg_select_1)));

            if indec_op2_sel then
                indec_op_2 <= regAarray(to_integer(unsigned(indec_reg_select_2)));
            else
                -- sign extend
                --indec_op_2 <= sign_extend(decoder.immediate);
                indec_op_2(15 downto 0)  <= indec_immediate;
                indec_op_2(31 downto 16) <= (others => indec_immediate(15));
            end if;

            indec_flags_carry <= flag_carry;
            indec_flags_of <= flag_of;
            indec_flags_comp <= flag_comp;

            --indec_reg_write_enable <= decoder.write_en;
            indec_next_seq_pc <= fetch_next_seq_pc;
        end if;
    end process decode;

    execute: process (clk) is
    begin
        if risingEdge(clk) then
            exec_opcode           <= indec_opcode;
            exec_target           <= indec_target;
            exec_datastore        <= indec_datastore;
            exec_next_seq_pc      <= indec_exec_next_seq_pc;
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
        if risingEdge(clk) then
            macc_op_code <= exec_op_code;
            macc_target <= exec_target;
            macc_result <= exec_result;
            macc_flags_comp <= exec_flags_comp;
            macc_flags_carry <= exec_flags_carry;
            macc_flags_of <= exec_flags_of;

            macc_reg_write_enable <= exec_reg_write_enable;

            case op_code is
                when "JMP" =>
                    PC <= exec_result;
                    link_reg <= exec_next_seq_pc;
                    instr_addr <= exec_result;

                when "B" =>
                    if exec_flags_comp then
                        PC <= exec_result;
                        link_reg <= exec_next_seq_pc;
                        instr_addr <= exec_result;
                    else
                        PC <= exec_next_seq_pc;
                        instr_addr <= exec_next_seq_pc;
                    end if;
                when "LDR" =>
                    --macc_result <= memory_get(result);
                    data_we <= "0";
                    data_addr <= exec_result;
                    macc_result <= data_in;  -- TODO does this work (-> timing)?

                    PC <= exec_next_seq_pc;
                    instr_addr <= exec_next_seq_pc;
                    
                when "STR" =>
                    --memory_write(result, exec_datastore); --addr then value
                    data_addr <= exec_result;
                    data_out <= exec_datastore;
                    data_we <= "1";

                    PC <= exec_next_seq_pc;
                    instr_addr <= exec_next_seq_pc;
                    
                when others =>
                    PC <= exec_next_seq_pc;
                    instr_addr <= exec_next_seq_pc;

            end case;
        end if;
    end process mem_access;

    write_back: process (clk) is
    begin
        if risingEdge(clk) then
            
            flag_comp   <= macc_flags_comp;
            flag_carry  <= macc_flags_carry;
            flag_of     <= macc_flags_of;

            if macc_reg_write_enable then
                --TODO : add write enable for flags too decode
                regAarray(to_integer(unsigned(macc_target))) <= macc_result;

            end if; 
            
        end if;
    end process write_back;
begin
    
    
  