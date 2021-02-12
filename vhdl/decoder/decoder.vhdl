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
    type t_op_layout is (THREEOP, TWOOP, ONEOP);

    signal op_layout : t_op_layout;

    alias instr_op_code : t_op_code is instr(31 downto 27);
    alias instr_imm_bit : std_logic is instr(26);
    alias instr_op_imm  : t_op_imm is instr(15 downto 0);

    alias instr_opX : t_reg_addr is instr(25 downto 21);
    alias instr_opY : t_reg_addr is instr(20 downto 16);
    alias instr_opZ : t_reg_addr is instr(15 downto 11);

begin
    with instr_op_code(4 downto 3) select
        op_layout <= ONEOP   when "00",
                     TWOOP   when "01",
                     THREEOP when others;

    op_code <= instr_op_code;

    with instr_op_code select
        alu_op_sel <= aluop_CMPEQ when op_CMPEQ,
                      aluop_CMPGT when op_CMPGT,
                      aluop_IDOP2 when op_MOV,
                      aluop_ADD   when op_JMP,
                      aluop_ADD   when op_B,
                      aluop_ADC   when op_ADC,
                      aluop_ADD   when op_ADD,
                      aluop_SBC   when op_SBC,
                      aluop_ADD   when op_SUB,
                      aluop_SL    when op_SL,
                      aluop_SRA   when op_SRA,
                      aluop_SRL   when op_SRL,
                      aluop_AND   when op_AND,
                      aluop_ORR   when op_ORR,
                      aluop_XOR   when op_XOR,
                      aluop_ADD   when op_LDR,
                      aluop_ADD   when op_STR,
                      aluop_NOOP  when others;

    -- reg_addr of op1
    -- does not apply to op_MOV but is ignored there
    reg_select_1 <= instr_opY;

    -- reg_addr of op2 if not immediate
    reg_select_2 <= instr_opZ;

    -- 1 if sign extended immediate should be op2
    -- 0 if reg(reg_select_2) should be op2
    op2_sel <= instr_imm_bit;

    immediate <= instr_op_imm;

    -- reg_addr to write back to
    -- there is no op where this is in use and not A
    -- only used in three op and MOV instr
    reg_target <= instr_opX when op_layout     = THREEOP else
                  instr_opY when instr_op_code = op_MOV  else
                  (others => '0');

    -- reg_addr of datastore
    -- only used in op_STR
    -- follows reg_target for now
    reg_select_3 <= instr_opX when op_layout     = THREEOP else
                    instr_opY when instr_op_code = op_MOV  else
                    (others => '0');

    -- be sure to set only when necessary
    with instr_op_code select
        write_en <= '1' when op_MOV,
                    '1' when op_ADC,
                    '1' when op_ADD,
                    '1' when op_SBC,
                    '1' when op_SUB,
                    '1' when op_SL,
                    '1' when op_SRA,
                    '1' when op_SRL,
                    '1' when op_AND,
                    '1' when op_ORR,
                    '1' when op_XOR,
                    '1' when op_LDR,
                    '0' when others;

end architecture decoder_arc;
