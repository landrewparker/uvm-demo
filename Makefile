.PHONY: vcs clean

vcs:
	vcs -full64 -q -sverilog -debug_access+all +warn=all -timescale=1ns/1ns -CFLAGS -DVCS -f src.f -R +UVM_TESTNAME=random_test

clean:
	-rm -r csrc simv simv.daidir ucli.key vc_hdrs.h
