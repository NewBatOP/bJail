Helper = {}

IS_IN_JAIL = false;
IS_UNJAIL = false;
JAIL_MESSAGE = nil;
JAIL_DURATION = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.ESX..'esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterNetEvent("bJail:JeTeMetEnJail")
AddEventHandler("bJail:JeTeMetEnJail", function(duration, message)
	PlayerJail = true;
	JAIL_MESSAGE = message
	JAIL_DURATION = tonumber(duration)
	TriggerEvent(Config.ESX..'skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			TriggerEvent(Config.ESX..'skinchanger:loadClothes', skin, {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 146, ['torso_2'] = 0,
				['decals_1'] = 0, ['decals_2'] = 0,
				['arms'] = 0, ['pants_1'] = 3,
				['pants_2'] = 7, ['shoes_1'] = 12,
				['shoes_2'] = 12, ['chain_1'] = 50,
				['chain_2'] = 0
			})
		else
			TriggerEvent(Config.ESX..'skinchanger:loadClothes', skin, {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 74, ['torso_2'] = 0,
				['decals_1'] = 0, ['decals_2'] = 0,
				['arms'] = 4, ['pants_1'] = 66,
				['pants_2'] = 6, ['shoes_1'] = 32,
				['shoes_2'] = 2, ['chain_1'] = 36,
				['mask_1'] = 0, ['mask_2'] = 0,
				['chain_2'] = 0, ['bproof_1'] = 0,
				['bproof_2'] = 0, ['helmet_1'] = 0,
				['helmet_2'] = 0,
				['bag_1'] = 0,
			})
		end
	end)
	IS_IN_JAIL = true;
	IS_UNJAIL = false;
	local Timer = 0;
    Citizen.CreateThread(function()
        while true do
            if (IS_IN_JAIL) then
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour voir vos informations")
                if (IsControlJustPressed(1, 51)) then
                    Penitentiary()
                end
                local player = PlayerPedId();
                local model = GetEntityModel(player)
                Helper:Switch(model, {
                    [GetHashKey("mp_m_freemode_01")] = function()
                        if #(GetEntityCoords(player) - vector3(1762.66, 2489.65, 45.85)) > 30.0 then
                            SetEntityCoords(player, 1762.66, 2489.65, 45.85 - 1.0)
                        end
                    end,
                    [GetHashKey("mp_f_freemode_01")] = function()
                        if #(GetEntityCoords(player) - vector3(1762.66, 2489.65, 45.85)) > 30.0 then
                            SetEntityCoords(player, 1762.66, 2489.65, 45.85 - 1.0);
                        end
                    end,
                    ["default"] = function()
                        if #(GetEntityCoords(player) - vector3(1762.66, 2489.65, 45.85)) > 30.0 then
                            SetEntityCoords(player, 1762.66, 2489.65, 45.85 - 1.0)
                        end
                    end
                })
            end
            Citizen.Wait(0)
        end
    end)
	Citizen.CreateThread(function()
		while true do
            TriggerServerEvent('bJail:JailEnSecondes')
			Citizen.Wait(1000)
			if (IS_IN_JAIL) and (JAIL_DURATION) > 0 then
				JAIL_DURATION = JAIL_DURATION - 1.0
			else
				return
			end
		end
	end)
end)

RegisterNetEvent("bJail:JeTeRemetDeHors")
AddEventHandler("bJail:JeTeRemetDeHors", function()
	PlayerJail = false;
	IS_UNJAIL = true
	IS_IN_JAIL = false
	JAIL_DURATION = 0
	RageUI.CloseAll()
    ESX.TriggerServerCallback(Config.ESX..'esx_skin:getPlayerSkin', function(skin) 
        TriggerEvent(Config.ESX..'skinchanger:loadSkin', skin)
    end)
	Citizen.Wait(1000)
	TriggerEvent(Config.ESX..'esx:restoreLoadout')
end)

function Penitentiary()

    mainMenu = RageUI.CreateMenu("", "BIENVENUE EN PRISON.")

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        Citizen.Wait(0)
	    	RageUI.IsVisible(mainMenu, function()
	    		RageUI.Button("Temps restant", "Temps restant avant votre libération", { RightLabel = JAIL_DURATION }, true, {

	    		})
	    		RageUI.Button("Raison", (JAIL_MESSAGE == nil and "Raison inconnu" or JAIL_MESSAGE), {}, true, {

	    		})

				RageUI.Button("Développeur :", "BatOP/Ghost", {}, true, {

	    		})
	    	end)
            if not RageUI.Visible(mainMenu) then
                mainMenu = RMenu:DeleteType("mainMenu", true)
            end
       end
end

function Helper:Switch(condition, args, is_fn)
	if type(args) == "table" then
		if is_fn == nil or is_fn then
			local fn = args[condition] or args["default"]
			if fn and type(fn) == "function" then
				fn()
			end
		elseif is_fn ~= nil and not is_fn then
			return (args[condition] or nil)
		end
	end
end

RegisterNetEvent("bJail:AdministrateurChangeLeJail")
AddEventHandler("bJail:AdministrateurChangeLeJail", function(table)
    JAIL_PLAYER = table;
    JAIL_PLAYER_COUNT = ESX.Table.SizeOf(table)
    while not JAIL_PLAYER do
        Citizen.Wait(1)
    end
end)
