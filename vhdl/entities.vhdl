
use work.reg_types.all;
use work.op_codes.all;
use work.alu_op_sel.all;

-- this entity should extend the immediate input value
-- to a 32 signed bit value
entity sign_ext is
	generic (
		data_len: integer -- data width
	);
	port (
		imm_in: in t_op_imm;
		op_out: out t_data
	);
end sign_ext;

-- this entity shall output
--   which registers to get (their address)
--   which immediate value to extend
--   which alu op to pass on
--   which target value to write back to in WB
--   which op2 to select
entity decoder is
	generic (
		instr_len: integer -- instruction width
	);
	port (
		instr: in t_data;
		op_code: out t_op_code
		alu_op_sel: out t_alu_op_sel;
		reg_select_1: out t_reg_sel;
		reg_select_2: out t_reg_sel;
		immediate: out t_op_imm;
		op2_sel: out std_logic
	);
end decoder;

-- the register file entity accepts two register addresses
-- it outputs their values
entity register_file is
	generic (
		instr_len: integer -- instruction width
	);
	port (
		reg_select_1: in t_reg_sel;
		reg_select_2: in t_reg_sel;
		reg_data_1: in t_data;
		reg_data_2: in t_data;
		reg_write_1_enable: in std_logic;
		reg_write_2_enable: in std_logic
		reg_out_1: out t_data;
		reg_out_2: out t_data
	);
end register_file;


-- the instruction memory accepts and address
-- and outputs the bytes at that address
entity instruction_memory is
	port (
		instr_addr: in t_data;
		instr_out: out t_data
	);
end instruction_memory;

-- the instruction memory accepts and address
-- and optionally a data value and either writes
-- the data value to that address or outputs the
-- data value from that address
entity data_memory is
	port (
		data_addr: in t_data;
		data_in: in t_data;
		data_out: out t_data;

		write_enable: in std_logic
	);
end data_memory;

-- this entity - depending on the instruction -
-- either outputs the "next pc" value or the
-- result from the alu
entity pc_select is
	port (
		op_code: in t_op_code;
		next_seq_pc: in t_data;
		alu_result: in t_data;

		next_pc: out t_data
	);
end pc_select;


-- this adder accepts two data_len long (signed?) inputs
-- and outputs their sum
entity adder is
	port (
		op_1: in t_data;
		op_2: in t_data;
		op_out: out t_data
	);
end adder;