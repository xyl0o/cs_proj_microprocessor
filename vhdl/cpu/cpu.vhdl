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

    component sign_ext 
        port(
            imm_in: in t_op_imm;
            op_out: out t_data
     
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
            reg_select_1: in t_reg_sel;
            reg_select_2: in t_reg_sel;
            reg_data_1: in t_data;
            reg_data_2: in t_data;
            reg_write_1_enable: in std_logic;
            reg_write_2_enable: in std_logic
            reg_out_1: out t_data;
            reg_out_2: out t_data

        );
    end component;

    component pc_select
        port(
            op_code: in t_op_code;
            next_seq_pc: in t_data;
            alu_result: in t_data;

            next_pc: out t_data

        );
    end component;
    
    
    component adder
        port(
            op_1: in t_data;
            op_2: in t_data;
            op_out: out t_data

        );
    end component;


    component pipeline_reg
        port(
            clk: in std_logic;
            data_in: in std_logic_vector(data_len -1 downto 0);
            
            data_out: out std_logic_vector(data_len -1 downto 0)

            );
    end component;




begin
    
    
