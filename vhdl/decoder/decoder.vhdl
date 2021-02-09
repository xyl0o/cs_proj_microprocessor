library ieee;
use ieee.std_logic_1164.all;
use work.decoder_pkg.all;
use work.alu_pkg.all;

package decoder_pkg is
  subtype t_op_code is std_logic_vector(4 downto 0);
  subtype t_reg_addr is std_logic_vector(4 downto 0);

  component decoder is
      port(
        instr                 : in std_logic_vector(31 downto 0);
        op_code               : out t_op_code;
        alu_op_sel            : out t_alu_op_code;
        reg_select_1          : out t_reg_addr;
        reg_select_2          : out t_reg_addr;
        reg_select_3          : out t_reg_addr;
        reg_target            : out t_reg_addr;
        immediate             : out std_logic_vector(15 downto 0);
        op2_sel               : out std_logic;                          -- 1 if immediate
        write_en              : out std_logic                           -- 1 if write in register 
      );
  end component decoder;
end package decoder_pkg;

-----------------------------------------------------------------------------------

entity decoder is
    port(
        instr                 : in std_logic_vector(31 downto 0);
        op_code               : out t_op_code;
        alu_op_sel            : out t_alu_op_code;
        reg_select_1          : out t_reg_addr;
        reg_select_2          : out t_reg_addr;
        reg_select_3          : out t_reg_addr;
        reg_target            : out t_reg_addr;
        immediate             : out std_logic_vector(15 downto 0);
        op2_sel               : out std_logic;
        write_en              : out std_logic
    );
end entity decoder;

architecture decoding of decoder is
begin

    decoding_process: process (instr) is

        variable op_code_i  : std_logic_vector(5 downto 0);

    begin

        op_code_i <= instr(31 downto 26);

        case op_code_i is
            -- when "000000" =>   op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;
            -- when "000001" =>   op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            -- CMPEQ
            when "010010" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_CMPEQ;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(20 downto 16);
                                op2_sel <= "0";
                                write_en <= "1";

            when "010011" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_CMPEQ;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(20 downto 16);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";




            -- CMPGT
            when "010100" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_CMPGT;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(20 downto 16);
                                op2_sel <= "0";
                                write_en <= "1";
                        
            when "010101" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_CMPGT;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(20 downto 16);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";


            -- MOV
            when "010110" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_IDOP2;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(20 downto 16);
                                op2_sel <= "0";
                                write_en <= "1";

            when "010111" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_IDOP2;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(20 downto 16);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";


            -- JMP
            when "011000" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(20 downto 16);
                                op2_sel <= "0";

            when "011001" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(20 downto 16);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";


            -- B
            when "011010" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_target <= instr(15 downto 11);
                                op2_sel <= "0";

            when "011011" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_target <= instr(15 downto 0);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";




            -- ADC
            when "100010" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADC;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1";
            
            when "100011" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADC;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";




            -- ADD
            when "100100" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1"; 

            when "100101" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1"; 




            --  SBC
            when "100110" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_SBC;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1"; 

            when "100111" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_SBC;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1"; 




            -- SUB
            when "101000" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1"; 
 
            when "101001" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1"; 




            -- SL
            when "101010" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= "00100";
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1"; 
 
            when "101011" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= "00100";
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1"; 




            -- SRA
            when "101100" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_SRA;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1";
 
            when "101101" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_SRA;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";




            -- SRL
            when "101110" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_SRL;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1";

            when "101111" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_SRL;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";




            -- AND
            when "110000" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_AND;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1";
 
            when "110001" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_AND;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";




            -- ORR
            when "110010" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ORR;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1";
 
            when "110011" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ORR;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";




            -- XOR
            when "110100" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_XOR;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1";
 
            when "110101" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_XOR;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";




            -- LDR
            when "110110" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_target <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "1";

            when "110111" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_target <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "1";




            -- STR
            when "111000" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_2 <= instr(15 downto 11);
                                reg_select_3 <= instr(25 downto 21);
                                op2_sel <= "0";
                                write_en <= "0";
 
            when "111001" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_ADD;
                                reg_select_1 <= instr(20 downto 16);
                                reg_select_3 <= instr(25 downto 21);
                                immediate <= instr(15 downto 0);
                                op2_sel <= "1";
                                write_en <= "0";




            -- NOP
            when "111110" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_NOOP;

            when "111111" =>    op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_NOOP;



            -- Others
            when others =>  op_code <= op_code_i(5 downto 1);
                                alu_op_sel <= aluop_NOOP;
        end case;
    end process decoding_process;
end architecture decoding;
