ESX                			 = nil
local PlayersVente			 = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_treasurehunter:GiveItem')
AddEventHandler('esx_treasurehunter:GiveItem', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local Quantity = xPlayer.getInventoryItem(Config.Zones.Vente.ItemRequires).count

	if Quantity >= 15 then
		TriggerClientEvent('esx:showNotification', _source, _U('stop_npc'))
		return
	else
		local amount = Config.Zones.Vente.ItemAdd
		local item = Config.Zones.Vente.ItemDb_name
		xPlayer.addInventoryItem(item, amount)
		TriggerClientEvent('esx:showNotification', _source, 'Salvage Collected ~g~ move on.') --EN
		-- TriggerClientEvent('esx:showNotification', _source, 'Erfolgreich geborgen~g~ weiter gehts!') --DE
	end

end)

local function Vente(source)

	SetTimeout(Config.Zones.Vente.ItemTime, function()

		if PlayersVente[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem(Config.Zones.Vente.ItemRequires).count

			if Quantity < Config.Zones.Vente.ItemRemove then
				TriggerClientEvent('esx:showNotification', _source, '~r~You have no more bills to cash.') --EN
				-- TriggerClientEvent('esx:showNotification', _source, '~r~Du hast keinen Rechnungen mehr zu bezahlen.') --DE
				PlayersVente[_source] = false
			else
				local amount = Config.Zones.Vente.ItemRemove
				local item = Config.Zones.Vente.ItemRequires
				Citizen.Wait(1500)
				xPlayer.removeInventoryItem(item, amount)
				xPlayer.addMoney(Config.Zones.Vente.ItemPrice)
				TriggerClientEvent('esx:showNotification', _source, 'You have earned ~g~$' .. Config.Zones.Vente.ItemPrice) --EN
				-- TriggerClientEvent('esx:showNotification', _source, 'Du hast ~g~$ bekommen.' .. Config.Zones.Vente.ItemPrice) --DE
				Vente(_source)
			end

		end
	end)
end

RegisterServerEvent('esx_treasurehunter:startVente')
AddEventHandler('esx_treasurehunter:startVente', function()

	local _source = source

	if PlayersVente[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~No bills to cash!') --EN
		-- TriggerClientEvent('esx:showNotification', _source, '~r~Keine Rechnung, kein Bargeld!') --DE
		PlayersVente[_source] = false
	else
		PlayersVente[_source] = true
		TriggerClientEvent('esx:showNotification', _source, '~g~Cashing ~w~bills...') --EN
		-- TriggerClientEvent('esx:showNotification', _source, '~g~Einlösen von ~w~Rechnungen...') --DE
		Vente(_source)
	end
end)

RegisterServerEvent('esx_treasurehunter:stopVente')
AddEventHandler('esx_treasurehunter:stopVente', function()

	local _source = source

	if PlayersVente[_source] == true then
		PlayersVente[_source] = false
	else
		PlayersVente[_source] = true
	end
end)
