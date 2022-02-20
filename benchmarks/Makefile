FLGS := --release --no-debug
SRCS := $(wildcard *.cr)
BINS := $(SRCS:%.cr=%)

.PHONY = all clean

all: $(BINS)

% : %.cr
	crystal build $(FLGS) $< -o $@.bin

clean:
	rm -rvf $(BINS)
