.PHONY: vcs clean

vcs:
	vcs -full64 -q -sverilog -debug_access+all +warn=all -f src.f -R

clean:
	-rm -r csrc simv simv.daidir ucli.key
