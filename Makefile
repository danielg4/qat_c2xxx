MAKEFLAGS += -l 0.0	#kernel space build and user space build race condition
export ICP_ROOT ?= $(CURDIR)
JOBS := $(shell nproc 2>/dev/null || echo 1)


all:
	$(MAKE) -C quickassist all -j$(JOBS)

kmod:
	$(MAKE) -C quickassist lac -j$(JOBS)

clean:
	$(MAKE) -C quickassist clean

install_utils: all
	$(MAKE) -C quickassist install_utils

install_kmod:
	@dkms add $(ICP_ROOT)
	@dkms autoinstall

install: clean install_kmod install_utils
	@echo 'Installation complete.'


