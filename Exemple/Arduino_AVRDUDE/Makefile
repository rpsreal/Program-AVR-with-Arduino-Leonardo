# Name: Makefile ASSEMBLER
# Author: Rui Silva 
# Based on the work of https://gist.github.com/holachek/3304890

# DEVICE ....... The AVR device you compile for
# CLOCK ........ Target AVR clock rate in Hertz
# OBJECTS ...... The object files created from your source files. This list is
#                usually the same as the list of source files with suffix ".o".
# PROGRAMMER ... Options to avrdude which define the hardware you use for
#                uploading to the AVR and the interface where this hardware
#                is connected.
# FUSES ........ Parameters for avrdude to flash the fuses appropriately. http://www.engbedded.com/fusecalc/

# Configuracion for Atmega328P with 1Mhz clock (8Mhz in fuses)
DEVICE     = atmega328p
CLOCK      = 8000000
PORT       = $(shell pavr2cmd --prog-port)
PROGRAMMER = -c stk500v2 -P
OBJECTS    = main.o
FUSES      = lfuse:w:0xe2:m -U hfuse:w:0xd9:m -U efuse:w:0xff:m
FILE_HEX = ./LED.ino.with_bootloader.hex


## ARDUINO PROGRAMMER: -c arduino -P /dev/ttyACM0 -b 19200
## WITHOUT SAFE MODE: -F -u
######################################################################
######################################################################

# Tune the lines below only if you know what you are doing:
# avrdude -c stk500v2 -P "$(PORT)" -p $(MCU) -U flash:w:$<:i
AVRDUDE = avrdude $(PROGRAMMER) $(PORT) -p $(DEVICE)
COMPILE = avr-gcc -Wall -Os -DF_CPU=$(CLOCK) -mmcu=$(DEVICE)
AVRDUDE_ERASE = avrdude $(PROGRAMMER) $(PORT) -p $(DEVICE) -e

# symbolic targets:
all:	main.hex

.c.o:
	$(COMPILE) -c $< -o $@

.S.o:
	$(COMPILE) -x assembler-with-cpp -c $< -o $@
# "-x assembler-with-cpp" should not be necessary since this is the default
# file type for the .S (with capital S) extension. However, upper case
# characters are not always preserved on Windows. To ensure WinAVR
# compatibility define the file type manually.

.c.s:
	$(COMPILE) -S $< -o $@

fuse:
	$(AVRDUDE) -U $(FUSES)

flash:	all
	$(AVRDUDE) -U flash:w:main.hex:i

flash_hex:
	$(AVRDUDE) -U flash:w:$(FILE_HEX):i

erase:
	$(AVRDUDE_ERASE)


asm:	
	$(COMPILE) -nostartfiles ./main.S
	avr-objcopy -O ihex a.out main.hex
	$(AVRDUDE) -U flash:w:main.hex:i

install: flash fuse

# if you use a bootloader, change the command below appropriately:
load: all
	bootloadHID main.hex

clean:
	rm -f main.hex main.elf $(OBJECTS)

# file targets:
main.elf: $(OBJECTS)
	$(COMPILE) -o main.elf $(OBJECTS)

main.hex: main.elf
	rm -f main.hex
	avr-objcopy -j .text -j .data -O ihex main.elf main.hex
# If you have an EEPROM section, you must also create a hex file for the
# EEPROM and add it to the "flash" target.

# Targets for code debugging and analysis:
disasm:	main.elf
	avr-objdump -d main.elf

cpp:
	$(COMPILE) -E main.c
