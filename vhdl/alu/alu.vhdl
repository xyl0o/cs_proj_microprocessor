
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- https://www.csee.umbc.edu/portal/help/VHDL/packages/numeric_std.vhd

package alu_pkg is
	constant alu_op_code_len: integer := 5;
	subtype t_alu_op_code is std_logic_vector(alu_op_code_len - 1 downto 0);

	constant aluop_NOOP:  t_alu_op_code := "00000";
	constant aluop_ADD:   t_alu_op_code := "00001";
	constant aluop_ADC:   t_alu_op_code := "00010";
	constant aluop_SBC:   t_alu_op_code := "00011";
	constant aluop_SL:    t_alu_op_code := "00100";
	constant aluop_SRA:   t_alu_op_code := "00101";
	constant aluop_SRL:   t_alu_op_code := "00110";
	constant aluop_AND:   t_alu_op_code := "00111";
	constant aluop_ORR:   t_alu_op_code := "01000";
	constant aluop_XOR:   t_alu_op_code := "01001";
	constant aluop_CMPEQ: t_alu_op_code := "01010";
	constant aluop_CMPGT: t_alu_op_code := "01011";
	constant aluop_IDOP2: t_alu_op_code := "01100";

    component alu_comp is
        generic (
            data_len   : positive := 32
        );
        port(
            alu_op_code: in t_alu_op_code;

            -- Inputs
            op_1: in std_logic_vector(data_len - 1 downto 0);
            op_2: in std_logic_vector(data_len - 1 downto 0);

            carry_in: in std_logic;
            of_in: in std_logic;
            comp_in: in std_logic;

            -- Outputs
            result: out std_logic_vector(data_len - 1 downto 0);

            carry_out: out std_logic;
            of_out: out std_logic;
            comp_out: out std_logic
        );
    end component alu_comp;
end package alu_pkg;

entity alu is
end alu;

architecture alu_arc of alu is

begin
	arithmetic : process (op_1, op_2, alu_op_code)
		variable tmp_result: unsigned(data_len downto 0);
		variable uop_1: unsigned(data_len downto 0);
		variable uop_2: unsigned(data_len downto 0);
	begin

		carry_out <= carry_in;
		comp_out <= comp_in;

		-- ignore for now.
		-- needs special handling
		of_out <= of_in;

		uop_1 := '0' & unsigned(op_1);
		uop_2 := '0' & unsigned(op_2);

		case alu_op_code is

			when aluop_ADD =>
				tmp_result := uop_1 + uop_2;

			when aluop_ADC =>
			    -- https://electronics.stackexchange.com/questions/463586/vhdl-convert-std-logic-to-std-logic-vector
				tmp_result := uop_1 + uop_2 + "0" & carry_in;
				carry_out <= tmp_result(data_len);

			when aluop_SBC =>
				tmp_result := uop_1 - uop_2 - 1 + "0" & carry_in;
				carry_out <= tmp_result(data_len);

			when aluop_SL =>
				tmp_result := shift_left(uop_1, to_integer(uop_2));

			when aluop_SRA =>
				tmp_result := uop_1(data_len) & shift_right(uop_1, to_integer(uop_2))(data_len downto 1);

			when aluop_SRL =>
				tmp_result := shift_right(uop_1, to_integer(uop_2));

			when aluop_AND =>
				tmp_result := uop_1 and uop_2;

			when aluop_ORR =>
				tmp_result := uop_1 or uop_2;

			when aluop_XOR =>
				tmp_result := uop_1 xor uop_2;

			when aluop_CMPEQ =>
				if to_integer(uop_1) = to_integer(uop_2) then
					comp_out <= '1';
				else
					comp_out <= '0';
				end if;

			when aluop_CMPGT =>
				if to_integer(uop_1) > to_integer(uop_2) then
					comp_out <= '1';
				else
					comp_out <= '0';
				end if;

			when aluop_IDOP2 =>
				tmp_result := uop_2;

			when aluop_NOOP =>
				null;

			when others =>
				null;

		end case;

		result <= std_logic_vector(tmp_result(data_len - 1 downto 0));

	end process arithmetic;
end alu_arc;
