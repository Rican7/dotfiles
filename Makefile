# Set the dependencies path
DEPENDENCIES_PATH=.git/modules


all: install-deps install

$(DEPENDENCIES_PATH) install-deps:
# Attempt to fetch all submodules, but try again if the private module fails.
	git submodule sync --recursive
	git submodule update --init --recursive --checkout || \
		{ git submodule deinit --force --all && git submodule update --init --recursive --checkout ":(exclude)dev-notes"; }

clean-deps:
	git submodule deinit .
	rm -rf $(DEPENDENCIES_PATH)

clean-deps-force:
	git submodule deinit --force --all
	rm -rf $(DEPENDENCIES_PATH)

update-deps: clean-deps install-deps

install:
	@./INSTALL

install-verbose:
	@./INSTALL -v


.PHONY: all install-deps clean-deps clean-deps-force update-deps install install-verbose
