COMMAND.Name = "TradeBan"

COMMAND.Flag = D3A.Config.Commands.SetGroup
COMMAND.CheckRankWeight = true

COMMAND.Args = {{"string", "Name/SteamID"}, {"number", "Length"}, {"string", "TimeUnit"}, {"string", "Reason"}}

function GetTradeBanLength(sid64, cb)
	moat.mysql("SELECT max(if(unban_time IS NULL, 0, TIMESTAMPDIFF(SECOND, unban_time, CURRENT_TIMESTAMP))) as timeleft, reason from moat_tradebans WHERE (unban_time IS NULL or unban_time > CURRENT_TIMESTAMP) and steamid64 = ?;",
		sid64,
		function(data)
			return cb(data[1].timeleft, data[1].reason)
		end
	)
end
local function UpdateTradeBan(p)
	GetTradeBanLength(p:SteamID64(), function(left, reason)
		p.IsTradeBanned = left
		p.TradeBanReason = reason
	end)
end

COMMAND.Run = function(pl, args, supp)

	PrintTable(supp)
	PrintTable(args)

	local units2 = {}
	units2["seconds"] = true
	units2["minutes"] = true
	units2["hours"] = true
	units2["days"] = true
	units2["weeks"] = true
	units2["months"] = true
	units2["years"] = true
	
	local unban_time
	local targ = args[1]:upper()
	local banner = IsValid(pl) and pl:SteamID64() or "NULL"
	local reason = table.concat(args, " ", 4)

	if (supp[1] ~= 0 and units2[args[3]:lower()]) then
		unban_time = string.format("CURRENT_TIMESTAMP + INTERVAL %i %s", supp[1], args[3]:upper():sub(1, -2))
	elseif (supp[1] == 0 or args[3]:lower() == "perm") then
		unban_time = "NULL"
	else
		for k,v in pairs(units2) do
			table.insert(units2, k)
		end
		D3A.Chat.SendToPlayer2(pl, moat_red, "Time is incorrect! Supports perm / " .. table.concat(units2, " / "))
		return
	end
	
	local targpl = D3A.FindPlayer(targ)

	if (targpl and targpl.IsTradeBanned) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Target is trade banned already.")
		return
	end

	if (!targpl and string.sub(targ, 1, 8) != "STEAM_0:") then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Unknown player: " .. targ)
		return
	end
	if (reason:len() >= 128) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Ban reason too long! Must be less than 128 characters.")
		return
	end

	if (targpl) then
		targpl.IsTradeBanned = 0
		targ = targpl:SteamID()
		targpl.TradeBanReason = reason
	end

	targ = util.SteamIDTo64(targ)

	D3A.MySQL.Query("INSERT INTO moat_tradebans (steamid64, banner, reason, unban_time) VALUES(" .. targ .. ", " .. banner .. ", '" .. D3A.MySQL.Escape(reason) .. "', " .. unban_time .. ");", function()
		D3A.Chat.SendToPlayer2(pl, moat_green, "Successfully trade banned.")
		UpdateTradeBan(targpl)
	end)
end

hook.Add("PlayerSpawn", "moat_TradeBans", UpdateTradeBan)