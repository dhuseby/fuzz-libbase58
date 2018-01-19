AFLDIR = afl
NACLDIR = NaCl
BASE58DIR = libbase58
DIRS = $(AFLDIR) $(NACLDIR) $(BASE58DIR) fuzzers
CLEANDIRS = $(DIRS:%=clean-%)

all: $(DIRS)

$(AFLDIR):
	$(MAKE) -C $@

$(BASE58DIR): $(AFLDIR)
	cd $(BASE58DIR); ./autogen.sh; CC=$(shell pwd)/$(AFLDIR)/afl-gcc CXX=$(shell pwd)/$(AFLDIR)/afl-g++ ./configure --disable-shared
	$(MAKE) -C $@

$(NACLDIR):
	$(MAKE) -C $@

fuzzers: $(NACLDIR)
	$(MAKE) -C $@

clean: $(CLEANDIRS)

$(CLEANDIRS):
	$(MAKE) -C $(@:clean-%=%) clean

.PHONY: subdirs $(DIRS)
.PHONY: subdirs $(CLEANDIRS)
.PHONY: all clean
