TOPLEVEL_LANG ?= vhdl
SIM ?= ghdl

PWD=$(shell pwd)

VHDL_SOURCES = $(PWD)/*.vhdl

TOPLEVEL := instruction_memory
MODULE   := test_instruction_memory

include $(shell cocotb-config --makefiles)/Makefile.sim
