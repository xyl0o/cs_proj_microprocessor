register = {}  # add zero register
memory_inst = {}
memory_data = {}

three_op = [
    "ADC", "ADD", "SBC", "SUB", "SL",
    "SRA", "SRL", "AND", "OR", "XOR",
    "LDR", "STR"].map(op_encode)
two_op = [
    "CMPEQ", "CMPGT", "MOV"].map(op_encode)
one_op = [
    "B", "MRS", "MSR"].map(op_encode)


# Flags register:
# 00000000000000000000000000000000
#                                ^compare
#                               ^carry
#                              ^overflow
def set_flag(flag_reg, flag):
    if flag == 'CMP':
        return flag_reg | 1 << 0
    elif flag == 'CARRY':
        return flag_reg | 1 << 1
    elif flag == 'OF':
        return flag_reg | 1 << 2

def unset_flag(flag_reg, flag):
    if flag == 'CMP':
        return flag_reg & bitwise_not(1 << 0)
    elif flag == 'CARRY':
        return flag_reg & bitwise_not(1 << 1)
    elif flag == 'OF':
        return flag_reg & bitwise_not(1 << 2)

def get_flag(flag_reg, flag):
    if flag == 'CMP':
        return flag_reg>>0 & 1
    elif flag == 'CARRY':
        return flag_reg>>1 & 1
    elif flag == 'OF':
        return flag_reg>>2 & 1

def inst_fetch():
    cmd = memory_inst.get(
        register.get('PC'))

    if not cmd:
        raise()

    return cmd

def inst_decode(cmd):

    op_code = cmd[31:26]

    immediate = bool(cmd[26] == 1)

    if op_code[31:26] == NOP:
        return #nop

    elif op_code[31:26] == STR:  # do we have to do this?
        target = register.get(cmd[25:20])
        op_1 = register.get(cmd[20:15])
        op_2 = cmd[15:] if immediate else register.get(cmd[15:10])

    elif op_code[31] == 1:
        target = cmd[25:20]
        op_1 = register.get(cmd[20:15])
        op_2 = cmd[15:] if immediate else register.get(cmd[15:10])

    elif op_code[30] == 1:
        target = cmd[20:15]
        op_1 = register.get(cmd[20:15])
        op_2 = cmd[15:] if immediate else register.get(cmd[15:10])
    else:
        target = cmd[15:] if immediate else register.get(cmd[15:10])
        op_1 = None
        op_2 = None

    return op_code, target, op_1, op_2, flags

# TODO: set carry/overflow bits accordingly
def execute(op_code, target, op_1, op_2, flags):
    if op_code == "ADC":
        result = op_1 + op_2 + flags['Carry']

    elif op_code == "ADD":
        result = op_1 + op_2

    elif op_code == "SBC":
        result = op_1 - op_2 - 1 + flags['Carry']

    elif op_code == "SUB":
        result = op_1 - op_2

    elif op_code == "SL":
        result = shift_left(op_1, op_2)

    elif op_code == "SRA":
        result = shift_right_arith(op_1, op_2)

    elif op_code == "SRL":
        result = shift_right_logic(op_1, op_2)

    elif op_code == "AND":
        result = op_1 & op_2

    elif op_code == "OR":
        result = op_1 | op_2

    elif op_code == "XOR":
        result = op_1 ^ op_2

    elif op_code == "LDR":
        result = op_1 + op_2

    elif op_code == "STR":
        result = op_1 + op_2

    elif op_code == "CMPEQ":
        if op_1 - op_2 == 0:
            flags = set_flag(flags, "CMP")
        else:
            flags = unset_flag(flags, "CMP")

    elif op_code == "CMPGT":
        if  op_1 - op_2 > 0:  ## todo
            flags = set_flag(flags, "CMP")
        else:
            flags = unset_flag(flags, "CMP")

    elif op_code == "MOV":
        result = op_2

    return op_code, target, result, flags

def mem_access(op_code, target, result, flags):

    if op_code == "LDR":
        result = memory_data.get(op_2)

    elif op_code == "STR":
        memory_data[result] = target

    return op_code, target, result, flags

def write_back(op_code, target, result, flags):

    register_address = target

    if op_code in [
            "ADC", "ADD", "SBC", "SUB",
            "SL", "SRA", "SRL", "AND",
            "OR", "XOR", "LDR",
            "MOV", "MRS"]:

    elif op_code in ["CMPEQ", "CMPGT"]:
        result

    elif op_code == "MSR":
        flags = result
    #"B", "NOP"

    return register_address, value
