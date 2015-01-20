module("luci.controller.admin.bitcave", package.seeall)

function index()

        entry({"admin", "bitcave"}, template("bitcave/index"), _("Bitcave"), 10)

end

