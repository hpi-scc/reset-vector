/*
 * QEMU Boot sector to launch a preloaded Linux kernel
 * Copyright (c) 2004 Fabrice Bellard
 */

#define LOAD_SEG 0x07C0

.code16	
.text
	.globl	_start

.org 0x0000
_realstart:
	cli
	cld
	mov $LOAD_SEG, %ax
	mov %ax, %ds
	mov %ax, %es
	mov %ax, %fs
	mov %ax, %gs
	mov %ax, %ss
	mov $0x8ffe, %sp

	/*
	 * Set hardware_subarch to X86_SUBARCH_SCC (=5) to enable SCC-specific
	 * initialization path. Make sure this statement is updated once a new
	 * subarchitecture is introduced in the mainline kernel!
	 */
	movl $5, 0x23C

	/*
	 * Do a FAR jump into the loader. The offset of 512 bytes (one sector)
	 * is needed to reach the "real" loader code, instead of the dummy one
	 * that would be used when booting directly from floppy.
	 */
	ljmp $LOAD_SEG + 0x20, $0

.org 0x0ff0
_start:
	jmp	_realstart
_end:
	.align 4096
