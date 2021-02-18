
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- https://www.csee.umbc.edu/portal/help/VHDL/packages/numeric_std.vhd

use work.alu_pkg.all;

entity alu is
    generic (
        data_len : positive := 32
    );
    port(
        -- Inputs
        alu_op_code : in t_alu_op_code;
        op_1        : in std_logic_vector(data_len - 1 downto 0);
        op_2        : in std_logic_vector(data_len - 1 downto 0);
        carry_in    : in std_logic;

        -- Outputs
        result    : out std_logic_vector(data_len - 1 downto 0);
        carry_out : out std_logic;
        overflow  : out std_logic;
        comp_eq   : out std_logic;
        comp_gt   : out std_logic
    );
end alu;

architecture alu_arc of alu is
    subtype t_data is std_logic_vector(data_len - 1 downto 0);
    subtype t_udata_ext is unsigned(data_len downto 0);

    signal uop_1, uop_2, uresult : t_udata_ext;

    signal of_add : std_logic;
    signal of_sub : std_logic;

begin

    uop_1 <= '0' & unsigned(op_1);
    uop_2 <= '0' & unsigned(op_2);

    comp_eq <= '1' when to_integer(signed(op_1)) = to_integer(signed(op_2)) else
               '0';

    comp_gt <= '1' when to_integer(signed(op_1)) > to_integer(signed(op_2)) else
               '0';

    of_add <= (uop_1(data_len - 1) nor uop_2(data_len - 1) and uresult(data_len - 1)) or
              (uop_1(data_len - 1) and uop_2(data_len - 1) and not uresult(data_len - 1));

    of_sub <= (not uop_1(data_len -1) and uop_2(data_len -1) and uresult(data_len - 1)) or
              (uop_1(data_len - 1) and not uop_2 (data_len - 1) and not uresult(data_len - 1));

    with alu_op_code select 
        overflow <= of_add when aluop_ADD,
                    of_add when aluop_ADC,
                    of_sub when aluop_SUB,
                    of_sub when aluop_SBC,
                    'U'    when others;

    carry_out <= uresult(data_len);

    calc: process (alu_op_code, uop_1, uop_2) is
    begin
        case alu_op_code is
            when aluop_ADD =>
                uresult <= uop_1 + uop_2;
            when aluop_ADC =>
                uresult <= uop_1 + uop_2 + ("" & carry_in);
            when aluop_SUB =>
                uresult <= uop_1 - uop_2;
            when aluop_SBC =>
                uresult <= uop_1 - uop_2 - 1 + ("" & carry_in);
            when aluop_SL =>
                uresult <= shift_left(uop_1, to_integer(uop_2));
            when aluop_SRA =>
                uresult <= unsigned(shift_right(signed(uop_1), to_integer(uop_2)));
            when aluop_SRL =>
                uresult <= shift_right(uop_1, to_integer(uop_2));
            when aluop_AND =>
                uresult <= uop_1 and uop_2;
            when aluop_ORR =>
                uresult <= uop_1 or uop_2;
            when aluop_XOR =>
                uresult <= uop_1 xor uop_2;
            when aluop_IDOP2 =>
                uresult <= uop_2;
            when others =>
                null;
        end case;
    end process calc;

    result <= std_logic_vector(uresult(result'range));

end alu_arc;
