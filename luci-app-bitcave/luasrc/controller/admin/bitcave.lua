module("luci.controller.admin.bitcave", package.seeall)

function index()

        entry({"admin", "bitcave"}, template("bitcave/bitcave_overview"), _("Bitcave"), 10)
	entry({"admin", "bitcave", "vpnpass"}, call("action_vpn_pw_change"))
	entry({"admin", "bitcave", "vpn"}, cbi("bitcave/vpn"), _("Bitcave-VPN"), 11)

end

function action_vpn_pw_change()
                               
        local uci   = luci.model.uci.cursor()
                                             
        local vpn_name=luci.http.formvalue("bitcave.vpn_name")
        local in_vpn_user=luci.http.formvalue("bitcave.vpn.user")
        local in_vpn_pass=luci.http.formvalue("bitcave.vpn.pass")
                                                                 
        if  uci:get("openvpn", vpn_name) == "openvpn" then       
                if in_vpn_user ~= nil and in_vpn_pass ~= nil then
                                                                 
                        local file_output = in_vpn_user .. "\n" .. in_vpn_pass  .. "\n"
                                                                                       
                        local fs = require "nixio.fs"                                  
                        fs.writefile( uci:get_list("openvpn", vpn_name, "auth_user_pass")[1] , file_output )
			luci.http.redirect(luci.dispatcher.build_url("admin/bitcave"))
                else                                                                                        
                        local test =uci:get_list("openvpn", vpn_name , "auth_user_pass" )                    
                        luci.template.render("bitcave/vpn_pass", { vpn_name=vpn_name  }  )  
                end                
        else
                luci.http.redirect(luci.dispatcher.build_url("admin/bitcave"))
        end                                                                   
                                                                              
end        

