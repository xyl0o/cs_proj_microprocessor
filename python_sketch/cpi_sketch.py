#!/usr/bin/env python3

from util import set_flag, get_flag



reg_zero = "R0"
reg_flags = "R1"
reg_link = "R30"
reg_pc = "R31"

register = {}  # add zero register
memory_inst = {}
memory_data = {}


def alu_decode(op_code):

    if op_code == "NOP":
        return '00000'

    elif op_code == ["ADD", "SUB", "LDR", "STR", "B", "JMP"]:
        return '00001'  # result = op_1 + op_2

    elif op_code == "ADC":
        return '00010'  # result = op_1 + op_2 + flags['Carry']

    elif op_code == "SBC":
        return '00011'  # result = op_1 - op_2 - 1 + flags['Carry']

    elif op_code == "SL":
        return '00100'  # result = shift_left(op_1, op_2)

    elif op_code == "SRA":
        return '00101'  # result = shift_right_arith(op_1, op_2)

    elif op_code == "SRL":
        return '00110'  # result = shift_right_logic(op_1, op_2)

    elif op_code == "AND":
        return '00111'  # result = op_1 & op_2

    elif op_code == "OR":
        return '01000'  # result = op_1 | op_2

    elif op_code == "XOR":
        return '01001'  # result = op_1 ^ op_2

    elif op_code == "CMPEQ":
        return '01010'  # flags = set_flag(flags, "CMP", bool(op_1 - op_2 == 0))

    elif op_code == "CMPGT":
        return '01011'  # flags = set_flag(flags, "CMP", bool(op_1 - op_2 > 0))

    elif op_code == "MOV":
        return '01100'  # result = op_2

def inst_fetch():
    pc = register.get(reg_pc)
    cmd = memory_inst.get(pc)

    if not cmd:
        raise

    return cmd, pc + 4

def inst_decode(cmd, next_seq_pc):

    op_code = cmd[31:26]

    immediate = bool(cmd[26] == 1)

    if op_code == "NOP":
        return

    elif op_code == "STR":  # do we have to do this?
        target = None
        op_1 = register.get(cmd[20:15])
        op_2 = cmd[15:] if immediate else register.get(cmd[15:10])
        datastore = register.get(cmd[25:20])

    # three op cmd
    elif op_code[31] == 1:
        target = cmd[25:20]
        op_1 = register.get(cmd[20:15])
        op_2 = cmd[15:] if immediate else register.get(cmd[15:10])
        datastore = None

    # two op cmd
    elif op_code[30] == 1:
        target = cmd[20:15]
        op_1 = register.get(cmd[20:15])
        op_2 = cmd[15:] if immediate else register.get(cmd[15:10])
        datastore = None

    # one op cmd
    else:
        target = cmd[15:] if immediate else register.get(cmd[15:10])
        op_1 = None
        op_2 = None
        datastore = None

    flags = register.get(reg_flags)

    op_sel = alu_decode(op_code)

    return op_code, op_sel, target, datastore, op_1, op_2, flags, next_seq_pc

# TODO: set carry/overflow bits accordingly
def execute(op_code, op_sel, target, datastore, op_1, op_2, flags, next_seq_pc):

    if op_sel == '00000':
        return

    elif op_sel == '00001':
        result = op_1 + op_2

    elif op_sel == '00010':
        result = op_1 + op_2 + flags['Carry']

    elif op_sel == '00011':
        result = op_1 - op_2 - 1 + flags['Carry']

    elif op_sel == '00100':
        result = shift_left(op_1, op_2)

    elif op_sel == '00101':
        result = shift_right_arith(op_1, op_2)

    elif op_sel == '00110':
        result = shift_right_logic(op_1, op_2)

    elif op_sel == '00111':
        result = op_1 & op_2

    elif op_sel == '01000':
        result = op_1 | op_2

    elif op_sel == '01001':
        result = op_1 ^ op_2

    elif op_sel == '01010':
        flags = set_flag(flags, "CMP", bool(op_1 - op_2 == 0))

    elif op_sel == '01011':
        flags = set_flag(flags, "CMP", bool(op_1 - op_2 > 0))

    elif op_sel == '01100':
        result = op_2

    return op_code, target, datastore, op_1, op_2, result, flags, next_seq_pc

def mem_access(op_code, target, datastore, op_1, op_2, result, flags, next_seq_pc):

    register['PC'] = next_seq_pc

    if op_code == "NOP":
        return

    elif op_code == "JMP":
        register['PC'] = result

    elif op_code == "B":
        if get_flag(flags, "CMP"):
            register['PC'] = result

    elif op_code == "LDR":
        result = memory_data.get(result)

    elif op_code == "STR":
        memory_data[result] = datastore

    return op_code, target, result, flags, next_seq_pc

def write_back(op_code, target, result, flags, next_seq_pc):

    if op_code == "NOP":
        return

    register_address = target

    if op_code in [
            "ADC", "ADD", "SBC", "SUB",
            "SL", "SRA", "SRL", "AND",
            "OR", "XOR", "LDR", "MOV"]:
        register[target] = result

    elif op_code in ["CMPEQ", "CMPGT"]:
        register[reg_flags] = result

    elif op_code in ["JMP", "B"]:
        register[reg_link] = next_seq_pc

    return register_address, value
