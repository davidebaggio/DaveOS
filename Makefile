ASM=nasm
SRC_DIR=src
BIN_DIR=bin
FORMAT=raw
FILE=${BIN_DIR}/boot.bin

.PHONY: all floppy_image kernel bootloader boot clean always

boot: floppy_image
	qemu-system-x86_64 -drive format=${FORMAT},file=${FILE}

# Floppy image
floppy_image: ${BIN_DIR}/boot_floppy.img
${BIN_DIR}/boot_floppy.img: bootloader kernel
	dd if=/dev/zero of=${BIN_DIR}/boot_floppy.img bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" ${BIN_DIR}/boot_floppy.img
	dd if=${BIN_DIR}/boot.bin of=${BIN_DIR}/boot_floppy.img conv=notrunc
	mcopy -i ${BIN_DIR}/boot_floppy.img ${BIN_DIR}/kernel.bin "::kernel.bin"

# Bootloader
bootloader: ${BIN_DIR}/boot.bin
${BIN_DIR}/boot.bin: always
	${ASM} ${SRC_DIR}/bootloader/boot.asm -f bin -o ${BIN_DIR}/boot.bin

# Kernel
kernel: ${BIN_DIR}/kernel.bin
${BIN_DIR}/kernel.bin: always
	${ASM} ${SRC_DIR}/kernel/kernel.asm -f bin -o ${BIN_DIR}/kernel.bin

# Always
always:
	mkdir -p ${BIN_DIR}

# Clean
clean:
	rm -rf ${BIN_DIR}
