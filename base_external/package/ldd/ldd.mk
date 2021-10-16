
# LDD

LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-georgehodgkins.git'
LDD_VERSION = $(shell git ls-remote $(LDD_SITE) master | cut -f1)
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES

LDD_MODULE_SUBDIRS = misc-modules
LDD_MODULE_SUBDIRS += scull
LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

define LDD_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0700 -t $(TARGET_DIR)/usr/bin $(@D)/scull/scull_load $(@D)/scull/scull_unload \
		$(@D)/misc-modules/module_load $(@D)/misc-modules/module_unload
endef

$(eval $(kernel-module))
$(eval $(generic-package))
