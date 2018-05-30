local GetGlobalFloat = GetGlobalFloat
Lava = Lava or {}

Lava.SetLevel = function( n ) Lava.CurrentLevel = n end
Lava.ShiftLevel = function( n )	Lava.CurrentLevel = Lava.CurrentLevel + n end
Lava.StartingLevel = false
Lava.CurrentLevel = -32768
Lava.GetLevel = function()
	return CLIENT and GetGlobalFloat("$lavalev", -32768 ) or SERVER and Lava.CurrentLevel
end

-- end of sh
local SetGlobalFloat = SetGlobalFloat
local table = table
local Lava = Lava
local Values = Values
local hook = hook
local FrameTime = FrameTime
local player_manager = player_manager
local CurTime = CurTime
local m_UnderDescentAmount = 16 * 1.5





util.AddNetworkString("LAVA_I_Just_Joined")
util.AddNetworkString("lava_Begin")
util.AddNetworkString("LAVA_End")
util.AddNetworkString("LAVA_NewKills")
util.AddNetworkString("lava_Prep")
util.AddNetworkString("LAVA_Kill")
util.AddNetworkString("LAVA_KStreak")

MG_LAVA = MG_LAVA or {}
MG_LAVA.Hooks = MG_LAVA.Hooks or {}
MG_LAVA.Players = MG_LAVA.Players or {}
MG_LAVA.AmmoTypes = {
    "AR2",
    "Pistol",
    "SMG1",
    "357",
    "Buckshot",
    "AlyxGun"
}
MG_LAVA.DefaultLoadout = {
}
MG_LAVA.JOver = false
MG_LAVA.KillsMax = 50
MG_LAVA.InProgress = MG_LAVA.InProgress or false
MG_LAVA.TimeEnd = MG_LAVA.TimeEnd or 0

function MG_LAVA.HookAdd(event, func)
    hook.Add(event, "MG_LAVA_" .. event, func)
    table.insert(MG_LAVA.Hooks, {event, "MG_LAVA_" .. event})
end

function MG_LAVA.RemoveHooks()
	for k, v in pairs(MG_LAVA.Hooks) do
		hook.Remove(v[1], v[2])
	end
end

function MG_LAVA:DoEnding(force)
    MG_LAVA.RemoveHooks()
    MG_LAVA.ResetVars()
    MG_LAVA.HandleDamageLogStuff(true)
    RunConsoleCommand("ttt_roundrestart")
    hook.Remove("TTTCheckForWin", "MG_LAVA_DELAYWIN")
    MOAT_MINIGAME_OCCURING = false
    MG_LAVA.InProgress = false
end

function MG_LAVA.ResetVars()
    MG_LAVA.Hooks = {}
    MG_LAVA.Players = {}
	MG_LAVA.Loadout = {}
end

function MG_LAVA.StripWeapons(ply)
	if (not IsValid(ply)) then return end
    for k, v in pairs(ply:GetWeapons()) do
        if (IsValid(v) and not MG_LAVA.DeafultLoadout[v:GetClass()] and v.Kind ~= WEAPON_UNARMED) then
            if (v.SetZoom) then
                v:SetZoom(false)
            end
            if (v.SetIronSights) then
                v:SetIronsights(false)
            end

            if (IsValid(ply)) then
				ply:StripWeapon(v:GetClass())
			end
        end
    end
end

function MG_LAVA.GiveAmmo(ply)
end


function MG_LAVA.PreventLoadouts()
    return true
end

function MG_LAVA.HandleDamageLogStuff(ending)
    if (not Damagelog) then return end

    Damagelog.RDM_Manager_Enabled = ending

    for k, v in pairs(player.GetAll()) do
        v.IsGhost = not ending
    end
end

function MG_LAVA.DoKill(ply)
end

function MG_LAVA.PlayerDeath(vic, inf, att)

end

function MG_LAVA.FindCorpse(ply)
end

function MG_LAVA.RemoveCorpse(corpse)
end

function MG_LAVA.Move(ply,mv)
end

function MG_LAVA.RespawnPlayer(ply)

end

function MG_LAVA.GiveWeapon(ply,v)

end

function MG_LAVA.GiveWeapons(ply)
    MG_LAVA.StripWeapons(ply)
end

local sp_time = 5

function MG_LAVA.StartCommand(ply,cmd)

end

function MG_LAVA.PlayerSpawn(ply)
    ply:SetRole(ROLE_INNOCENT)
    ply:ResetEquipment()
    ply:SetCredits(0)
    ply:ShouldDropWeapon(false)

