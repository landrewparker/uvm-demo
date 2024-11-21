.PHONY: vcs clean

CONFIG_DB_TRACE=
#CONFIG_DB_TRACE=+UVM_CONFIG_BD_TRACE

TEST=random_test

vcs:
	vcs -full64 -q -sverilog -debug_access+all +warn=all -timescale=1ns/1ns -CFLAGS -DVCS -f src.f -R $(CONFIG_DB_TRACE) +UVM_TESTNAME=$(TEST)

clean:
	-rm -r csrc simv simv.daidir ucli.key vc_hdrs.h
