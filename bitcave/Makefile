include $(TOPDIR)/rules.mk

PKG_NAME:=bitcave
PKG_VERSION:=0.0.1
PKG_RELEASE:=1


include $(INCLUDE_DIR)/package.mk

define Package/bitcave/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=bitcave
  URL:=http://.,......
  PKGARCH:=all
  MAINTAINER:=Matthias Strubel <matthias.strubel@aod-rpg.de>
#  SUBMENU:=
endef

define Package/bitcave
  $(call Package/bitcave/Default)
  DEPENDS:=openvpn-openssl
  MENU:=1
endef

define Package/bitcave/description
  Setup bitcave network configuration and management scripts.
endef


define Package/bitcave/postinst
	#!/bin/sh

	exit 0
endef

define Package/bitcave/prerm
	#!/bin/ssh
	exit 0
endef


define Build/Compile
endef

define Build/Configure
endef


define Package/bitcave/install
	$(INSTALL_DIR) \
		$(1)/usr/sbin \
		$(1)/etc/hotplug.d/iface

	$(CP)  \
		./files/bitcave_lib.sh.sh \
		$(1)/usr/sbin
	$(CP)  \
		./files/99-if-wan-awareness.sh \
		$(1)/etc/hotplug.d/iface
endef

$(eval $(call BuildPackage,bitcave))

