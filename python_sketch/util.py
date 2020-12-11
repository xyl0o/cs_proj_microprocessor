#!/usr/bin/env python3

# Flags register:
# 00000000000000000000000000000000
#                                ^compare
#                               ^carry
#                              ^overflow
def set_flag(flag_reg: bytes, flag:str, value: bool) -> bytes:
    shift_amount = reversed(['OF', 'CARRY','CMP']).index(flag)

    if value:
        return flag_reg | 1 << shift_amount
    else:
        return flag_reg & bitwise_not(1 << 0)

def get_flag(flag_reg: bytes, flag:str) -> bool:
    shift_amount = reversed(['OF', 'CARRY','CMP']).index(flag)
    return bool(flag_reg>>shift_amount & 1)

# https://stackoverflow.com/questions/1604464/twos-complement-in-python
def twos_comp(val, bits):
    """compute the 2's complement of int value val"""
    if (val & (1 << (bits - 1))) != 0:
        val = val - (1 << bits)
    return val
