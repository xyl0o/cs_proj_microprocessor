TOPLEVEL_LANG ?= vhdl
SIM ?= ghdl

PWD=$(shell pwd)

VHDL_SOURCES = $(PWD)/*.vhdl

TOPLEVEL := alu
MODULE   := test_alu

include $(shell cocotb-config --makefiles)/Makefile.sim
