include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bitcave
PKG_VERSION:=0.3.1
PKG_RELEASE:=1

PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-bitcave
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=The Bitcave
	URL:=https://github.com/bitcave
	MAINTAINER:=Matthias Strubel <strubel@bitcave.cc>
	DEPENDS:=+bitcave +luci-base
endef

define Package/luci-app-bitcave/description
	The Bitcave is a digital self-defense system in the form of a secret wifi 
	hotspot that helps you visit websites without being tracked or censored, 
	communicate anonymously, and download and share files securely 
	and in private. 
endef

define Build/Compile
endef

define Package/luci-app-bitcave/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	$(CP) ./luasrc/* $(1)/usr/lib/lua/luci
endef

$(eval $(call BuildPackage,luci-app-bitcave))
