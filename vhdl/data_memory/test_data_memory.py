
from functools import partial

import cocotb
from cocotb.triggers import Timer
from cocotb.binary import BinaryValue as bval
from cocotb.binary import BinaryRepresentation as brep

bval32 = partial(bval, n_bits=32, bigEndian=False, binaryRepresentation=brep.TWOS_COMPLEMENT)

output_wait = 10  # ns


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


@cocotb.test()
async def test_CHANGEME(dut):
    pass
