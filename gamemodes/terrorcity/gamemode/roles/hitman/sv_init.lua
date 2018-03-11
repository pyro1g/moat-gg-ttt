util.AddNetworkString "terrorcity.hitman.acquiretarget"
local ROLE = ROLE

local function SelectTarget()

    for _, ply in RandomPairs(player.GetAll()) do
        if (ply:IsDeadTerror() or ply:GetTraitor() or ply:IsSpec()) then
            continue
        end

        ROLE.Target = ply

        local hitmen = {}
        for k,v in pairs(player.GetAll()) do
            if (v:GetRole() == ROLE_HITMAN) then
                table.insert(hitmen, v)
            end
        end

        net.Start "terrorcity.hitman.acquiretarget"
            net.WriteEntity(ROLE.Target)
        net.Send(hitmen)

        break
    end

end

function ROLE:TTTBeginRound()
    SelectTarget()
end

function ROLE:TTTEndRound()
    ROLE.Target = nil
end

InstallRoleHook("PlayerDeath", 3)

function ROLE:PlayerDeath(victim, inflictor, attacker)
    if (victim ~= attacker and victim ~= ROLE.Target) then
        attacker:Kill()
    else
        attacker:AddCredits(2)
    end
end

function ROLE.PostPlayerDeath(ply)
    if (ply == ROLE.Target) then
        SelectTarget()
    end
end

hook.Add("PostPlayerDeath", "terrortown.roles.hitman", ROLE.PostPlayerDeath)