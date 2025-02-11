# Makefile derived from https://web.archive.org/web/20240205205603/https://venthur.de/2021-03-31-python-makefiles.html

# Get the directory this Makefile is sitting in
ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

CHECK_SCRIPTS := $(ROOT_DIR)/src/bin/misbehaving-usb-suspend-fixer

# system python interpreter. used only to create virtual environment
PY = python3
VENV = venv
BIN=$(ROOT_DIR)/$(VENV)/bin

all: bashate shellcheck yamllint

$(VENV): requirements.txt
	$(PY) -m venv $(VENV)
	$(BIN)/pip install --upgrade -r requirements.txt
	touch $(VENV)

.PHONY: bashate
bashate: $(VENV)
	$(BIN)/bashate -i E006 $(CHECK_SCRIPTS)

.PHONY: shellcheck
shellcheck: $(VENV)
	$(BIN)/shellcheck $(CHECK_SCRIPTS)

.PHONY: yamllint
yamllint: $(VENV)
	$(BIN)/yamllint .

clean:
	rm -rf $(VENV)
	find . -type f -name *.pyc -delete
	find . -type d -name __pycache__ -delete
