
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- https://www.csee.umbc.edu/portal/help/VHDL/packages/numeric_std.vhd

package alu_pkg is
    constant alu_op_code_len: integer := 5;
    subtype t_alu_op_code is std_logic_vector(alu_op_code_len - 1 downto 0);

    constant aluop_NOOP  : t_alu_op_code := "00000";
    constant aluop_ADD   : t_alu_op_code := "00001";
    constant aluop_ADC   : t_alu_op_code := "00010";
    constant aluop_SBC   : t_alu_op_code := "00011";
    constant aluop_SL    : t_alu_op_code := "00100";
    constant aluop_SRA   : t_alu_op_code := "00101";
    constant aluop_SRL   : t_alu_op_code := "00110";
    constant aluop_AND   : t_alu_op_code := "00111";
    constant aluop_ORR   : t_alu_op_code := "01000";
    constant aluop_XOR   : t_alu_op_code := "01001";
    constant aluop_CMPEQ : t_alu_op_code := "01010";
    constant aluop_CMPGT : t_alu_op_code := "01011";
    constant aluop_IDOP2 : t_alu_op_code := "01100";

    component alu is
        generic (
            data_len : positive := 32
        );
        port(
            -- Inputs
            alu_op_code : in t_alu_op_code;
            op_1        : in std_logic_vector(data_len - 1 downto 0);
            op_2        : in std_logic_vector(data_len - 1 downto 0);
            carry_in    : in std_logic;
            of_in       : in std_logic;
            comp_in     : in std_logic;

            -- Outputs
            result    : out std_logic_vector(data_len - 1 downto 0);
            carry_out : out std_logic;
            of_out    : out std_logic;
            comp_out  : out std_logic
        );
    end component alu;
end package alu_pkg;
