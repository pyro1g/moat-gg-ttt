ITEM.ID = 17
ITEM.Name = "NBA Token"
ITEM.Description = "Using this will grant NBA benefits permanently! Benefits of joining the NBA are in the 'Support us!' tab"
ITEM.Rarity = 8
ITEM.Collection = "Meta Collection"
ITEM.Image = "https://i.moat.gg/19-01-10-G6T.png"
ITEM.Active = false

-- Will only be able to be bought with SC, not done yet. Just pushing votekick meme

//Buying VIP for your friends or trading it for IC is about to be way easier! People that already own VIP will be able to purchase VIP tokens that are able to be traded!
ITEM.ItemUsed = function(pl, slot, item)
	moat_makevip(pl:SteamID64())
	m_AddCreditsToSteamID(pl:SteamID(), 10000)
end