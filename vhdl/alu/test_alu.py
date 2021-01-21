
from functools import partial

import cocotb
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue as bval
from cocotb.binary import BinaryRepresentation as brep

bval32 = partial(bval, n_bits=32, bigEndian=False, binaryRepresentation=brep.TWOS_COMPLEMENT)

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


async def in_wait_out_assert(dut, in_ports, out_ports, wait):
    """This function accepts a design under test (dut),
    in and out port dictionaries and a wait time in ns.

    All inputs are assigned to the dut and all outputs are asserted.

    It uses the cocotb.binary.BinaryValue class
    to handle signed/unsigned values.

    All values will be compared as signed integers."""

    for p in alu_in_ports:
        if p not in in_ports:
            continue

        val = in_ports[p]
        if not isinstance(val, bval):
            val = bval(val)

        getattr(dut, p) <= in_ports[p].integer

    await Timer(wait, units='ns')

    for p in alu_out_ports:
        if p not in out_ports:
            continue

        exp = out_ports[p]
        if not isinstance(exp, bval):
            exp = bval(exp)

        exp = exp.signed_integer
        got = getattr(dut, p).value.signed_integer

        assert got == exp, f"Signal mismatch: {p} should be {exp} but is {got}"


# @cocotb.test()
# async def test_NOOP(dut):
#     alu_op_code = bval("00000")


# @cocotb.test()
# async def test_ADD(dut):
#     alu_op_code = 0b00001


# @cocotb.test()
# async def test_ADC(dut):
#     alu_op_code = bval("00010")


# @cocotb.test()
# async def test_SBC(dut):
#     alu_op_code = bval("00011")


# @cocotb.test()
# async def test_SL(dut):
#     alu_op_code = bval("00100")


# @cocotb.test()
# async def test_SRA(dut):
#     alu_op_code = bval("00101")


# @cocotb.test()
# async def test_SRL(dut):
#     alu_op_code = bval("00110")


# @cocotb.test()
# async def test_AND(dut):
#     alu_op_code = bval("00111")


# @cocotb.test()
# async def test_ORR(dut):
#     alu_op_code = bval("01000")


# @cocotb.test()
# async def test_XOR(dut):
#     alu_op_code = bval("01001")


# @cocotb.test()
# async def test_CMPEQ(dut):
#     alu_op_code = bval("01010")


# @cocotb.test()
# async def test_CMPGT(dut):
#     alu_op_code = bval("01011")


# @cocotb.test()
# async def test_IDOP2(dut):
#     alu_op_code = bval("01100")

