AddCSLuaFile()

----
-- Need to report a bug? We'd love to talk with you! <3<3<3
-- The best way to contact us is on our (moat.chat) Discord server. (our dm's are open)
----

yugh.i "autoexec.lua"

yugh.i "moat/servers.lua"
yugh.i "moat/ranks.lua"
yugh.i "moat/superadmin.lua"

yugh.i "_dev/"

yugh.i "/system/" {
	"cfg/",
	"app/",
	"app/core/detours/",
	"app/core/helpers/"
}

if (SERVER) then
	include "datastore.lua"
end

yugh.i "plugins/"

hook.Run "moat"

------------------------------------
--
-- Looks lame but fuck u i like it
--	
------------------------------------

for k, v in ipairs({"\n\n",
[[            yyyhhdddmmmNNNM                                              MNNNmmmdddhhyyy        ]],
[[          /mMMMMMMMMMMMMMMMMm.                                        .mMMMMMMMMMMMMMMMNy`      ]],
[[        `:NMMMMMMMMMMMMMMMMMMms/.                                  ./smMMMMMMMMMMMMMMMMMMd:`    ]],
[[      -yNMMMMMMMMMMMMMMMMMMMMMMMNd/                              /dNMMMMMMMMMMMMMMMMMMMMMMMNy-  ]],
[[     sNMMMMMMMMMMMMMMMMMMMMMMMMMMMMh.                          .hMMMMMMMMMMMMMMMMMMMMMMMMMMMMNs ]],
[[    sMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN+`                      `+NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMs]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMd-                    :dMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNs`                `sNMMMMMMMMMMMMMMMMMMh/--/hMMMMMMMMMMM]],
[[    MMMMMMMMMMMMNNNNMMMMMMMMMMMMMMMMMMMMMm/              /mMMMMMMMMMMMMMMMMMMMy     `hMMMMMMMMMM]],
[[    MMMMMMMMMms::::::odMMMMMMMMMMMMMMMMMMMMy.          .yMMMMMMMMMMMMMMMMMMMMMh`    `dMMMMMMMMMM]],
[[    MMMMMMMNo.+dmNNmdo./NMMMMMMMMMMMMMMMMMMMN+`      `+NMMMMMMMMMMMMMMMMMmddNMMd+::+dMMmddmMMMMM]],
[[    MMMMMMMo hMMMMMMMMm`/MMMMMMMMMMMMMMMMMMMMMd-    :dMMMMMMMMMMMMMMMMMm:.``.oMMMMMMMM+.``./NMMM]],
[[    MMMMMMM.-MMMMMMMMMM/ NMMMMMMMMMMMMMMMMMMMMMNs  sNMMMMMMMMMMMMMMMMMM+      dMMMMMMh      oMMM]],
[[    MMMMMMM+`dMMMMMMMMN.-MMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMd-`  `/NMMMMMMN:`  `-mMMM]],
[[    MMMMMMMN/.smNMMNmy--mMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMNdyhdMMms++ymMMdhydNMMMM]],
[[    MMMMMMMMMh/:////:/yNMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMd.    .dMMMMMMMMMM]],
[[    MMMMMMMMMMMNmddmNMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMy      yMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMs-..-sMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNNMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMNyoyMMMMMMMMMMMMNMMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMMNMMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMM+   +MMMMMMMMMMM:oMMMMMMMMMMMMMMM..MMMMMMMMMMMMMMMo:MMMMMMMMMMho:--:ohMMMMMMMMMM]],
[[    MMMMMMMMMMMM/   /MMMMMMMMMMM: .hMMMMMMMMMMMMM..MMMMMMMMMMMMMd- :MMMMMMMMs.:ymNNmy:.yMMMMMMMM]],
[[    MMMMMMMddddd-   -ddddmMMMMMM:   /NMMMMMMMMMMM..MMMMMMMMMMMN+   :MMMMMMMo hMMMMMMMMy sMMMMMMM]],
[[    MMMMMN.`             `oMMMMM:    `yMMMMMMMMMM..MMMMMMMMMMy.    :MMMMMMM`:MMMMMMMMMM-`MMMMMMM]],
[[    MMMMMN/.````     ````-hMMMMM:      :dMMMMMMMM..MMMMMMMMm:      :MMMMMMM-.NMMMMMMMMN.-MMMMMMM]],
[[    MMMMMMMNNNNN:   /NNNNNMMMMMM:       `oNMMMMMM..MMMMMMNo`       :MMMMMMMd.:dMMMMMMd:.mMMMMMMM]],
[[    MMMMMMMMMMMM/   /MMMMMMMMMMM:         -hMMMMM..MMMMMh-         :MMMMMMMMNo:-/oo/-:sNMMMMMMMM]],
[[    MMMMMMMMMMMMy.`.hMMMMMMMMMMM:          `+mMMM..MMMm+`          :MMMMMMMMMMNmdyydmNMMMMMMMMMM]],
[[    MMMMMMMMMMMMMNmNMMMMMMMMMMMM:            .yMM..MMy.            :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:              :d..d:              :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:               `  `               :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    MMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMM]],
[[    NMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMN]],
[[    oMMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  :MMMMMMMMMMMMMMMMMMMMMMMMMMMo]],
[[     yMMMMMMMMMMMMMMMMMMMMMMMMMM:                                  -MMMMMMMMMMMMMMMMMMMMMMMMMMy ]],
[[      oNMMMMMMMMMMMMMMMMMMMMMMMM.                                  `NMMMMMMMMMMMMMMMMMMMMMMMNo  ]],
[[       .yNMMMMMMMMMMMMMMMMMMMMN+                                    /NMMMMMMMMMMMMMMMMMMMMNy.   ]],
[[         `/yNMMMMMMMMMMMMMMMNy-                                      .yNMMMMMMMMMMMMMMMNy/`     ]]
,"\n\n"}) do MsgC(Color(0, 255, 0), v .. "\n") end

moat.spacer()
moat.print "|"
moat.print "| Welcome to Moat TTT! (づ｡◕‿‿◕｡)づ"
moat.print "|"
moat.print "| We're changing the way people play and experience TTT together. We'd love your help."
moat.print "|"
moat.spacer()
moat.print "| Moat TTT's God Squad Development Team (¬‿¬)" 
moat.print "|"
for k,v in ipairs(Devs) do
	moat.print ("| " .. v.Name .. " > https://steamcommunity.com/profiles/" .. v.SteamID64)
end
moat.print "|"
moat.spacer()
moat.print "| Need to report a bug? We'd love to talk with you! <3<3<3"
moat.print [[| The best way to contact us is on our (moat.chat) Discord server. \ (•◡•) /]]
moat.print "|"
for i = 1, 3 do moat.print "| > https://moat.chat" end
moat.spacer()