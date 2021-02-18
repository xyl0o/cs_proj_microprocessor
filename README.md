# Planning

## Ziel??
 * Datentypen:
   * Int
   * Char
   * Long (2^32)
   * fp32
   * (Strings)
 * Festkommarechnung
 * (Fließkommazahlen -> Software)
 * Fibonacci
 * Fakultät
 * Input lesen (button)
 * LED blinken lassen
 * (Serielle Konsole??)
   * LCD/TFT display

## IS

32bit vs 64bit
  -> 64bit bietet keinen grossen Nutzen gegenueber dem Aufwand

2-Adress Format vs 3-Adress Format
  -> 32bit bieten schon genug Platz fuer 3-adress format

(https://iitd-plos.github.io/col718/ref/arm-instructionset.pdf)

### Instructions we want to support

Three-op layout:
 * ADC (A := B + OP + Carry)
 * ADD (A := B + OP)
 * SBC (A := B - OP - 1 + Carry)
 * SUB (A := B - OP)
 * SL  (A := B << OP)
 * SRA (A := B >>> OP)
 * SRL (A := B >> OP)
 * AND (A := B AND OP)
 * OR  (A := B OR OP)
 * XOR (A := (B AND NOT OP) OR (OP AND NOT B))
 * LDR (A := address[B + OP])
 * STR (address[B + OP] := A)

Two-op layout:
 * CMPEQ (CMPR := A == OP)
 * CMPGT (CMPR := A - OP > 0)
 * MOV   (A := OP)
 * B     (PC := A + OP if compare)
 * JMP   (PC := A + OP)

One-op layout:

No-op layout:
 * NOP (Do nothing)
 * HLT (Do nothing forever)

## Flags
 * Carry
 * Compare
 * Overflow
 *

## Registers

Special purpose: R0,R1,R30,R31

We've decided that we need a jump op that set's R30 and R31 accordingly. (Because we introduced the Link Register.)

### R0 Always zero
 * Won't accept writes

### R1 Flags Register
 * Will be written to by ALU

### R30 Link Register
 * Won't accept writes
 * Will be set by jump
 * Is stored in Register File

### R31 Program Counter
 * Won't accept writes
 * Will be set by jump
 * Is not stored in Register File
 * Handed from MEM to IF

# VHDL

We are using [GHDL](https://github.com/ghdl/ghdl) for building and testing the vhdl source.

## Language in general
 * [VHDL Operators](https://technobyte.org/operators-vhdl/)
 * [VHDL: Convert `std_logic` to `std_logic_vector`](https://electronics.stackexchange.com/questions/463586/vhdl-convert-std-logic-to-std-logic-vector)

## Project setup

All stuff related VHDL resides in the `vhdl/` directory. In there every entity has its own directory (`alu/` for example). Every entity should be self contained and be testable independantly. Only the cpu entity shall cross reference other entities. Every entity shall contain a `Makefile` to build it and run tests against it.

## Build
 * [Managing VHDL Models with Makefiles](www.pldworld.com/_hdl/1/resources/QUALIS/library/mb004.pdf)
 * [GHDL - Design rebuilding commands](https://ghdl.readthedocs.io/en/latest/using/InvokingGHDL.html#design-rebuilding-commands)

We decided on GHDL for the time being. GHDL is easy to install and freely available. This might not be the tool for synthesis.

To install it this might help:

 * [Debian package](https://packages.debian.org/stable/electronics/ghdl-llvm)
 * `sudo pacman -S ghdl-llvm`
 * [Building GHDL from Sources](https://ghdl.readthedocs.io/en/latest/getting/index.html)

In principle these three commands are necessary to build and run a entity:
```bash
ghdl -a YOURFILE.vhdl # This analyses the file(s)
ghdl -e YOURENTITY # This creates a executable with that entity
ghdl -r YOURENTITY --wave=wave.ghw # This simulates the entity (and outputs a wave.ghw file)
```

See below for cocotb integration.

## Testing
Some testing/verification frameworks pop up repeatedly:

 * [UVVM](https://bitvis.no/dev-tools/uvvm/)
 * [cocotb](https://docs.cocotb.org/en/stable/)
 * [VUnit](http://vunit.github.io/)

Some more information:

 * https://www.linkedin.com/pulse/whos-using-uvm-fpga-development-why-lars-asplund
 * https://www.reddit.com/r/FPGA/comments/amntc7/cocotb_vunit_or_cocotb_vs_vunit/
 * https://vunit.github.io/blog/2015_10_08_who_is_using_UVM.html

We are using cocotb to run/test our design.

### cocotb

cocotb is a testing framework for VHDL/Verilog/etc. It uses python coroutines extensively.

[Quickstart](https://docs.cocotb.org/en/stable/quickstart.html)

### Setup

cocotb is responsible for building and running the whole test suite. To install it follow the [installation instructions](https://docs.cocotb.org/en/stable/install.html).

For Windows `conda` is recommended.

For Debian-based systems one might install Prerequisites like this:
```bash
sudo apt-get install make gcc g++ python3 python3-dev python3-pip
```

Now either install it directly:
```bash
pip install cocotb
```

Or use a virtualenv (you should do this!!!)
```bash
python3 -m venv venv
venv/bin/pip install cocotb
```

Archlinux:
```
yay -S python-cocotb
```

### How to run tests for an entity

If you are fine with the defaults just run `make` inside an enitity.

### How to run the whole processor

TBD
