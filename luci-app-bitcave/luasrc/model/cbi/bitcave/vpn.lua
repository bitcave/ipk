m = Map("openvpn", "VPN")
m:chain("network")


s = m:section(TypedSection, "openvpn" , "VPN-Client Config")
s.addremove = false
s.dynamic=false

p = s:option(Flag, "enabled", "Enabled")
p.default = "0"
p.optional=false
p.rmempty=false

pwd_button = s:option( Button, "__setPWD")

pwd_button.title = "Change Login User&Password"
pwd_button.inputtitle  = "Change"
pwd_button.inpoutstyle = "apply"

function pwd_button.write(self, section)                                                                                     
                luci.http.redirect(luci.dispatcher.build_url("admin/bitcave/vpnpass")  ..  "?bitcave.vpn_name=" .. section  )
end               
        
                                        
return m      
