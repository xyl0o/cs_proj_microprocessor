library ieee;
use ieee.std_logic_1164.all;
use work.decoder_pkg.all;
use work.alu_pkg.all;
use work.decoder_pkg.all;

entity decoder is
  generic (
    data_len : positive := 32
  );
  port(
    -- Inputs
    instr : in std_logic_vector(data_len - 1 downto 0);

    -- Outputs
    op_code      : out t_op_code;
    alu_op_sel   : out t_alu_op_code;
    reg_select_1 : out t_reg_addr;
    reg_select_2 : out t_reg_addr;
    reg_select_3 : out t_reg_addr;
    reg_target   : out t_reg_addr;
    immediate    : out t_op_imm;
    op2_sel      : out std_logic; -- 1 if immediate
    write_en     : out std_logic  -- 1 if write in register
  );
end entity decoder;

architecture decoder_arc of decoder is
begin

    decoding_process: process (instr) is

        variable op_code_i     : std_logic_vector(5 downto 0);
        variable tmp_immediate : t_op_imm;

    begin

        op_code_i := instr(31 downto 26);
        tmp_immediate := instr(15 downto 0);

        op_code <= op_code_i(5 downto 1);
        op2_sel <= instr(26);

        case op_code_i is

            -- CMPEQ
            when op_CMPEQ & '0' =>
                alu_op_sel   <= aluop_CMPEQ;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(20 downto 16);
                write_en     <= '1';

            when op_CMPEQ & '1' =>
                alu_op_sel   <= aluop_CMPEQ;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(20 downto 16);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- CMPGT
            when op_CMPGT & '0' =>
                alu_op_sel   <= aluop_CMPGT;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(20 downto 16);
                write_en     <= '1';

            when op_CMPGT & '1' =>
                alu_op_sel   <= aluop_CMPGT;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(20 downto 16);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- MOV
            when op_MOV & '0' =>
                alu_op_sel   <= aluop_IDOP2;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(20 downto 16);
                write_en     <= '1';

            when op_MOV & '1' =>
                alu_op_sel   <= aluop_IDOP2;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(20 downto 16);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- JMP
            when op_JMP & '0' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(20 downto 16);

            when op_JMP & '1' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(20 downto 16);
                immediate    <= tmp_immediate;

            -- B
            when op_B & '0' =>
                alu_op_sel <= aluop_ADD;
                reg_target <= instr(15 downto 11);

            when op_B & '1' =>
                alu_op_sel <= aluop_ADD;
                immediate  <= tmp_immediate;

            -- ADC
            when op_ADC & '0' =>
                alu_op_sel   <= aluop_ADC;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';
           
            when op_ADC & '1' =>
                alu_op_sel   <= aluop_ADC;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- ADD
            when op_ADD & '0' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_ADD & '1' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- SBC
            when op_SBC & '0' =>
                alu_op_sel   <= aluop_SBC;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_SBC & '1' =>
                alu_op_sel   <= aluop_SBC;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- SUB
            when op_SUB & '0' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_SUB & '1' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- SL
            when op_SL & '0' =>
                alu_op_sel   <= aluop_SL;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_SL & '1' =>
                alu_op_sel   <= aluop_SL;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- SRA
            when op_SRA & '0' =>
                alu_op_sel   <= aluop_SRA;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_SRA & '1' =>
                alu_op_sel   <= aluop_SRA;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- SRL
            when op_SRL & '0' =>
                alu_op_sel   <= aluop_SRL;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_SRL & '1' =>
                alu_op_sel   <= aluop_SRL;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- AND
            when op_AND & '0' =>
                alu_op_sel   <= aluop_AND;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_AND & '1' =>
                alu_op_sel   <= aluop_AND;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- ORR
            when op_ORR & '0' =>
                alu_op_sel   <= aluop_ORR;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_ORR & '1' =>
                alu_op_sel   <= aluop_ORR;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- XOR
            when op_XOR & '0' =>
                alu_op_sel   <= aluop_XOR;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_XOR & '1' =>
                alu_op_sel   <= aluop_XOR;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- LDR
            when op_LDR & '0' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_target   <= instr(25 downto 21);
                write_en     <= '1';

            when op_LDR & '1' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_target   <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '1';

            -- STR
            when op_STR & '0' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_select_2 <= instr(15 downto 11);
                reg_select_3 <= instr(25 downto 21);
                write_en     <= '0';

            when op_STR & '1' =>
                alu_op_sel   <= aluop_ADD;
                reg_select_1 <= instr(20 downto 16);
                reg_select_3 <= instr(25 downto 21);
                immediate    <= tmp_immediate;
                write_en     <= '0';

            -- NOP
            when op_NOP & '0' =>
                alu_op_sel <= aluop_NOOP;

            when op_NOP & '1' =>
                alu_op_sel <= aluop_NOOP;

            -- Others
            when others =>
                alu_op_sel <= aluop_NOOP;
        end case;
    end process decoding_process;
end architecture decoder_arc;
