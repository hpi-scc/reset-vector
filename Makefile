#
# NOTE: only compilable with x86 cross compile tools
#

DEFINES=

TARGETS=reset_vector.bin

all: $(TARGETS)

reset_vector.bin: reset_vector.o
	ld --oformat binary -Ttext 0 -melf_i386 -o $@ $<
	chmod a-x $@

%.o: %.S
	$(CROSS_COMPILE)gcc $(DEFINES) -m32 -c -o $@ $<

clean:
	rm -f $(TARGETS) *.o *~

