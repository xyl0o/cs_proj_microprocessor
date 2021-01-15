
import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def adder_basic_test(dut):
    patterns = [
        (0, 0, 0, 0, 0),
        (0, 0, 1, 1, 0),
        (0, 1, 0, 1, 0),
        (0, 1, 1, 0, 1),
        (1, 0, 0, 1, 0),
        (1, 0, 1, 0, 1),
        (1, 1, 0, 0, 1),
        (1, 1, 1, 1, 1),
    ]
    for i0, i1, ci, s, co in patterns:

        dut.i0 <= i0
        dut.i1 <= i1
        dut.ci <= ci

        await Timer(2, units='ns')

        assert dut.s.value == s, f"{dut.s.value} is not {s}"
        assert dut.co.value == co, f"{dut.co.value} is not {co}"
