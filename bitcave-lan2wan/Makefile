include $(TOPDIR)/rules.mk

PKG_NAME:=bitcave-lan2wan
PKG_VERSION:=0.0.1
PKG_RELEASE:=1


include $(INCLUDE_DIR)/package.mk

define Package/bitcave-lan2wan
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Bitcave
  TITLE:=bitcave-lan2wan
  URL:=http://.,......
  PKGARCH:=all
  MAINTAINER:=Matthias Strubel <matthias.strubel@aod-rpg.de>
  DEPENDS:=
endef

define Package/bitcave-lan2wan/description
   Flips on devices with only one ethernet port the configuration to a WAN port and enables wifi.
endef


define Package/bitcave-lan2wan/postinst
	#!/bin/sh
	#/bin/bitcave_lan2wan.sh
	exit 0
endef

define Package/bitcave-lan2wan/prerm
	#!/bin/ssh
	exit 0
endef


define Build/Compile
endef

define Build/Configure
endef


define Package/bitcave-lan2wan/install
	$(INSTALL_DIR) \
		$(1)/usr/sbin 

	$(CP)  \
		./files/*.sh \
		$(1)/usr/sbin
endef

$(eval $(call BuildPackage,bitcave-lan2wan))
