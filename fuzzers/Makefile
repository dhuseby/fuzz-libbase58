SHORTHOST = $(shell hostname | sed 's/\..*//' | tr -cd '[a-z][A-Z][0-9]')
ROOTDIR = $(shell cd ..; pwd)
NACLROOT = $(shell find $(ROOTDIR)/NaCl -type d -name nacl\*)
NACLABI = $(shell $(NACLROOT)/build/$(SHORTHOST)/bin/okabi)
NACLINCLUDE = $(NACLROOT)/build/$(SHORTHOST)/include/$(NACLABI)/
NACLLIB = $(NACLROOT)/build/$(SHORTHOST)/lib/$(NACLABI)/
BASE58INCLUDE = $(ROOTDIR)/libbase58/
BASE58 = $(ROOTDIR)/libbase58/base58.o
AFLCC = $(ROOTDIR)/afl/afl-gcc

SRC = fuzz-b58enc.c
OBJ = $(SRC:.c=.o)
FUZZERS = fuzz-b58enc

all: $(FUZZERS)

.c.o:
	$(AFLCC) -c $< -o $@ -I $(BASE58INCLUDE)

fuzz-b58enc: fuzz-b58enc.o
	$(AFLCC) -o $@ $^ $(BASE58)

clean:
	rm -rf fuzz-b58enc fuzz-b58enc.o

.PHONY: all clean
