include $(TOPDIR)/rules.mk

PKG_NAME:=bitcave-extroot
PKG_VERSION:=0.0.1
PKG_RELEASE:=1


include $(INCLUDE_DIR)/package.mk

define Package/bitcave-extroot
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=bitcave-extroot
  URL:=http://.,......
  PKGARCH:=all
  MAINTAINER:=Matthias Strubel <matthias.strubel@aod-rpg.de>
  SUBMENU:=Bitcave
  DEPENDS:=+kmod-usb-storage  +kmod-fs-ext4 +block-mount 
endef

define Package/bitcave-extroot/description
  Script collection for creating  a extroot filesystem on the USB Stick
endef


define Package/bitcave-extroot/postinst
	#!/bin/sh

	exit 0
endef

define Package/bitcave-extroot/prerm
	#!/bin/ssh
	exit 0
endef


define Build/Compile
endef

define Build/Configure
endef


define Package/bitcave-extroot/install
	$(INSTALL_DIR) \
		$(1)/usr/sbin 

	$(CP)  \
		./files/*.sh \
		$(1)/usr/sbin
endef

$(eval $(call BuildPackage,bitcave-extroot))
