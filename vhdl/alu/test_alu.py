from operator import attrgetter

import cocotb
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue, BinaryRepresentation

output_wait = 10  # ns

aluop_NOOP = "00000"
aluop_ADD = "00001"
aluop_ADC = "00010"
aluop_SBC = "00011"
aluop_SL = "00100"
aluop_SRA = "00101"
aluop_SRL = "00110"
aluop_AND = "00111"
aluop_ORR = "01000"
aluop_XOR = "01001"
aluop_CMPEQ = "01010"
aluop_CMPGT = "01011"
aluop_IDOP2 = "01100"

alu_in_ports = [
    "alu_op_code",
    "op_1",
    "op_2",
    "carryin",
]

alu_out_ports = [
    "result",
    "carryout",
    "overflow",
    "compare",
]


def encode_integer(value, unsigned=False, bits=32):
    if unsigned:
        bin_rep = BinaryRepresentation.UNSIGNED
    else:
        bin_rep = BinaryRepresentation.TWOS_COMPLEMENT

    v = BinaryValue(
        n_bits=bits,
        bigEndian=False,
        binaryRepresentation=bin_rep
    )

    v.integer = value
    return v


def decode_integer(value, unsigned=False, bits=32):
    if unsigned:
        bin_rep = BinaryRepresentation.UNSIGNED
    else:
        bin_rep = BinaryRepresentation.TWOS_COMPLEMENT

    v = BinaryValue(
        n_bits=bits,
        bigEndian=False,
        binaryRepresentation=bin_rep
    )

    v.binstr = value.binstr
    return v.integer


async def in_wait_out_assert(dut, in_ports, out_ports, wait):

    for p in alu_in_ports:
        if p not in in_ports:
            continue

        getattr(dut, p) <= in_ports[p]

    await Timer(wait, units='ns')

    for p in alu_out_ports:
        if p not in out_ports:
            continue

        got = int(getattr(dut, p).value)
        exp = out_ports[p]
        comp = got == exp

        assert comp, f"Signal mismatch: {p} should be {exp} but is {got}"


# @cocotb.test()
# async def test_NOOP(dut):
#     alu_op_code = 0b00000


# @cocotb.test()
# async def test_ADD(dut):
#     alu_op_code = 0b00001


# @cocotb.test()
# async def test_ADC(dut):
#     alu_op_code = 0b00010


# @cocotb.test()
# async def test_SBC(dut):
#     alu_op_code = 0b00011


# @cocotb.test()
# async def test_SL(dut):
#     alu_op_code = 0b00100


# @cocotb.test()
# async def test_SRA(dut):
#     alu_op_code = 0b00101


# @cocotb.test()
# async def test_SRL(dut):
#     alu_op_code = 0b00110


# @cocotb.test()
# async def test_AND(dut):
#     alu_op_code = 0b00111


# @cocotb.test()
# async def test_ORR(dut):
#     alu_op_code = 0b01000


# @cocotb.test()
# async def test_XOR(dut):
#     alu_op_code = 0b01001


# @cocotb.test()
# async def test_CMPEQ(dut):
#     alu_op_code = 0b01010


# @cocotb.test()
# async def test_CMPGT(dut):
#     alu_op_code = 0b01011


# @cocotb.test()
# async def test_IDOP2(dut):
#     alu_op_code = 0b01100

