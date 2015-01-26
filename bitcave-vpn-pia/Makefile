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
  VARIANT:=AUST
endef
ifeq ($(BUILD_VARIANT),AUST)
	UCI_TAG:=PIA_AUST
	UCI_VPN_SERVER:="aus.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-Canada-North-York
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Canada-North-York 
  VARIANT:=CANY
endef
ifeq ($(BUILD_VARIANT),CANY)
	UCI_TAG:=PIA_CANY
	UCI_VPN_SERVER:="ca.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-Canada-Toronto
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Canada-Toronto 
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

define Package/bitcave-vpn-pia-Hong-Kong
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

define Package/bitcave-vpn-pia-Japan
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Japan
  VARIANT:=JAP
endef
ifeq ($(BUILD_VARIANT),JAP)
	UCI_TAG:=PIA_JAP
	UCI_VPN_SERVER:="japan.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-Netherlands
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in the Netherlands
  VARIANT:=NL
endef
ifeq ($(BUILD_VARIANT),NL)
	UCI_TAG:=PIA_NL
	UCI_VPN_SERVER:="nl.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-Romania
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Romania
  VARIANT:=RO
endef
ifeq ($(BUILD_VARIANT),RO)
	UCI_TAG:=PIA_RO
	UCI_VPN_SERVER:="ro.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-Sweden
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Sweden
  VARIANT:=SE
endef
ifeq ($(BUILD_VARIANT),SE)
	UCI_TAG:=PIA_SE
	UCI_VPN_SERVER:="sweden.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-Switzerland
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in Switzerland
  VARIANT:=CH
endef
ifeq ($(BUILD_VARIANT),CH)
	UCI_TAG:=PIA_CH
	UCI_VPN_SERVER:="swiss.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-UK-London
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in UK-London
  VARIANT:=UKL
endef
ifeq ($(BUILD_VARIANT),UKL)
	UCI_TAG:=PIA_UKL
	UCI_VPN_SERVER:="uk-london.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-UK-Southampton
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in UK-Southampton
  VARIANT:=UKS
endef
ifeq ($(BUILD_VARIANT),UKS)
	UCI_TAG:=PIA_UKS
	UCI_VPN_SERVER:="uk-southampton.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-US-California
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in US-California
  VARIANT:=USC
endef
ifeq ($(BUILD_VARIANT),USC)
	UCI_TAG:=PIA_USC
	UCI_VPN_SERVER:="us-california.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-US-East
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in US-East
  VARIANT:=USE
endef
ifeq ($(BUILD_VARIANT),USE)
	UCI_TAG:=PIA_USE
	UCI_VPN_SERVER:="us-east.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-US-Florida
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in US-Florida
  VARIANT:=USF
endef
ifeq ($(BUILD_VARIANT),USF)
	UCI_TAG:=PIA_USF
	UCI_VPN_SERVER:="us-florida.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-US-Midwest
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in US-Midwest
  VARIANT:=USM
endef
ifeq ($(BUILD_VARIANT),USM)
	UCI_TAG:=PIA_USM
	UCI_VPN_SERVER:="us-midwest.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-US-Seattle
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in US-Seattle
  VARIANT:=USS
endef
ifeq ($(BUILD_VARIANT),USS)
	UCI_TAG:=PIA_USS
	UCI_VPN_SERVER:="us-seattle.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-US-Texas
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in US-Texas
  VARIANT:=UST
endef
ifeq ($(BUILD_VARIANT),UST)
	UCI_TAG:=PIA_UST
	UCI_VPN_SERVER:="us-texas.privateinternetaccess.com 1194"
endif

define Package/bitcave-vpn-pia-US-West
  $(call Package/bitcave-vpn-pia/Default)
  TITLE:=Private Internet Access - Endpoint located in US-West
  VARIANT:=USW
endef
ifeq ($(BUILD_VARIANT),USW)
	UCI_TAG:=PIA_USW
	UCI_VPN_SERVER:="us-west.privateinternetaccess.com 1194"
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
$(eval $(call BuildPlugin,bitcave-vpn-pia-Canada-North-York))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Canada-Toronto))
$(eval $(call BuildPlugin,bitcave-vpn-pia-France))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Germany))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Hong-Kong))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Israel))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Japan))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Netherlands))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Romania))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Sweden))
$(eval $(call BuildPlugin,bitcave-vpn-pia-Switzerland))
$(eval $(call BuildPlugin,bitcave-vpn-pia-UK-London))
$(eval $(call BuildPlugin,bitcave-vpn-pia-UK-Southampton))
$(eval $(call BuildPlugin,bitcave-vpn-pia-California))
$(eval $(call BuildPlugin,bitcave-vpn-pia-US-East))
$(eval $(call BuildPlugin,bitcave-vpn-pia-US-Florida))
$(eval $(call BuildPlugin,bitcave-vpn-pia-US-Midwest))
$(eval $(call BuildPlugin,bitcave-vpn-pia-US-Seattle))
$(eval $(call BuildPlugin,bitcave-vpn-pia-US-Texas))
$(eval $(call BuildPlugin,bitcave-vpn-pia-US-West))
