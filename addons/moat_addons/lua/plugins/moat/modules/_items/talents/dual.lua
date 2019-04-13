TALENT.ID = 98
TALENT.Name = "Dual"
TALENT.NameEffect = "bounce"
TALENT.NameColor = Color(240, 10, 10)
TALENT.Description = "You have two guns. Your damage is decreased by %s_^"
TALENT.Tier = 1
TALENT.Melee = false
TALENT.NotUnique = false
TALENT.LevelRequired = {min = 0, max = 0}

TALENT.Modifications = {}
TALENT.Modifications[1] = {min = 20, max = 30}


util.AddNetworkString "moat_talents.Dual"
function TALENT:ModifyWeapon( weapon, talent_mods )

    net.Start "moat_talents.Dual"
        net.WriteUInt(weapon.Weapon:EntIndex(), 32)
    net.Broadcast()

    weapon.Weapon.HoldType = "duel"

	local pri = weapon.Primary
	local mult = (self.Modifications[1].min + (self.Modifications[1].max - self.Modifications[1].min) * talent_mods[1]) / 100

    pri.Damage = pri.Damage * (1 - mult)

    pri.Delay = pri.Delay / 1.5

    pri.ClipSize = pri.ClipSize * 1.5
    pri.ClipMax = pri.ClipMax * 1.5
    pri.DefaultClip = pri.DefaultClip * 1.5
    pri.Recoil = pri.Recoil * 1.5

	if (pri.Cone) then
		pri.Cone = pri.Cone * 2
	end

	if (pri.ConeX) then
		pri.ConeX = pri.ConeX * 2
	end

	if (pri.ConeY) then
		pri.ConeY = pri.ConeY * 2
    end
	weapon.Weapon.IronSightsPos = nil
	weapon.Weapon.IronSightsAng = nil
end