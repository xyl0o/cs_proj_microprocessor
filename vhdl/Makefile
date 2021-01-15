GHDL=ghdl
GHDLFLAGS=

TESTS=\
	adder_tb

# Express dependencies here
adder_tb: adder

# Binary depends on the object file
%: %.o
	$(GHDL) -e $(GHDLFLAGS) $@

# Object file depends on source
%.o: %.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

.PHONY: clean test

test: $(TESTS)
	for t in $^; do ./$$t --wave=$$t.ghw ; done

clean:
	echo "Cleaning up..."
	rm -f *.o *_tb work*.cf e*.lst $(BINARIES)

cleanall:
	echo "Cleaning up everything..."
	find ./* -type f -not -name '*.vhdl' -not -name 'Makefile' -delete