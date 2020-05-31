# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html
# https://ftp.gnu.org/old-gnu/Manuals/make-3.80/html_node/make_17.html
PROJECT_MKFILE_PATH := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
PROJECT_MKFILE_DIR  := $(shell cd $(shell dirname $(PROJECT_MKFILE_PATH)); pwd)
PROJECT_SRC         := $(PROJECT_MKFILE_DIR)/src
PROJECT_BUILD       := $(PROJECT_MKFILE_DIR)/build
PROJECT_DIST        := $(PROJECT_MKFILE_DIR)/dist

all:
	# http://ats-lang.github.io/DOCUMENT/ATS2FUNCRASH/HTML/x75.html
	install -d -m 0755 $(PROJECT_BUILD) $(PROJECT_DIST)
	myatscc $(PROJECT_SRC)/hello.dats
	mv -v $(PROJECT_SRC)/*.exe $(PROJECT_BUILD)/

run:
	$(PROJECT_BUILD)/hello.exe
