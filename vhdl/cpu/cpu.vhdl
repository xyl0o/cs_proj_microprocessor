library ieee;
use ieee.numeric_std.all;


-- was muss die CPU können:




entity cpu is
        generic (
            data_len: integer := 32
        );
        port (
            clk: in std_logic;
            data_in: in std_logic_vector(data_len-1 downto 0);
            instr_in: in std_logic_vector(data_len-1 downto 0);

            data_out: out std_logic_vector(data_len-1 downto 0);
            data_addr_out: out std_logic_vector(data_len-1 downto 0);
            instr_addr_out: out std_logic_vector(data_len-1 downto 0);
            data_we: out std_logic

        );
end cpu;

architecture cpu_arc of cpu is

    component alu
        port(
            alu_op_code: in t_alu_op_code;

            op_1: in std_logic_vector(data_len - 1 downto 0);
		    op_2: in std_logic_vector(data_len - 1 downto 0);
		    carryin: in std_logic;

		    result: out std_logic_vector(data_len - 1 downto 0);
		    carryout: out std_logic;
		    overflow: out std_logic;
            compare: out std_logic
        );
    end component;

    component decoder 
        port(
            instr: in t_data;
            op_code: out t_op_code
            alu_op_sel: out t_alu_op_sel;
            reg_select_1: out t_reg_sel;
            reg_select_2: out t_reg_sel;
            immediate: out t_op_imm;
            op2_sel: out std_logic
        );
    end component;

    component register_files 
        port(
            reg_data_1: in t_data;
            reg_out_1: out t_data;
            reg_select_1: in t_reg_sel;
            reg_write_1_enable: in std_logic;

            reg_data_2: in t_data;
            reg_out_2: out t_data;
            reg_select_2: in t_reg_sel;
            reg_write_2_enable: in std_logic;

            reg_data_3: in t_data;
            reg_out_3: out t_data;
            reg_select_3: in t_reg_sel;
            reg_write_3_enable: in std_logic

        );
    end component;

    signal PC : t_data;

    -- fetch
    signal fetch_cmd         : t_data;
    signal fetch_next_seq_pc : t_data;

    --inst_decode
    signal indec_op_code     : t_op_code;
    signal indec_op_sel      : t_alu_op_sel;
    signal indec_target      : t_reg_sel;
    signal indec_datastore   : t_data;
    signal indec_op_1        : t_data;
    signal indec_op_2        : t_data;
    signal indec_flags_comp  : std_logic;
    signal indec_flags_carry : std_logic;
    signal indec_flags_of    : std_logic;
    signal indec_next_seq_pc : t_data;

    --execute
    signal exec_op_code      : t_op_code;
    signal exec_target       : t_data;
    signal exec_datastore    : t_data;
    signal exec_result       : t_data;
    signal exec_flags_comp   : std_logic;
    signal exec_flags_carry  : std_logic;
    signal exec_flags_of     : std_logic;
    signal exec_next_seq_pc  : t_data;

    --mem_access
    signal macc_op_code      : t_op_code;
    signal macc_target       : t_data;
    signal macc_result       : t_data;
    signal macc_flags_comp   : std_logic;
    signal macc_flags_carry  : std_logic;
    signal macc_flags_of     : std_logic;
    signal macc_next_seq_pc  : t_data;

    --write_back


begin

    fetch: process (clk) is
        if risingEdge then
            fetch_cmd <= PC;
            fetch_next_seq_pc <= std_logic_vector(unsigned(PC) + 4);
        end if;
    begin
    end process fetch;

    inst_decode: process is
    begin
        if risingEdge then
            decode.instr <= instr;

            wait;

            register_files.reg_select_1 <= decode.reg_select_1;
            register_files.reg_select_2 <= decode.reg_select_2;

            wait;


            indec_op_code <= decoder.op_code;
            indec_op_sel <= decoder.alu_op_sel;
            indec_target <= decoder.reg_target;
            indec_datastore <= decoder.reg_select_3;
            indec_op_1 <= regAarray(to_integer(unsigned(decoder.reg_select_1)));

            if decoder.op2_sel then
                indec_op_2 <= regAarray(to_integer(unsigned(decoder.reg_select_2)));
            else
                -- sign extend
                indec_op_2 <= sign_extend(decode.immediate);
            end if;

            indec_flags_comp <= "0";
            indec_flags_carry <= "0";
            indec_flags_of <= "0";
            indec_next_seq_pc <= fetch_next_seq_pc;
        end if;
    end process decode;

    execute: process is
    begin
        if risingEdge then

        end if;
    end process execute;

    mem_access: process is
    begin
        if risingEdge then

        end if;
    end process mem_access;

    write_back: process is
    begin
        if risingEdge then

        end if;
    end process write_back;

begin
    
    
