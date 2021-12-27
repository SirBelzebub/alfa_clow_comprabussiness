ESX              = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--CONCESSIONARIO--
--#MENU
-------------------------------------------------------
local optionsconc = {
    {label = "Si", value = 'compra_si_conc'}, -- SI, compra
    {label = "No", value = 'compra_no_conc'}, -- NO, compra
}
-------------------------------------------------------
function OpenMenu(compraconc)
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_compraconc', {
        title    = "Vuoi comprare la concessionaria?",
        align    = "left",
        elements = optionsconc
    }, function(data, menu)
        if data.current.value == 'compra_si_conc' then
            CompraConc()
    end -- NEGRO CON SOLDI
    	if data.current.value == 'compra_no_conc' then
        	NoCompraConc()
    end -- NO MONEY NEGRO
end,
    function(data, menu) -- CHIUDE IL MENU
        menu.close()
    end)
end
-------------------------------------------------------
function CompraConc()
	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('alfa_clown_comprabusiness:compraconc')
end
-------------------------------------------------------
function NoCompraConc()
	ESX.UI.Menu.CloseAll()
end
-----------------------------------------------------------------------------------------------------------------------------
--#MARKER
Citizen.CreateThread(function()
	compraconcessionario()
end)

function compraconcessionario()
	for k, v in pairs(Config.Concessionario) do
		if ESX.PlayerData.job.name == 'disoccupato' then
		TriggerEvent('gridsystem:registerMarker', {
			name = 'compra_concessionario'..v,
			pos = vector3(v),
			scale = vector3(0.5, 0.5, 0.5),
			msg = '',
			--control = 'E',
			type = 29,
			color = { r = 255, g = 0, b = 0 },
			action = function()
				OpenMenu("compraconc")
			end,
			onEnter = function()
				exports['okokTextUI']:Open('Premi [E] per comprare la concessionaria', 'darkgreen', 'left')
			end,
			onExit = function()
				exports['okokTextUI']:Close()
			end
		  })
		end
	end
end