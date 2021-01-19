from operator import attrgetter

import cocotb
from cocotb.triggers import Timer

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
    "alu_op_sel",
    "op_1",
    "op_2",
]

alu_out_ports = [
    "result",
    "carry",
    "overflow",
    "compare",
]

def in_wait_out_assert(dut, in_ports, out_ports, wait):

    for p in alu_in_ports:
        if p in in_ports
            getattr(dut, p) <= in_ports[p]

    await Timer(wait, units='ns')

    for p in alu_out_ports:
        sig_is = getattr(dut, p)
        sig_should = out_ports[p]
        assert (
            sig_is == sig_should,
            f"Signal mismatch: {p} should be {sig_should} but is {sig_is}"
        )


@cocotb.test()
async def test_NOOP(dut)
    alu_op_sel = "00000"

    in_wait_out_assert(
        dut,
        in_ports={
            "alu_op_sel": alu_op_sel,
            "op_1": "0"
            "op_2": "1"
        },
        out_ports={
            "result": "0"
            "carry": "0"
            "overflow": "0"
            "compare": "0"
        },
        wait=10,
    )



# @cocotb.test()
# async def test_ADD(dut)
#     alu_op_sel = "00001"


# @cocotb.test()
# async def test_ADC(dut)
#     alu_op_sel = "00010"


# @cocotb.test()
# async def test_SBC(dut)
#     alu_op_sel = "00011"


# @cocotb.test()
# async def test_SL(dut)
#     alu_op_sel = "00100"


# @cocotb.test()
# async def test_SRA(dut)
#     alu_op_sel = "00101"


# @cocotb.test()
# async def test_SRL(dut)
#     alu_op_sel = "00110"


# @cocotb.test()
# async def test_AND(dut)
#     alu_op_sel = "00111"


# @cocotb.test()
# async def test_ORR(dut)
#     alu_op_sel = "01000"


# @cocotb.test()
# async def test_XOR(dut)
#     alu_op_sel = "01001"


# @cocotb.test()
# async def test_CMPEQ(dut)
#     alu_op_sel = "01010"


# @cocotb.test()
# async def test_CMPGT(dut)
#     alu_op_sel = "01011"


# @cocotb.test()
# async def test_IDOP2(dut)
#     alu_op_sel = "01100"

