################################################################################
#
# aiy_voicebonnet_sound
#
################################################################################

AIY_VOICEBONNET_SOUND_VERSION = db3ba7ba6333a7a03c27d2ec80cfddb97fd10d0a
AIY_VOICEBONNET_SOUND_SITE = $(call github,builderjer,aiy_voicebonnet_sound,$(AIY_VOICEBONNET_SOUND_VERSION))
AIY_VOICEBONNET_SOUND_LICENSE = Apache-2.0 License
AIY_VOICEBONNET_SOUND_DEPENDENCIES = rpi-firmware

$(eval $(kernel-module))

KVER = $(shell uname -r)
KDIR = /lib/modules/$(KVER)/build

define AIY_VOICEBONNET_SOUND_BUILD_CMDS
	$(MAKE) -C $(KDIR) M=$(PWD)
endef

define AIY_VOICEBONNET_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/pulseaudio/alsa-mixer/profile-sets/
	$(INSTALL) -D -m 0644 $(@D)/ucm2/aiy-voicebonnet.conf \
		$(TARGET_DIR)/usr/share/pulseaudio/alsa-mixer/profile-sets/aiy-voicebonnet.conf
	$(INSTALL) -D -m 0644 $(@D)/ucm2/HiFi.conf \
		$(TARGET_DIR)/usr/share/pulseaudio/alsa-mixer/profile-sets/HiFi.conf
endef
$(eval $(generic-package))
