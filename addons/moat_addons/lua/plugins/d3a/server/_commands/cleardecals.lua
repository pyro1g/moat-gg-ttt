COMMAND.Name = "ClearDecals"
COMMAND.Flag = D3A.Config.Commands.ClearDecals

COMMAND.Run = function(pl, args, supp)
	BroadcastLua("LocalPlayer():ConCommand('r_cleardecals')")
	D3A.Chat.Broadcast2(pl, moat_cyan, pl:NameID(), moat_white, " has cleared decals.")
end