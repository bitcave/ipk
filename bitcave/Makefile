include $(TOPDIR)/rules.mk

PKG_NAME:=bitcave
PKG_VERSION:=0.0.6
PKG_RELEASE:=3


include $(INCLUDE_DIR)/package.mk

define Package/bitcave
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=bitcave
  URL:=http://bitcave.io
  PKGARCH:=all
  MAINTAINER:=Matthias Strubel <matthias.strubel@aod-rpg.de>
  DEPENDS:=+openvpn-openssl +ip
  SUBMENU:=Bitcave
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
		$(1)/etc/hotplug.d/iface \
		$(1)/etc/openvpn 

	$(INSTALL_BIN)  \
		./files/run_bitcave_cmd.sh \
		$(1)/usr/sbin
	$(INSTALL_BIN)  \
		./files/bitcave_lib.sh \
		$(1)/usr/sbin
	$(INSTALL_BIN)  \
		./files/convert_tun_to_lan.sh \
		$(1)/usr/sbin		
	$(INSTALL_BIN)  \
		./files/99-if-wan-awareness.sh \
		$(1)/etc/hotplug.d/iface
	$(INSTALL_BIN)  \
		./files/openvpn-**.sh \
		$(1)/etc/openvpn
endef

$(eval $(call BuildPackage,bitcave))