end
local rarity_to_placing = {[1] = math.random(5,6), [2] = 5, [3] = 4, [4] = 4, [5] = 4}
function MG_LAVA.Win()
    if MG_LAVA.Won then return end
    Lava.CurrentLevel = Entity(0):GetModelRenderBounds().z
    NextSuperDecentTime = nil
    MG_LAVA.Won = true
    timer.Simple(25, function() MG_LAVA:DoEnding() end)
    --print("WIN:",team)
    net.Start("LAVA_End")
    local t = {}
    for k,v in pairs(player.GetAll()) do
        if not IsValid(v) then continue end
        if not v.LavaScore then v.LavaScore = 0 end
        table.insert(t,{v,math.Round(v.LavaScore)})
    end
    table.sort(t,function(a,b) return a[2] > b[2] end)
    net.WriteTable(t)
    net.Broadcast()

    timer.Simple((0.2 * ((#t - 3) + 0.5 ) + (4.5)),function()
        for k, v in ipairs(t) do
            if not IsValid(v[1]) then continue end
            if (k == 1) then
                local es = math.random(1, 6)

                if (es == 6) then
                    v[1]:m_DropInventoryItem(6)
                else
                    v[1]:m_DropInventoryItem(5)
                end

                continue 
            end

            if (rarity_to_placing[k]) then
                v[1]:m_DropInventoryItem(rarity_to_placing[k])
            else
                v[1]:m_DropInventoryItem(3)
            end
        end
    end)
end

function MG_LAVA.Kills()
    
end

function player.GetAlive()
	local tab = {}
	for _,Player in ipairs( player.GetAll() ) do
		if Player:Alive() and (not Player:IsSpec()) then
			table.insert( tab, Player )
		end
	end
	return tab
end
debug.setmetatable(-1, {
	__index = math
})
function MG_LAVA.Think()
    if Lava.CurrentLevel ~= GetGlobalFloat("$lavalev", -10000) then
		SetGlobalFloat("$lavalev", Lava.CurrentLevel)
	end
    if not MG_LAVA.InProgress then return end
    local i = 0
    for k,v in ipairs(player.GetAll()) do
        if v:Alive() and (not v:IsSpec()) then 
            if not v.LavaScore then v.LavaScore = 0 end
            i = i + 1 
            v.LavaScore = v.LavaScore + 1 -- ik this is lazy
        end
    end
    --print("Players left: " .. i)
    if i < 2 then
        MG_LAVA.Win()
    end
    if CurTime() > MG_LAVA.TimeEnd then
        MG_LAVA.Win()
    end
    if not Lava.StartingLevel then
		Lava.StartingLevel = Entity(0):GetModelRenderBounds().z
		Lava.CurrentLevel = Lava.StartingLevel
	end

    if MG_LAVA.Won then return end
    NextSuperDecentTime = NextSuperDecentTime or CurTime()

    if NextSuperDecentTime < CurTime() then
        local tab = player.GetAlive()
        table.sort(tab, function(a, b) return a:GetPos().z < b:GetPos().z end)

        if tab[1] then
            local t = ((tab[1]:GetPos().z - m_UnderDescentAmount - Lava.GetLevel()) * FrameTime() / 12):max(FrameTime() * 6)
            Lava.ShiftLevel(t)

            if t <= FrameTime() * 10 then
                NextSuperDecentTime = CurTime() + 20
                m_UnderDescentAmount = 8
            end
        end
    else
        Lava.ShiftLevel(FrameTime() * 3.8)
    end
end

local SoundsList = {"vo/npc/male01/help01.wav", "ambient/voices/m_scream1.wav", "vo/npc/male01/myleg02.wav", "vo/npc/male01/myleg01.wav", "vo/npc/male01/ohno.wav", "vo/npc/male01/moan01.wav", "vo/npc/male01/moan03.wav", "vo/ravenholm/monk_helpme03.wav"}


function MG_LAVA.PlayerTick(Player)
    if Player:Alive() and Player:GetPos().z <= Lava.CurrentLevel and not Player:IsSpec() then
        if Player:WaterLevel() > 0 then Player:Kill() end
		Player:Ignite(0.1, 0)
		Player.m_NextScreamSoundTime = Player.m_NextScreamSoundTime or CurTime()

		if Player.m_NextScreamSoundTime <= CurTime() then
			Player.m_NextScreamSoundTime = CurTime() + 1
			Player:EmitSound((table.Random(SoundsList)))
		end
	end
end

function MG_LAVA.PostPlayerDeath(Player)
    Player:Extinguish()
    if Player:GetPos().z <= Lava.GetLevel() then
		local rag = Player:GetRagdollEntity()
		if IsValid( rag ) then
			rag:SetModel("models/player/charple.mdl")
			rag:Ignite(500, 0)
		end
	end
end

function MG_LAVA.TakeDamage(ply, dmginfo)
    if ply:IsPlayer() then
        if dmginfo:IsDamageType(DMG_BURN) then
            dmginfo:ScaleDamage(5)
        elseif dmginfo:IsDamageType(DMG_CRUSH) then
            dmginfo:ScaleDamage(0)
        end
    end
end

function MG_LAVA.PlayerShouldTakeDamage(ply,ent)
    if ent:GetClass() == "prop_physics" then return false end
    if ply:IsPlayer() and ent:IsPlayer() then return false end -- ?
end

function MG_LAVA.KarmaStuff()
    return true
end

function MG_LAVA.PlayerDisconnected(ply)

end

function MG_LAVA.Collide(a,b)
    /*if a:IsPlayer() and b:IsPlayer() and (a:GetMoveType() == MOVETYPE_LADDER or b:GetMoveType() == MOVETYPE_LADDER) then
        return false
    end
    return true*/
end

--MOVETYPE_LADDER
function MG_LAVA.PrepRound(mk, pri, sec, creds)
    TEST_lava = false
    MG_LAVA.Won = false
	MG_LAVA.JOver = false
	MG_LAVA.HandleDamageLogStuff(false)

    for k, v in pairs(player.GetAll()) do
        MG_LAVA.StripWeapons(v)
        v:StripAmmo()
    end

    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and v:IsValid() and v ~= NULL and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_LAVA.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end

	MG_LAVA.HookAdd("MoatInventoryShouldGiveLoadout", MG_LAVA.PreventLoadouts)
	MG_LAVA.HookAdd("TTTBeginRound", MG_LAVA.BeginRound)
	MG_LAVA.HookAdd("CanPlayerSuicide", function(ply) return true end)
    MG_LAVA.HookAdd("PlayerDeath",MG_LAVA.PlayerDeath)
    MG_LAVA.HookAdd("PlayerSpawn",MG_LAVA.PlayerSpawn)
    MG_LAVA.HookAdd("Think",MG_LAVA.Think)
    MG_LAVA.HookAdd("EntityTakeDamage",MG_LAVA.TakeDamage)
    MG_LAVA.HookAdd("PlayerShouldTakeDamage",MG_LAVA.PlayerShouldTakeDamage)
    MG_LAVA.HookAdd("Move",MG_LAVA.Move)
    MG_LAVA.HookAdd("TTTKarmaGivePenalty", MG_LAVA.KarmaStuff)
    MG_LAVA.HookAdd("PlayerDisconnected", MG_LAVA.PlayerDisconnected)
    MG_LAVA.HookAdd("StartCommand", MG_LAVA.StartCommand)
    MG_LAVA.HookAdd("TTTCanUseTraitorButton",function() return false end)
    MG_LAVA.HookAdd("PlayerTick",MG_LAVA.PlayerTick)
    MG_LAVA.HookAdd("PostPlayerDeath",MG_LAVA.PostPlayerDeath)
    MG_LAVA.HookAdd("ShouldCollide",MG_LAVA.Collide)
    MG_LAVA.SpawnPoints = {}


    hook.Add("TTTCheckForWin", "MG_LAVA_DELAYWIN", function() return WIN_NONE end)

    -- need to call this again? just for safe measures
    for k, v in pairs(player.GetAll()) do
        MG_LAVA.StripWeapons(v)
    end

	MOAT_MINIGAME_OCCURING = true
end


function MG_LAVA.BeginRound()
    SetRoundEnd(CurTime() + 900)
    for k , v in pairs(ents.GetAll()) do
        if (IsValid(v) and v:IsValid() and v ~= NULL and (v:GetClass():find("ammo") or (v:GetClass():StartWith("weapon_") and not MG_LAVA.DefaultLoadout[v:GetClass()]))) then
            v:Remove()
        end
    end
    for k,v in pairs(player.GetAll()) do
        v:Spawn()
        v:SetRole(ROLE_INNOCENT)
        v:Give("lava_fists")
        v:Give("weapon_ttt_unarmed")
        timer.Simple(1,function()
            v:SelectWeapon("lava_fists")
        end)
        --v:SetCustomCollisionCheck(true)
        --v:CollisionRulesChanged()
        v.LavaScore = 0
    end
    MG_LAVA.InProgress = true
    MG_LAVA.TimeEnd = CurTime() + (60 * 10)
    net.Start("lava_Begin")
    net.Broadcast()

end


local allowed_ids = {
    ["STEAM_0:0:46558052"] = true,
    ["STEAM_0:0:96933728"] = true
}

concommand.Add("moat_start_lava", function(ply, cmd, args)
    if ((ply ~= NULL and not allowed_ids[ply:SteamID()]) or GetRoundState() ~= ROUND_PREP) then

        return
    end

    SetRoundEnd(CurTime() + 30) -- pre
    timer.Adjust("prep2begin", 30, 1, BeginRound)
    timer.Adjust("selectmute", 14, 1, function() MuteForRestart(true) end)

    net.Start("lava_Prep")
    net.Broadcast()

    MG_LAVA.PrepRound(max_kills)
end)

concommand.Add("moat_end_lava", function(ply, cmd, args)
    if (not allowed_ids[ply:SteamID()]) then

        return
    end

    MG_LAVA.InProgress = false
    MG_LAVA.Win()
end)


function MG_LAVA.TrackSpawnPoints() 

end
