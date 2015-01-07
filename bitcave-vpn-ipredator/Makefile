include $(TOPDIR)/rules.mk

PKG_NAME:=bitcave-vpn-ipredator
PKG_VERSION:=0.0.1
PKG_RELEASE:=1


include $(INCLUDE_DIR)/package.mk

define Package/bitcave-vpn-ipredator/Default
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=bitcave-vpn-ipredator
  URL:=http://.,......
  PKGARCH:=all
  MAINTAINER:=Matthias Strubel <matthias.strubel@aod-rpg.de>
#  SUBMENU:=
endef

define Package/bitcave-vpn-ipredator
  $(call Package/bitcave-vpn-ipredator/Default)
  DEPENDS:=openvpn-openssl
  MENU:=1
endef

define Package/bitcave-vpn-ipredator/description
   Does the basic configuration for running IP predator inside Bitcave
endef


define Package/bitcave-vpn-ipredator/postinst
	#!/bin/sh

	exit 0echo "Setting up OpenVPN config"
	touch /etc/config/openvpn
	uci set openvpn.IPredator=openvpn
	uci set openvpn.IPredator.enabled='0'
	uci set openvpn.IPredator.client='1'
	uci set openvpn.IPredator.dev='undef'
	uci set openvpn.IPredator.proto='udp'
	uci set openvpn.IPredator.resolv_retry='infinite'
	uci set openvpn.IPredator.float='1'
	uci set openvpn.IPredator.nobind='1'
	uci set openvpn.IPredator.persist_key='1'
	uci set openvpn.IPredator.persist_tun='1'
	uci set openvpn.IPredator.ca='/etc/openvpn/IPredator.se.ca.crt'
	uci set openvpn.IPredator.ns_cert_type='server'
	uci set openvpn.IPredator.tls_cipher='TLSv1:!ADH:!SSLv2:!NULL:!EXPORT:!DES:!LOW:!MEDIUM:@STRENGTH'
	uci set openvpn.IPredator.cipher='AES-256-CBC'
	uci set openvpn.IPredator.comp_lzo='yes'
	uci set openvpn.IPredator.passtos='1'
	uci set openvpn.IPredator.remote='pw.openvpn.ipredator.se 1194'
	uci set openvpn.IPredator.tls_client='1'
	uci set openvpn.IPredator.verb='3'
	uci add_list openvpn.IPredator.tls_auth='/etc/openvpn/IPredator.se.ta.key'
	uci add_list openvpn.IPredator.auth_user_pass='/etc/openvpn/IPredator.auth'

endef

define Package/bitcave-vpn-ipredator/prerm
	#!/bin/ssh
	uci remove openvpn.IPredator
	exit 0
endef


define Build/Compile
endef

define Build/Configure
endef


define Package/bitcave-vpn-ipredator/install
	$(INSTALL_DIR) \
		$(1)/etc/openvpn

	$(CP)  \
		./files/IPredator.* \
		$(1)/etc/openvpn
endef

$(eval $(call BuildPackage,bitcave-vpn-ipredator))
