
if (SERVER) then
	util.AddNetworkString("Moat.Talents.Mark")
	util.AddNetworkString("Moat.Talents.Mark.End")
else
	local markedPlayers = {}

	net.Receive("Moat.Talents.Mark", function()
		local vic = net.ReadEntity()
		if (not IsValid(vic)) then return end
		if (vic == LocalPlayer()) then return end
		
		local color = net.ReadColor()
		if (not color) then
			color = Color(0, 255, 0)
		end
		
		markedPlayers[vic] = color
	end)
	
	net.Receive("Moat.Talents.Mark.End", function()
		local vic = net.ReadEntity()
		if (not IsValid(vic)) then return end
		if (vic == LocalPlayer()) then return end
		
		markedPlayers[vic] = nil
	end)
	
	hook.Add("PreDrawHalos", "Moat.Talents.Mark", function()
		local colors = {}
		
		for vic, color in pairs(markedPlayers) do
			if (not IsValid(vic) or vic:Team() == TEAM_SPEC) then
				markedPlayers[vic] = nil
				continue 
			end

			if (not colors[color]) then
				colors[color] = {}
			end
			
			table.insert(colors[color], vic)
		end
		
		for color, players in pairs(colors) do
			halo.Add(players, color, 2, 2, 1, true, true)
		end
	end)
end