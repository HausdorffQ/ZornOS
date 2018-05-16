GCCPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
NASMPARAMS = -f elf
ASPARAMS = --32
LDPARAMS = -melf_i386

objects = boot.o gdt.o port.o kernel.o



%.o: %.cpp
	g++ $(GCCPARAMS) -c -o $@ $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<
%.o: %.asm
	nasm $(NASMPARAMS) -o $@ $<

kernel: link.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

binfile:kernel
	objdump -d  kernel | head -n30


ZornOS:ZornOS.img
	sudo mkdir /mnt/ZornOS
	sudo mount ZornOS.img /mnt/ZornOS
	sudo cp kernel /mnt/ZornOS/kernel
	sudo umount /mnt/ZornOS
	sudo rm -rf /mnt/ZornOS

run:ZornOS.img
	@echo 'running...'
	qemu-system-i386 -boot order=a -fda ZornOS.img

.PHONY:cleam
clean:
	rm -f $(objects) kernel 