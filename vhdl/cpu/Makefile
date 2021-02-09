TOPLEVEL_LANG ?= vhdl
SIM ?= ghdl

PWD=$(shell pwd)

VHDL_SOURCES = $(PWD)/*.vhdl
VHDL_SOURCES += $(PWD)/../alu/*.vhdl
VHDL_SOURCES += $(PWD)/../decoder/*.vhdl

TOPLEVEL := cpu
MODULE   := test_cpu

include $(shell cocotb-config --makefiles)/Makefile.sim
