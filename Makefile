.PHONY: vcs clean

vcs:
	vcs -full64 -q -sverilog -debug_access+all +warn=all -CFLAGS -DVCS -f src.f -R

clean:
	-rm -r csrc simv simv.daidir ucli.key vc_hdrs.h
