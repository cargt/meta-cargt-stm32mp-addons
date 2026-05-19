# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)

dtb-$(CONFIG_STM32MP25X) += \
	stm32mp257f-cargt-00395-00365v3.dtb \
	stm32mp257f-cargt-00395-00365v3-glt028240320is1.dtb \
	stm32mp257f-cargt-00395-00365v3-glt0557201280is1.dtb \
	stm32mp257f-cargt-00395-00365v3-glt0701024600is2.dtb \
	stm32mp257f-cargt-00395-00365v3-glt1011280800is1.dtb \

#include $(srctree)/scripts/Makefile.dts

targets += $(dtb-y)

# Add any required device tree compiler flags here
DTC_FLAGS += -a 0x8

PHONY += dtbs
dtbs: $(addprefix $(obj)/, $(dtb-y))
	@:

clean-files := *.dtb *.dtbo *_HS
