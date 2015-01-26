include $(TOPDIR)/rules.mk

PKG_NAME:=bitcave-vpn-pia
PKG_VERSION:=0.0.2
PKG_RELEASE:=2

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/bitcave-vpn-pia/Default
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=Bitcave
  TITLE:=bitcave-vpn-pia
  URL:=http://.,......
  PKGARCH:=all
  MAINTAINER:=Matthias Strubel <matthias.strubel@aod-rpg.de>
  DEPENDS:=bitcave
endef


define Package/bitcave-vpn-pia
	$(call Package/bitcave-vpn-pia/Default)
endef

define Package/bitcave-vpn-pia-Australia
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Australia 
  VARIANT:=Australia
endef
ifeq ($(BUILD_VARIANT),Australia)
	UCI_TAG:=PIA_AUST
	UCI_VPN_SERVER:="aus.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-CANY
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Canada NorthYork 
  VARIANT:=CANY
endef
ifeq ($(BUILD_VARIANT),CANY)
	UCI_TAG:=PIA_CANY
	UCI_VPN_SERVER:="ca.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-CATO
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Canada Toronto 
  VARIANT:=CATO
endef
ifeq ($(BUILD_VARIANT),CATO)
	UCI_TAG:=PIA_CATO
	UCI_VPN_SERVER:="ca-toronto.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-France
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in France
  VARIANT:=FR
endef
ifeq ($(BUILD_VARIANT),FR)
	UCI_TAG:=PIA_FR
	UCI_VPN_SERVER:="france.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-Germany
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in GERMANY
  VARIANT:=GER
endef
ifeq ($(BUILD_VARIANT),GER)
	UCI_TAG:=PIA_GER
	UCI_VPN_SERVER:="germany.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-HongKong
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Hong Kong
  VARIANT:=HK
endef
ifeq ($(BUILD_VARIANT),HK)
	UCI_TAG:=PIA_HK
	UCI_VPN_SERVER:="hk.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-Israel
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Israel
  VARIANT:=ISR
endef
ifeq ($(BUILD_VARIANT),ISR)
	UCI_TAG:=PIA_ISR
	UCI_VPN_SERVER:="israel.privateinternetaccess.com 1194"
endif



define Build/Compile
endef

define Build/Configure
endef


define Package/conffiles
	/etc/openvpn/PIA.auth
endef

define Package/bitcave-vpn-pia/install
	$(call Package/bitcave-vpn-pia/Default/install)
endef




define Package/bitcave-vpn-pia/Default/install
	$(INSTALL_DIR) \
		$(1)/etc/openvpn

	$(CP)  \
		./files/PIA* \
		$(1)/etc/openvpn
endef


define Package/bitcave-vpn-pia/Default/postinst
#!/bin/sh
	
. /usr/sbin/bitcave_lib.sh

uci set openvpn.$(UCI_TAG)=openvpn
uci set openvpn.$(UCI_TAG).enabled='0'
uci set openvpn.$(UCI_TAG).client='1'
uci set openvpn.$(UCI_TAG).dev=$$( get_tun_name )
uci set openvpn.$(UCI_TAG).proto=udp
uci set openvpn.$(UCI_TAG).remote=$(UCI_VPN_SERVER)
uci set openvpn.$(UCI_TAG).resolv_retry=infinite
uci set openvpn.$(UCI_TAG).nobind=1
uci set openvpn.$(UCI_TAG).persist_key=1
uci set openvpn.$(UCI_TAG).persist_tun=1
uci set openvpn.$(UCI_TAG).ca=/etc/openvpn/PIA-ca.crt
uci set openvpn.$(UCI_TAG).tls_client=1
uci set openvpn.$(UCI_TAG).remote_cert_tls=server
uci set openvpn.$(UCI_TAG).auth_user_pass=/etc/openvpn/PIA.auth
uci set openvpn.$(UCI_TAG).comp_lzo=1
uci set openvpn.$(UCI_TAG).verb=1
uci set openvpn.$(UCI_TAG).reneg_sec=0
uci set openvpn.$(UCI_TAG).crl_verify=/etc/openvpn/PIA-crl.pem


exit 0
endef

define Package/bitcave-vpn-pia/Default/prerm
#!/bin/sh
uci remove openvpn.$(UCI_TAG)=openvpn
endef

define BuildPlugin
  define Package/$(1)/postinst
	$(call Package/bitcave-vpn-pia/Default/postinst,$(1))
  endef
  define Package/$(1)/prerm
	$(call Package/bitcave-vpn-pia/Default/prerm,$(1))
  endef
  define Package/$(1)/install
	$(call Package/bitcave-vpn-pia/Default/install,$(1))
  endef
  $$(eval $$(call BuildPackage,$(1)))
endef

#$(eval $(call BuildPackage,bitcave-vpn-pia))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Australia))
$(eval $(call BuildPlugin,bitcave-vpn-pia-CANY))
$(eval $(call BuildPlugin,bitcave-vpn-pia-CATO))
$(eval $(call BuildPlugin,bitcave-vpn-pia-France))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Germany))
$(eval $(call BuildPlugin,bitcave-vpn-pia-HongKong))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Israel))