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

    type t_register_file is array(0 to 30) of t_data;

    signal register_file : t_register_file := (others => (others => '0'));

    alias reg_zero : t_data is register_file(to_integer(unsigned(reg_addr_zero)));
    alias reg_flag : t_data is register_file(to_integer(unsigned(reg_addr_flags)));
    alias reg_link : t_data is register_file(to_integer(unsigned(reg_addr_link)));

    signal reg_pc : t_data := (others => '0');


    ----------------------------------------------------------------------------
    --- Control signals

    signal sig_flush  : std_logic;


    ----------------------------------------------------------------------------
    --- Fetch signals

    -- Inputs
    signal fetch_in_instr : t_data := (others => '0');
    signal fetch_in_flush : std_logic;

    -- Outputs
    signal fetch_out_instr : t_data := (others => '0');
    signal fetch_out_flush : std_logic;


    ----------------------------------------------------------------------------
    --- Instruction decode signals

    -- Inputs
    signal indec_in_instr : t_data := (others => '1');
    signal indec_in_flush : std_logic;

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
    signal indec_out_reg_write_enable : std_logic;
    signal indec_out_flush            : std_logic;


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
    signal exec_in_reg_write_enable : std_logic;
    signal exec_in_flush            : std_logic;

    -- Outputs
    signal exec_out_op_code          : t_op_code := op_NOP;
    signal exec_out_target           : t_reg_addr;
    signal exec_out_datastore        : t_data;
    signal exec_out_result           : t_data;
    signal exec_out_flags_comp       : std_logic;
    signal exec_out_alu_carry        : std_logic;
    signal exec_out_alu_comp_eq      : std_logic;
    signal exec_out_alu_comp_gt      : std_logic;
    signal exec_out_alu_of           : std_logic;
    signal exec_out_reg_write_enable : std_logic;
    signal exec_out_flush            : std_logic;


    ----------------------------------------------------------------------------
    --- Memory access signals

    -- Inputs
    signal macc_in_op_code          : t_op_code := op_NOP;
    signal macc_in_target           : t_reg_addr;
    signal macc_in_datastore        : t_data;
    signal macc_in_result           : t_data;
    signal macc_in_flags_comp       : std_logic;
    signal macc_in_alu_carry        : std_logic;
    signal macc_in_alu_comp_eq      : std_logic;
    signal macc_in_alu_comp_gt      : std_logic;
    signal macc_in_alu_of           : std_logic;
    signal macc_in_reg_write_enable : std_logic;
    signal macc_in_flush            : std_logic;

    -- Outputs
    signal macc_out_op_code          : t_op_code := op_NOP;
    signal macc_out_target           : t_reg_addr;
    signal macc_out_result           : t_data;
    signal macc_out_alu_carry        : std_logic;
    signal macc_out_alu_comp_eq      : std_logic;
    signal macc_out_alu_comp_gt      : std_logic;
    signal macc_out_alu_of           : std_logic;
    signal macc_out_reg_write_enable : std_logic;
    signal macc_out_will_jump        : std_logic;
    signal macc_out_flush            : std_logic;


    ----------------------------------------------------------------------------
    --- Functions

    impure function reg_access(reg_addr: t_reg_addr) return t_data is
    begin
        if reg_addr = reg_addr_pc then
            return reg_pc;
        else
            return register_file(to_integer(unsigned(reg_addr)));
        end if;
    end function;

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


    ----------------------------------------------------------------------------
    --- Fetch

    instr_addr <= reg_pc;

    fetch_pipeline: process (clk) is
    begin
        if rising_edge(clk) then
            fetch_in_instr <= instr_in;
        end if;
    end process fetch_pipeline;

    -- passthrough
    fetch_out_instr <= fetch_in_instr;

    fetch_out_flush <= sig_flush;


    ----------------------------------------------------------------------------
    --- Instruction decode

    indec_pipeline: process (clk) is
    begin
        if rising_edge(clk) then
            indec_in_instr <= instr_in;
            indec_in_flush <= fetch_out_flush;
        end if;
    end process indec_pipeline;

    -- passthrough

    indec_out_flush <= indec_in_flush or sig_flush;

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
    indec_out_op_1 <= reg_access(indec_reg_select_1);

    with indec_op2_sel select
        indec_out_op_2 <= reg_access(indec_reg_select_2) when '0',
                          sign_extend(indec_immediate)   when '1',
                          (others => '0')                when others;

    indec_out_datastore   <= reg_access(indec_reg_select_3);
    indec_out_flags_comp  <= reg_flag(0);
    indec_out_flags_carry <= reg_flag(1);


    ----------------------------------------------------------------------------
    --- Execute

    exec_pipeline: process (clk) is
    begin
        if rising_edge(clk) then
            exec_in_datastore        <= indec_out_datastore;
            exec_in_flags_carry      <= indec_out_flags_carry;
            exec_in_flags_comp       <= indec_out_flags_comp;
            exec_in_op_1             <= indec_out_op_1;
            exec_in_op_2             <= indec_out_op_2;
            exec_in_op_code          <= indec_out_op_code;
            exec_in_op_sel           <= indec_out_op_sel;
            exec_in_reg_write_enable <= indec_out_reg_write_enable;
            exec_in_target           <= indec_out_target;
            exec_in_flush            <= indec_out_flush;
        end if;
    end process exec_pipeline;

    -- passthrough
    exec_out_datastore        <= exec_in_datastore;
    exec_out_flags_comp       <= exec_in_flags_comp;
    exec_out_op_code          <= exec_in_op_code;
    exec_out_reg_write_enable <= exec_in_reg_write_enable;
    exec_out_target           <= exec_in_target;

    exec_out_flush <= exec_in_flush or sig_flush;

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

            -- Outputs
            result    => exec_out_result,
            carry_out => exec_out_alu_carry,
            overflow  => exec_out_alu_of,
            comp_eq   => exec_out_alu_comp_eq,
            comp_gt   => exec_out_alu_comp_gt
        );


    ----------------------------------------------------------------------------
    --- Memory access

    macc_pipeline: process (clk) is
    begin
        if rising_edge(clk) then
            macc_in_datastore        <= exec_out_datastore;
            macc_in_flags_comp       <= exec_out_flags_comp;
            macc_in_alu_carry        <= exec_out_alu_carry;
            macc_in_alu_comp_eq      <= exec_out_alu_comp_eq;
            macc_in_alu_comp_gt      <= exec_out_alu_comp_gt;
            macc_in_alu_of           <= exec_out_alu_of;
            macc_in_op_code          <= exec_out_op_code;
            macc_in_reg_write_enable <= exec_out_reg_write_enable;
            macc_in_result           <= exec_out_result;
            macc_in_target           <= exec_out_target;
            macc_in_flush            <= exec_out_flush;
        end if;
    end process macc_pipeline;

    -- passthrough
    macc_out_alu_carry        <= macc_in_alu_carry;
    macc_out_alu_comp_eq      <= macc_in_alu_comp_eq;
    macc_out_alu_comp_gt      <= macc_in_alu_comp_gt;
    macc_out_alu_of           <= macc_in_alu_of;
    macc_out_op_code          <= macc_in_op_code;
    macc_out_reg_write_enable <= macc_in_reg_write_enable;
    macc_out_target           <= macc_in_target;

    macc_out_flush <= macc_in_flush or sig_flush;

    -- determine pc and link values
    macc_out_will_jump <= '1'                when macc_in_op_code = op_JMP else
                          macc_in_flags_comp when macc_in_op_code = op_B   else
                          '0';

    -- When STR or LDF instruction: set data_addr to macc_in_result
    with macc_in_op_code select
        data_addr <= macc_in_result  when op_LDR,
                     macc_in_result  when op_STR,
                     (others => '0') when others;

    -- When STR instruction: set data_out to macc_in_datastore
    with macc_in_op_code select
        data_out <= macc_in_datastore when op_STR,
                    (others => '0')   when others;

    -- When STR instruction: set data_we to '1'
    -- do not set when flushing
    data_we <= '0' when macc_out_flush  = '1'    else
               '1' when macc_in_op_code = op_STR else
               '0';

    -- When LDR instruction: set macc_out_result to data_in
    with macc_in_op_code select
        macc_out_result <= data_in        when op_LDR,
                           macc_in_result when others;


    ----------------------------------------------------------------------------
    --- Write back

    sig_flush <= '1' when macc_out_op_code = op_HLT else '0';

    wback_pc_set: process(clk) is
    begin
        if rising_edge(clk) then
            if macc_out_op_code = op_HLT then
                null;
            elsif macc_out_will_jump = '1' then
                reg_pc <= macc_out_result;
            else
                reg_pc <= std_logic_vector(unsigned(reg_pc) + 1);
            end if;
        end if;
    end process wback_pc_set;


    wback_pipeline: process (clk) is
    begin
        if rising_edge(clk) then
            if macc_out_will_jump = '1' then
                reg_link <= reg_pc; -- TODO - 4 ??
            end if;

            case macc_out_op_code is

                when op_CMPEQ =>
                    reg_flag(0) <= macc_out_alu_comp_eq;

                when op_CMPGT =>
                    reg_flag(0) <= macc_out_alu_comp_gt;

                when op_ADD | op_ADC | op_SUB | op_SBC =>
                    reg_flag(1) <= macc_out_alu_carry;
                    reg_flag(2) <= macc_out_alu_of;

                when others =>
                    null;
            end case;

            if macc_out_reg_write_enable = '1' then

                -- disallow writes to pc and zero register
                case macc_out_target is
                    when reg_addr_pc =>
                        null;
                    when reg_addr_zero =>
                        null;
                    when others =>
                        -- TODO disabled for now
                        register_file(to_integer(unsigned(macc_out_target))) <= macc_out_result;
                end case;
            end if;
        end if;
    end process wback_pipeline;

end cpu_arc;
