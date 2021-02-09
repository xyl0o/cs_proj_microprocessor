library ieee;
use ieee.std_logic_1164.all;
use work.decoder_pkg.all;
use work.alu_pkg.all;

package decoder_pkg is
  subtype t_op_code is std_logic_vector(4 downto 0);
  subtype t_reg_addr is std_logic_vector(4 downto 0);

  constant op_CMPEQ: t_op_code := "01001";
  constant op_CMPGT: t_op_code := "01010";
  constant op_MOV:   t_op_code := "01011";
  constant op_JMP:   t_op_code := "01100";
  constant op_B:     t_op_code := "01101";
  constant op_ADC:   t_op_code := "10001";
  constant op_ADD:   t_op_code := "10010";
  constant op_SBC:   t_op_code := "10011";
  constant op_SUB:   t_op_code := "10100";
  constant op_SL:    t_op_code := "10101";
  constant op_SRA:   t_op_code := "10110";
  constant op_SRL:   t_op_code := "10111";
  constant op_AND:   t_op_code := "11000";
  constant op_ORR:   t_op_code := "11001";
  constant op_XOR:   t_op_code := "11010";
  constant op_LDR:   t_op_code := "11011";
  constant op_STR:   t_op_code := "11100";
  constant op_NOP:   t_op_code := "11111";

  component decoder is
      port(
        instr        : in std_logic_vector(31 downto 0);
        op_code      : out t_op_code;
        alu_op_sel   : out t_alu_op_code;
        reg_select_1 : out t_reg_addr;
        reg_select_2 : out t_reg_addr;
        reg_select_3 : out t_reg_addr;
        reg_target   : out t_reg_addr;
        immediate    : out std_logic_vector(15 downto 0);
        op2_sel      : out std_logic; -- 1 if immediate
        write_en     : out std_logic  -- 1 if write in register
      );
  end component decoder;
end package decoder_pkg;
