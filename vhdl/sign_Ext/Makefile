TOPLEVEL_LANG ?= vhdl
SIM ?= ghdl

PWD=$(shell pwd)

VHDL_SOURCES = $(PWD)/*.vhdl

TOPLEVEL := sign_ext
MODULE   := test_sign_ext

include $(shell cocotb-config --makefiles)/Makefile.sim
