library ieee;
use ieee.std_logic_1164.all;

package decoder_pkg is
  component decoder is
      port(
        instr                 : in std_logic_vector(31 downto 0);
        op_code               : out std_logic_vector(31 downto 0);
        alu_op_sel            : out std_logic_vector(31 downto 0);
        reg_select_1          : out std_logic_vector(7 downto 0);
        reg_select_2          : out std_logic_vector(7 downto 0);
        reg_select_3          : out std_logic_vector(7 downto 0);
        reg_target            : out std_logic_vector(7 downto 0);
        immediate             : out std_logic_vector(15 downto 0);
        op2_sel               : out std_logic_vector(31 downto 0);
        write_en              : out std_logic;                -- write in register 
      );
  end component decoder;
end package decoder_pkg;

-----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.decoder_pkg.all;

entity decoder is
    port(
        instr                 : in std_logic_vector(31 downto 0);
        op_code               : out std_logic_vector(31 downto 0);
        alu_op_sel            : out std_logic_vector(31 downto 0);
        reg_select_1          : out std_logic_vector(7 downto 0);
        reg_select_2          : out std_logic_vector(7 downto 0);
        reg_select_3          : out std_logic_vector(7 downto 0);
        reg_target            : out std_logic_vector(7 downto 0);
        immediate             : out std_logic_vector(15 downto 0);
        op2_sel               : out std_logic_vector(31 downto 0);
        write_en              : out std_logic;
    )
end entity decoder;

architecture decoding of decoder is
begin

    decoding_process: process (instr) is

        variable op_code_i  : std_logic_vector(5 downto 0);

    begin

        op_code_i <= instr(31 downto 26)

        case po_code_i is
            -- when "000000" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;
            -- when "000001" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;


            when "010010" => -- CMPEQ
            when "010011" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "010100" => -- CMPGT
            when "010101" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "010110" => -- MOV
            when "010111" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "011000" => -- JMP
            when "011001" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "011010" => -- B 
            when "011011" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "100010" => -- ADC 
            when "100011" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "100100" => -- ADD 
            when "100101" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X; 

            when "100110" => -- SBC
            when "100111" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X; 

            when "101000" => -- SUB 
            when "101001" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X; 

            when "101010" => -- SL
            when "101011" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X; 

            when "101100" => -- SRA
            when "101101" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "101110" => -- SRL
            when "101111" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "110000" => -- AND
            when "110001" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "110010" => -- ORR
            when "110011" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "110100" => -- XOR
            when "110101" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "110110" => -- LDR
            when "110111" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "111000" => -- STR
            when "111001" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when "111110" => -- NOP
            when "111111" => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

            when others => op_code <= op_code_i(5 downto 1);
            --                    alu_op_sel <= XXX;
            --                    reg_select_1 <= XXX;
            --                    reg_select_2 <= XXX;
            --                    reg_select_3 <= XXX;
            --                    reg_target <= XXX;
            --                    immediate <= XXX;
            --                    op2_sel <= XXX;
            --                    write_en <= X;

    end process decoding_process;
end architecture decoding;

