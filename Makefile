EXENAME          = sim

OSD_DOS          = osd_dos.c

OSDFILES         = osd_linux.c # $(OSD_DOS)
MAINFILES        = sim.c cpu_read.c cpu_write.c nmi.c input_device.c output_device.c timer.c irqs.c
MUSASHIFILES     = m68kcpu.c m68kdasm.c softfloat/softfloat.c
MUSASHIGENCFILES = m68kops.c
MUSASHIGENHFILES = m68kops.h
MUSASHIGENERATOR = m68kmake

# EXE = .exe
# EXEPATH = .\\
EXE =
EXEPATH = ./

.CFILES   = $(MAINFILES) $(OSDFILES) $(MUSASHIFILES) $(MUSASHIGENCFILES)
.OFILES   = $(.CFILES:%.c=%.o)

CC        = gcc
WARNINGS  = -Wall -Wextra -pedantic
CFLAGS    = $(WARNINGS)
LFLAGS    = $(WARNINGS)

TARGET = $(EXENAME)$(EXE)

DELETEFILES = $(MUSASHIGENCFILES) $(MUSASHIGENHFILES) $(.OFILES) $(TARGET) $(MUSASHIGENERATOR)$(EXE)


all: $(TARGET)

clean:
	rm -f $(DELETEFILES)

$(TARGET): $(MUSASHIGENHFILES) $(.OFILES) Makefile
	$(CC) -o $@ $(.OFILES) $(LFLAGS) -lm

$(MUSASHIGENCFILES) $(MUSASHIGENHFILES): $(MUSASHIGENERATOR)$(EXE)
	$(EXEPATH)$(MUSASHIGENERATOR)$(EXE)

$(MUSASHIGENERATOR)$(EXE):  $(MUSASHIGENERATOR).c
	$(CC) -o  $(MUSASHIGENERATOR)$(EXE)  $(MUSASHIGENERATOR).c

run:
	./sim rom-images/monitor-plus-linux-pcb.bin
	# press j and press 003000
#wmt@wmt-VirtualBox:~/work_m68k/68katy-musashi$ ls rom-images/
#monitor.asm  monitor.bin  monitor-plus-linux-pcb.bin  musashi_example.bin

