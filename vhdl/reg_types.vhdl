
library ieee;
use ieee.std_logic_1164.all;

use work.constants.data_len;
use work.constants.immediate_len;
use work.constants.reg_addr_len;

package reg_types is
	subtype t_data is std_logic_vector(data_len - 1 downto 0);
	subtype t_op_imm is std_logic_vector(immediate_len - 1 downto 0);
	subtype t_reg_sel is std_logic_vector(reg_addr_len - 1 downto 0);
end package reg_types;
