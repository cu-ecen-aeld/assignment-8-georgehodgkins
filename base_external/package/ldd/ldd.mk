
# LDD

LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-georgehodgkins.git'
LDD_VERSION = $(shell git ls-remote $(LDD_SITE) master | cut -f1)
LDD_SITE_METHOD = git
LDD_GIT_SUBMOUDLES = YES

LDD_MODULE_SUBDIRS = 'misc-modules scull'
LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

$(eval $(kernel-module))
$(eval $(generic-package))
