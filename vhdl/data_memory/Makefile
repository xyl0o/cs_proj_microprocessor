TOPLEVEL_LANG ?= vhdl
SIM ?= ghdl

PWD=$(shell pwd)

VHDL_SOURCES = $(PWD)/*.vhdl

TOPLEVEL := data_memory
MODULE   := test_data_memory

include $(shell cocotb-config --makefiles)/Makefile.sim
