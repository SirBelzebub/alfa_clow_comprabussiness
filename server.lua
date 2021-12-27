ESX              = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--CONCESSIONARIO--
ESX.RegisterServerCallback('alfa_clown_comprabusiness:compraconc', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= 1000000 then
		xPlayer.removeMoney(1000000)
		xPlayer.setJob("cardealer", 3)
		TriggerClientEvent('okokNotify:Alert', source, "Aziende", "Hai pagato: 1.000.000$ e sei il nuovo titolare della concessionaria!", 2000, 'success')
		cb(true)
	else
		TriggerClientEvent('okokNotify:Alert', source, "Aziende", "Non hai abbastanza denaro.", 2000, 'error')
		cb(false)
	end
end)