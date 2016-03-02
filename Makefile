# Set the dependencies path
DEPENDENCIES_PATH=.git/modules


all: install-deps install

$(DEPENDENCIES_PATH):
	git submodule sync --recursive
	git submodule update --init --recursive --checkout

install-deps: $(DEPENDENCIES_PATH)

clean-deps:
	git submodule deinit .
	rm -rf $(DEPENDENCIES_PATH)

update-deps: clean-deps install-deps

install:
	@./INSTALL

install-verbose:
	@./INSTALL -v


.PHONY: all install-deps clean-deps update-deps install install-verbose
