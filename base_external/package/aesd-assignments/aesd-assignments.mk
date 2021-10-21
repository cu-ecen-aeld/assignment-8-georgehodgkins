
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-georgehodgkins.git'
AESD_ASSIGNMENTS_VERSION = $(shell git ls-remote $(AESD_ASSIGNMENTS_SITE) master | cut -f1)
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

AESD_ASSIGNMENTS_MODULE_SUBDIRS = aesd-char-driver
AESD_ASSIGNMENTS_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server clean
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 -t $(TARGET_DIR)/etc/init.d/ $(@D)/server/S99aesdsocket \
		$(@D)/aesd-char-driver/S98aesdchar
	$(INSTALL) -m 0700 -t $(TARGET_DIR)/usr/bin $(@D)/aesd-char-driver/aesdchar_load \
		$(@D)/aesd-char-driver/aesdchar_unload
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment8/drivertest.sh $(TARGET_DIR)/usr/bin/test_aesdchar
endef

$(eval $(kernel-module))
$(eval $(generic-package))
