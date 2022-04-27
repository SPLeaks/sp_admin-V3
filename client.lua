ESX = nil
local godmode = false
local infStamina = false
local invisibility = false
local fastSwim = false
local fastSprint = false
local superJump = false
local fireAmmo = false
local oneShotKill = false
local explossiveAmmo = false
local infiniteAmmo = false
local teleportGun = false
local vehicleGun = false
local whaleGun = false
local GetBlips = false

explosionType = 0
explosions = {
          {"EXPLOSION_GRENADE", 0}, {"EXPLOSION_GRENADELAUNCHER", 1},
          {"EXPLOSION_STICKYBOMB", 2}, {"EXPLOSION_MOLOTOV", 3},
          {"EXPLOSION_ROCKET", 4}, {"EXPLOSION_TANKSHELL", 5},
          {"EXPLOSION_HI_OCTANE", 6}, {"EXPLOSION_CAR", 7},
          {"EXPLOSION_PLANE", 8}, {"EXPLOSION_PETROL_PUMP", 9},
          {"EXPLOSION_BIKE", 10}, {"EXPLOSION_DIR_STEAM", 11},
          {"EXPLOSION_DIR_FLAME", 12}, {"EXPLOSION_DIR_WATER_HYDRANT", 13},
          {"EXPLOSION_DIR_GAS_CANISTER", 14}, {"EXPLOSION_BOAT", 15},
          {"EXPLOSION_SHIP_DESTROY", 16}, {"EXPLOSION_TRUCK", 17},
          {"EXPLOSION_BULLET", 18}, {"EXPLOSION_SMOKEGRENADELAUNCHER", 19},
          {"EXPLOSION_SMOKEGRENADE", 20}, {"EXPLOSION_BZGAS", 21},
          {"EXPLOSION_FLARE", 22}, {"EXPLOSION_GAS_CANISTER", 23},
          {"EXPLOSION_EXTINGUISHER", 24}, {"EXPLOSION_PROGRAMMABLEAR", 25},
          {"EXPLOSION_TRAIN", 26}, {"EXPLOSION_BARREL", 27},
          {"EXPLOSION_PROPANE", 28}, {"EXPLOSION_BLIMP", 29},
          {"EXPLOSION_DIR_FLAME_EXPLODE", 30}, {"EXPLOSION_TANKER", 31},
          {"EXPLOSION_PLANE_ROCKET", 32}, {"EXPLOSION_VEHICLE_BULLET", 33},
          {"EXPLOSION_GAS_TANK", 34}, {"EXPLOSION_XERO_BLIMP", 37},
          {"EXPLOSION_FIREWORK", 38}
}

Admin = {
	showcoords = false,
	showcrosshair = false,
	ghostmode = false,
    godmode = false,
    showName = false,
    gamerTags = {}
}

local Menu = {

    action = {

        '🔴',
        '🟢',
        '⚫',
        '🟣',
        '⚪',
        '🟠',
        '🔵',
    },


    list = 1
}
local Menu2 = {

    action = {

        '🔴',
        '🟢',
        '⚫',
        '🟣',
        '⚪',
        '🟠',
        '🔵',
    },


    list = 1
}

local Ped = {

    action = {

        'Load skin basic 👨‍🔬',
        'Chose a ped 🔍',
    },


    list = 1
}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('setgroup')
AddEventHandler('setgroup', function()
    group = true
end) 


  Citizen.CreateThread(function() -- INFINITE Ammo
    while true do
      Citizen.Wait(0)
  
      if infiniteAmmo then
        SetPedInfiniteAmmo(GetPlayerPed(-1), true)
              SetPedInfiniteAmmoClip(GetPlayerPed(-1), true)
              SetPedAmmo(GetPlayerPed(-1), (GetSelectedPedWeapon(GetPlayerPed(-1))), 99999)
      else
        SetPedInfiniteAmmo(GetPlayerPed(-1), false)
              SetPedInfiniteAmmoClip(GetPlayerPed(-1), false)
      end
    end
  end) 
  
Citizen.CreateThread(function()
    while true do
        Citizen.Wait( 2000 )

        if NetworkIsSessionStarted() then
            TriggerServerEvent( "checkadmin")
        end
    end
end )

local maxHealth = GetEntityMaxHealth(playerPed)
local health = GetEntityHealth(playerPed)
local newHealth = math.min(maxHealth , math.floor(health + maxHealth/1))

--==--==--==--
-- Noclip
--==--==--==--


function DrawPlayerInfo(target)
	drawTarget = target
	drawInfo = true
end

function StopDrawPlayerInfo()
	drawInfo = false
	drawTarget = 0
end
Citizen.CreateThread( function()
	while true do
		Citizen.Wait(0)
		if drawInfo then
			local text = {}
			-- cheat checks
			local targetPed = GetPlayerPed(drawTarget)
			
			table.insert(text,"[E] Stop")
			
			for i,theText in pairs(text) do
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.30)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(theText)
				EndTextCommandDisplayText(0.3, 0.7+(i/30))
			end
			
			if IsControlJustPressed(0,103) then
				local targetPed = PlayerPedId()
				local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
	
				RequestCollisionAtCoord(targetx,targety,targetz)
				NetworkSetInSpectatorMode(false, targetPed)
	
				StopDrawPlayerInfo()
				
			end
			
		end
	end
end)
function SpectatePlayer(targetPed,target,name)
    local playerPed = PlayerPedId() -- yourself
	enable = true
	if targetPed == playerPed then enable = false end

    if(enable)then

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(true, targetPed)
		DrawPlayerInfo(target)
        ESX.ShowNotification('~g~Spectator mode in progress')
    else

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(false, targetPed)
		StopDrawPlayerInfo()
        ESX.ShowNotification('~b~Spectator mode stopped')
    end
end

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(5)
    Button(GetControlInstructionalButton(2, config.controls.openKey, true))
    ButtonMessage("Disable Noclip")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, config.controls.goUp, true))
    ButtonMessage("Go Up")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, config.controls.goDown, true))
    ButtonMessage("Go Down")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, config.controls.turnRight, true))
    Button(GetControlInstructionalButton(1, config.controls.turnLeft, true))
    ButtonMessage("Turn Left/Right")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(1, config.controls.goBackward, true))
    Button(GetControlInstructionalButton(1, config.controls.goForward, true))
    ButtonMessage("Go Forwards/Backwards")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, config.controls.changeSpeed, true))
    ButtonMessage("Change Speed ("..config.speeds[index].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(config.bgR)
    PushScaleformMovieFunctionParameterInt(config.bgG)
    PushScaleformMovieFunctionParameterInt(config.bgB)
    PushScaleformMovieFunctionParameterInt(config.bgA)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

config = {
    controls = {
        -- [[Controls, list can be found here : https://docs.fivem.net/game-references/controls/]]
        openKey = 288, -- [[F2]]
        goUp = 85, -- [[Q]]
        goDown = 48, -- [[Z]]
        turnLeft = 34, -- [[A]]
        turnRight = 35, -- [[D]]
        goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
    },

    speeds = {
        -- [[If you wish to change the speeds or labels there are associated with then here is the place.]]
        { label = "Very Slow", speed = 0},
        { label = "Slow", speed = 0.5},
        { label = "Normal", speed = 2},
        { label = "Fast", speed = 4},
        { label = "Very Fast", speed = 6},
        { label = "Extremely Fast", speed = 10},
        { label = "Extremely Fast v2.0", speed = 20},
        { label = "Max Speed", speed = 25}
    },

    offsets = {
        y = 0.5, -- [[How much distance you move forward and backward while the respective button is pressed]]
        z = 0.2, -- [[How much distance you move upward and downward while the respective button is pressed]]
        h = 3, -- [[How much you rotate. ]]
    },

    -- [[Background colour of the buttons. (It may be the standard black on first opening, just re-opening.)]]
    bgR = 0, -- [[Red]]
    bgG = 0, -- [[Green]]
    bgB = 0, -- [[Blue]]
    bgA = 80, -- [[Alpha]]
}


noclipActive = false -- [[Wouldn't touch this.]]

index = 1 -- [[Used to determine the index of the speeds table.]]

Citizen.CreateThread(function()

    buttons = setupScaleform("instructional_buttons")

    currentSpeed = config.speeds[index].speed

    while true do
        Citizen.Wait(1)

        if noclipActive then
            DrawScaleformMovieFullscreen(buttons)

            local yoff = 0.0
            local zoff = 0.0

            if IsControlJustPressed(1, config.controls.changeSpeed) then
                if index ~= 8 then
                    index = index+1
                    currentSpeed = config.speeds[index].speed
                else
                    currentSpeed = config.speeds[1].speed
                    index = 1
                end
                setupScaleform("instructional_buttons")
            end

			if IsControlPressed(0, config.controls.goForward) then
                yoff = config.offsets.y
			end
			
            if IsControlPressed(0, config.controls.goBackward) then
                yoff = -config.offsets.y
			end
			
            if IsControlPressed(0, config.controls.turnLeft) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)+config.offsets.h)
			end
			
            if IsControlPressed(0, config.controls.turnRight) then
                SetEntityHeading(noclipEntity, GetEntityHeading(noclipEntity)-config.offsets.h)
			end
			
            if IsControlPressed(0, config.controls.goUp) then
                zoff = config.offsets.z
			end
			
            if IsControlPressed(0, config.controls.goDown) then
                zoff = -config.offsets.z
			end
			
            local newPos = GetOffsetFromEntityInWorldCoords(noclipEntity, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
            local heading = GetEntityHeading(noclipEntity)
            SetEntityVelocity(noclipEntity, 0.0, 0.0, 0.0)
            SetEntityRotation(noclipEntity, 0.0, 0.0, 0.0, 0, false)
            SetEntityHeading(noclipEntity, heading)
            SetEntityCoordsNoOffset(noclipEntity, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
        end
    end
end)

--==--==--==--
-- Noclip fin
--==--==--==--


local function TeleportToWaypoint()-- https://gist.github.com/samyh89/32a780abcd1eea05ab32a61985857486
    local entity = PlayerPedId()
    if IsPedInAnyVehicle(entity, false) then
        entity = GetVehiclePedIsUsing(entity)
    end
    local success = false
    local blipFound = false
    local blipIterator = GetBlipInfoIdIterator()
    local blip = GetFirstBlipInfoId(8)
    
    while DoesBlipExist(blip) do
        if GetBlipInfoIdType(blip) == 4 then
            cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector()))--GetBlipInfoIdCoord(blip)
            blipFound = true
            break
        end
        blip = GetNextBlipInfoId(blipIterator)
        Wait(0)
    end
    
    if blipFound then
        local groundFound = false
        local yaw = GetEntityHeading(entity)
        
        for i = 0, 1000, 1 do
            SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
            SetEntityRotation(entity, 0, 0, 0, 0, 0)
            SetEntityHeading(entity, yaw)
            SetGameplayCamRelativeHeading(0)
            Wait(0)
            if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then
                cz = ToFloat(i)
                groundFound = true
                break
            end
        end
        if not groundFound then
            cz = -300.0
        end
        success = true
    else
        ShowInfo('~r~Aucun Marker trouvés')
    end
    
    if success then
        SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
        SetGameplayCamRelativeHeading(0)
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
                SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
            end
        end
    end

end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

function gestionjoueurs()
	for k,v in ipairs(ServersIdSession) do
                if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(ServersIdSession, k) 
                end

                RageUI.Button("["..v.."] - "..GetPlayerName(GetPlayerFromServerId(v)), nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
			end)
			end
			end			

--==--==--==--
-- coordonne et crosshair
--==--==--==--

Admin = {
	showcoords = false,
	showcrosshair = false,
	ghostmode = false,
    godmode = false,
    showName = false,
    gamerTags = {}
}
MainColor = {
	r = 225, 
	g = 55, 
	b = 55,
	a = 255
}

function DrawTxt(text,r,z)
    SetTextColour(MainColor.r, MainColor.g, MainColor.b, 255)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0,0.4)
    SetTextDropshadow(1,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(r,z)
 end
--==--==--==--
-- coordonne fin
--==--==--==--
local Language = Config.Lang
 --------------------------------------------
 Citizen.CreateThread(function()
	while true do
		if Admin.showName then
			for k, v in ipairs(ESX.Game.GetPlayers()) do
				local otherPed = GetPlayerPed(v)

				if otherPed ~= plyPed then
					if #(GetEntityCoords(plyPed, false) - GetEntityCoords(otherPed, false)) < 5000.0 then
						Admin.gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
					else
						RemoveMpGamerTag(Admin.gamerTags[v])
						Admin.gamerTags[v] = nil
					end
				end
			end
		end

		Citizen.Wait(100)
	end
end)

 Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

local ServersIdSession = {}

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(ServersIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(ServersIdSession, GetPlayerServerId(v))
            end
        end
    end
end)


local MENU1 = {
    action = {
        '~g~Cash',
        '~b~Bank',
        '~r~Dirty',
    },
    list = 1
}
local joueurPed = GetPlayerPed(IdSelected)

RMenu.Add('admin', 'main', RageUI.CreateMenu(Config.Text[Language].SPAdmin, Config.Text[Language].Discord))
RMenu.Add('admin', 'listej', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, Config.Text[Language].SPAdmin2))
RMenu.Add('admin', 'me', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, Config.Text[Language].me))
RMenu.Add('admin', 'ban', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, Config.Text[Language].me))

RMenu.Add('admin', 'teleport', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, Config.Text[Language].Teleports))
RMenu.Add('admin', 'car', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'weapon', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, Config.Text[Language].Weapon))
RMenu.Add('admin', 'givecarzbi', RageUI.CreateSubMenu(RMenu:Get('admin', 'car'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'car2', RageUI.CreateSubMenu(RMenu:Get('admin', 'car'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'carsuper', RageUI.CreateSubMenu(RMenu:Get('admin', 'car2'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'carsport', RageUI.CreateSubMenu(RMenu:Get('admin', 'car2'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'caroffroad', RageUI.CreateSubMenu(RMenu:Get('admin', 'car2'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'bike', RageUI.CreateSubMenu(RMenu:Get('admin', 'car2'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'carcolor', RageUI.CreateSubMenu(RMenu:Get('admin', 'car'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'carneon', RageUI.CreateSubMenu(RMenu:Get('admin', 'car'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'report', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'report2', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, Config.Text[Language].Car))
RMenu.Add('admin', 'dev', RageUI.CreateSubMenu(RMenu:Get('admin', 'main'), Config.Text[Language].SPAdmin, 'Dev Tools'))
RMenu.Add('admin', 'gestj', RageUI.CreateSubMenu(RMenu:Get('admin', 'listej'), Config.Text[Language].SPAdmin, Config.Text[Language].Player ))


Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('admin', 'main'), true, true, true, function()
            
            RageUI.Button(Config.Text[Language].me2, Config.Text[Language].me, {RightLabel = "😃"},true, function()
            end, RMenu:Get('admin', 'me'))  

            RageUI.Button(Config.Text[Language].Weapon, Config.Text[Language].Weapon2, {RightLabel = "🔫"},true, function()
            end, RMenu:Get('admin', 'weapon'))

            RageUI.Button(Config.Text[Language].Admin, Config.Text[Language].Admin2, {RightLabel = "👑"},true, function()
            end, RMenu:Get('admin', 'ban')) 

            RageUI.Button('Dev Tools', 'Stop/Start ressources', {RightLabel = "🛠️"},true, function()
            end, RMenu:Get('admin', 'dev')) 




            RageUI.Button(Config.Text[Language].Listofplayers, Config.Text[Language].SPAdmin2, {RightLabel = "📃"},true, function()
            end, RMenu:Get('admin', 'listej'))

            RageUI.List(Config.Text[Language].Ped, Ped.action, Ped.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)
                if (Selected) then 
                    if Index == 1 then
                        openMenuPlayerZero()  
                        elseif Index == 2 then
                            keyped()  
 
        
        
                        end
                    end
                    Ped.list = Index;              
                    end)

            RageUI.Button(Config.Text[Language].Report, nil, {RightLabel = "❗"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("reportlist")
                RageUI.CloseAll()
                end
            end)


            RageUI.Button(Config.Text[Language].Teleports, "Teleports options", {RightLabel = "📍"},true, function()
            end, RMenu:Get('admin', 'teleport'))

            RageUI.Button(Config.Text[Language].Car, "Categories Car", {RightLabel = "🚘"},true, function()
            end, RMenu:Get('admin', 'car'))    
            
      
            
        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('admin', 'me'), true, true, true, function()

            
            RageUI.Button(Config.Text[Language].tpmarker, nil, {RightLabel = "📍"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    admin_tp_marker()
                end
            end)

            RageUI.Checkbox(Config.Text[Language].noclip, description, inforetaxio,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    inforetaxio = Checked
                    if Checked then
                        admin_no_clip()
                        notification(Config.Text[Language].SPAdmin, "Administration", "NoClipV1 : ~g~ON")
                    else
                        admin_no_clip()
                        notification(Config.Text[Language].SPAdmin, "Administration", "NoClipV1 : ~r~OFF")
                    end
                        
            end
            end)    

            
            RageUI.Checkbox(Config.Text[Language].noclipv2, description, inforetaxi,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    inforetaxi = Checked
                    if Checked then
                        noclipv2()
                        notification(Config.Text[Language].SPAdmin, "Administration", "NoClipV2 : ~g~ON")
                        TriggerEvent('sp_admin:toggleInvisibility2')
                    else
                        noclipv2()
                        notification(Config.Text[Language].SPAdmin, "Administration", "NoClipV2 : ~r~OFF")
                        TriggerEvent('sp_admin:toggleInvisibility2')
                end
            end
            end)  
        RageUI.Checkbox(Config.Text[Language].godmod, description, inforetax,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                inforetax = Checked
                if Checked then
                    TriggerEvent('sp_admin:godmod')
                else
                    TriggerEvent('sp_admin:godmod')
            end
        end
        end)  
        RageUI.Checkbox(Config.Text[Language].Crosshair, description, inforeta,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                inforeta = Checked
                if Checked then
                    Admin.showcrosshair = not Admin.showcrosshair
                    notification(Config.Text[Language].SPAdmin, "Administration", "Crosshair : ~g~ON")
                else
                    Admin.showcrosshair = not Admin.showcrosshair
                    notification(Config.Text[Language].SPAdmin, "Administration", "Crosshair : ~r~OFF")
            end
        end
        end)   
        RageUI.Checkbox(Config.Text[Language].FastSprint, description, inforet,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                inforet = Checked
                if Checked then
                    TriggerEvent('sp_admin:toggleFastSprint2')
                else
                    TriggerEvent('sp_admin:toggleFastSprint2')
            end
        end
        end)   
    
    RageUI.Checkbox(Config.Text[Language].FastSwim, description, infore,{},function(Hovered,Ative,Selected,Checked)
        if Selected then
            infore = Checked
            if Checked then
                TriggerEvent('sp_admin:toggleFastSwim2')
            else
                TriggerEvent('sp_admin:toggleFastSwim2')
        end
    end
    end) 
        
      
    RageUI.Checkbox(Config.Text[Language].SuperJump, description, jump,{},function(Hovered,Ative,Selected,Checked)
        if Selected then
            jump = Checked
            if Checked then
                TriggerEvent('sp_admin:toggleSuperJump2')
            else
                TriggerEvent('sp_admin:toggleSuperJump2')
        end
    end
    end) 

RageUI.Checkbox(Config.Text[Language].InfiniteStamina, description, inf,{},function(Hovered,Ative,Selected,Checked)
    if Selected then
        inf = Checked
        if Checked then
            TriggerEvent('sp_admin:toggleInfStamina2')
        else
            TriggerEvent('sp_admin:toggleInfStamina2')
    end
end
end) 
RageUI.Checkbox("Invisibility", description, infor,{},function(Hovered,Ative,Selected,Checked)
    if Selected then
        infor = Checked
        if Checked then
            TriggerEvent('sp_admin:toggleInvisibility2')
            notification(Config.Text[Language].SPAdmin, "Administration", "Invisibility: ~g~ON") 
        else
            TriggerEvent('sp_admin:toggleInvisibility2')
            notification(Config.Text[Language].SPAdmin, "Administration", "Invisibility : ~r~OFF") 
    end
end
end) 



RageUI.Button("Heal", nil, {RightLabel = "❤️"}, true, function(Hovered, Active, Selected)
    if (Selected) then
        ExecuteCommand("heal")
        notification(Config.Text[Language].SPAdmin, "Administration", "Heal : ~r~✔️")
end
end)

RageUI.List('Give Myself Money', MENU1.action, MENU1.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)
    if (Selected) then 
        if Index == 1 then
            admin_give_money()  
            elseif Index == 2 then
                admin_give_bank2() 
                    elseif Index == 3 then
                        admin_give_dirty2() 


                    end
                end
                MENU1.list = Index;              
                end)



    RageUI.Checkbox("Show Coordinates", description, inforetareui,{},function(Hovered,Ative,Selected,Checked)
        if Selected then
            inforetareui = Checked
            if Checked then
                Admin.showcoords = not Admin.showcoords 
                notification(Config.Text[Language].SPAdmin, "Administration", "Show Coordinates : ~g~ON")
            else
                Admin.showcoords = not Admin.showcoords 
                notification(Config.Text[Language].SPAdmin, "Administration", "Show Coordinates : ~r~OFF")
        end
    end
    end)  

    RageUI.Button("Change Appearance", nil, {RightLabel = "🙎"}, true, function(Hovered, Active, Selected)
        if (Selected) then
            changer_skin()  
            RageUI.CloseAll()
        end
    end) 

end, function()
end)   

    RageUI.IsVisible(RMenu:Get('admin', 'weapon'), true, true, true, function()

        RageUI.Checkbox("Give/Remove All Weapons", description, give,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                give = Checked
                if Checked then
                    TriggerServerEvent('sp_admin:giveweapon')
                    notification(Config.Text[Language].SPAdmin, "Administration", "Give All Weapons: ~g~ON")
                else
                TriggerServerEvent('sp_admin:removeweapon')
                notification(Config.Text[Language].SPAdmin, "Administration", "Remove All Weapons: ~g~ON") 
            end
        end
        end) 

        RageUI.Checkbox("Infinite Ammo", description, infamo,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                infamo = Checked
                if Checked then
                    TriggerEvent('sp_admin:toggleExplosiveAmmo')
                else
                    TriggerEvent('sp_admin:toggleExplosiveAmmo')
            end
        end
        end) 

        RageUI.Checkbox("Teleport Gun", description, tpgun,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                tpgun = Checked
                if Checked then
                    TriggerEvent('sp_admin:teleportGun')
                else
                    TriggerEvent('sp_admin:teleportGun')
            end
        end
        end) 

        RageUI.Checkbox("Explossive Ammo", description, exploammo,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                exploammo = Checked
                if Checked then
                    TriggerEvent('sp_admin:explossiveAmmo')
                else
                    TriggerEvent('sp_admin:explossiveAmmo')
            end
        end
        end) 
        

        
        
     
        RageUI.Checkbox("Vehicle Gun", description, guntraj,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                guntraj = Checked
                if Checked then
                    TriggerEvent('sp_admin:vehicleGun')
                else
                    TriggerEvent('sp_admin:vehicleGun')
            end
        end
        end) 
               
    
        
        end, function()
        end)   
        RageUI.IsVisible(RMenu:Get('admin', 'dev'), true, true, true, function()




            RageUI.Button("Clear Area ( Ped )", nil, {RightLabel = "📡"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
    
                    ClearAreaOfPeds(x,y,z, 50.0, 1)
                    ClearAreaOfVehicles(x,y,z, 50.0, 1)  
                    ClearAreaOfVehicles(x,y,z, 50.0, 1)  
                    
                    return x,y,z
                    
                end
            end)

            RageUI.Button("Clear Area ( Ped & Player )", nil, {RightLabel = "📡"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
          TriggerEvent('wld:delallveh')
                    ClearAreaOfPeds(x,y,z, 50.0, 1)
                    ClearAreaOfVehicles(x,y,z, 50.0, 1)  
                    ClearAreaOfVehicles(x,y,z, 50.0, 1)  
                    
                    return x,y,z
                    
                end
            end)
            
        

            RageUI.Button("Create Blips", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then           
            local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
                   
            local name = KeyboardInput("NAME", "", 100)
            local color = KeyboardInput("COLOR", "", 100)
           
            if name then
                local blip = AddBlipForCoord(x,y,z)
        
                SetBlipSprite (blip, 42)
                SetBlipDisplay(blip, 4)
                SetBlipScale  (blip, 1.0)
                SetBlipColour (blip, color)
                SetBlipAsShortRange(blip, true)
            
                BeginTextCommandSetBlipName('STRING')   
                AddTextComponentSubstringPlayerName(name)    
                EndTextCommandSetBlipName(blip)        	
                    else                  
                        RageUI.CloseAll()	
                    end			
                end
            end)
            RageUI.Button("Refresh Server", nil, {RightLabel = "⚙️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local command = 'refresh'
                    ExecuteCommand( command )
                
                end
            end)

            RageUI.Button("Debug Resource", nil, {RightLabel = "⚙️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local command = 'restart '
                    local car = KeyboardInput('Name of the script', '', 45)
                    ExecuteCommand( command .." ".. car )
                
                end
            end)
            RageUI.Button("Start Resource", nil, {RightLabel = "⚙️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local command = 'start '
                    local car = KeyboardInput('Name of the script', '', 45)
                    ExecuteCommand( command .." ".. car )
                
                end
            end)
            RageUI.Button("Stop Resource", nil, {RightLabel = "⚙️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local command = 'stop '
                    local car = KeyboardInput('Name of the script', '', 45)
                    ExecuteCommand( command .." ".. car )
                
                end
            end)

        
                end, function()
                end)  

        RageUI.IsVisible(RMenu:Get('admin', 'ban'), true, true, true, function()







            RageUI.Button("Spectate", nil, {RightLabel = "📡"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    TriggerEvent('esx_spectate:spectate')
                end
            end)


            RageUI.Checkbox("Tag Admin", description, tag,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    tag = Checked
                    if Checked then
                        ExecuteCommand("tag")
                    else
                        ExecuteCommand("tag")
                end
            end
        end)           
            RageUI.Checkbox("Players Blips", description, blips,{},function(Hovered,Ative,Selected,Checked)
                if Selected then
                    blips = Checked
                    if Checked then
                        TriggerEvent('mostraBlipsonn', source)
                    else
                        TriggerEvent('mostraBlipsofff', source)
                end
            end
        end)
        RageUI.Checkbox("Players Name", description, Name,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                Name = Checked
                if Checked then
                    ExecuteCommand("users")
                else
                    ExecuteCommand("users")
            end
        end
    end)          
 
            RageUI.Button("Revive Player ", nil, {RightLabel = "❤️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local item = KeyboardInput("ID Player", "", 100)
                    ExecuteCommand("revive ".. item)
                end
            end)          
            RageUI.Button("Ban Player", nil, {RightLabel = "⚙️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("bwh ban")
                    RageUI.CloseAll()
                end
            end)     
            RageUI.Button("Ban List", nil, {RightLabel = "⚙️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("bwh banlist")
                    RageUI.CloseAll()
                end
            end)    
            RageUI.Button("Warn Player", nil, {RightLabel = "⚙️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("bwh warn")
                    RageUI.CloseAll()
                end
            end)                                   
            RageUI.Button("Warn List", nil, {RightLabel = "⚙️"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ExecuteCommand("bwh warnlist")
                    RageUI.CloseAll()
                end
            end)    
        


        
                end, function()
                end)  



                
                                           
                        RageUI.IsVisible(RMenu:Get('admin', 'teleport'), true, true, true, function()


                            RageUI.Button("Airport", nil, {RightLabel = "✈️"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp -1038.24 -2739.27 21.0")
                                end
                            end)
                            RageUI.Button("Police Station", nil, {RightLabel = "🚔"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp 424.3 -978.08 31.71")
                                end
                            end)
                            RageUI.Button("Maze Bank", nil, {RightLabel = "🏛️"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp -73.83 -816.92 326.17")
                                end
                            end)     
                            RageUI.Button("Parking", nil, {RightLabel = "🚦"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp  244.59 -820.05 30.07")
                                end
                            end)                         
                            RageUI.Button("Mont Chiliad", nil, {RightLabel = "🏔️"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp 442.58 5571.99 781.18")	
                                end
                            end)             
                            RageUI.Button("Benny\'s", nil, {RightLabel = "🛠️"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp -225.86 -1286.75 31.3 217.2")
                                end
                            end)     
                            RageUI.Button("Unicorn", nil, {RightLabel = "🍹"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp 143.66 -1308.21 29.18")
                                end
                            end)  
                            RageUI.Button("Ballas", nil, {RightLabel = "🟣"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp 92.74 -1931.62 20.18")
                                end
                            end)       
                            RageUI.Button("Vagos", nil, {RightLabel = "🟡"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp 329.78 -2035.86 20.99")
                                end
                            end)  
                            RageUI.Button("Families", nil, {RightLabel = "🟢"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    ExecuteCommand("tp -150.81 -1567.62 34.99")
                                end
                            end)                                                       
                                end, function()
                                end)  

                                RageUI.IsVisible(RMenu:Get('admin', 'car'), true, true, true, function()


                                    RageUI.Button("Give car to database", nil, {RightLabel = "🚘"}, true, function(Hovered, Active, Selected)
                                        if (Selected) then
                                            local command = 'givecar '
                                            local car = KeyboardInput('Name of the vehcile', '', 45)
                                            ExecuteCommand( command .." ".. car )
                                        
                                        end
                                    end)


                                        RageUI.Button("Spawn Car", nil, {RightLabel = "🚘"},true, function()
                                        end, RMenu:Get('admin', 'car2'))

                                        RageUI.Button("Full Vehicle Boost", nil, {RightLabel = "🛠️"}, true, function(Hovered, Active, Selected)
                                            if (Selected) then
                                                FullVehicleBoost()
                                                ESX.ShowNotification('Full Boost : ~g~ON')
                                            end
                                        end)                  
                                        RageUI.Button("Change The Number Plate", nil, {RightLabel = "✏️"}, true, function(Hovered, Active, Selected)
                                            if (Selected) then
                                                local newname = KeyboardInput('New 8 Characters Plate.', '', 8) 
                                                SetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false) , newname)
                                            end
                                        end)      

                                        RageUI.Button("Vehicle Flip", nil, {RightLabel = "🔧"}, true, function(Hovered, Active, Selected)
                                            if (Selected) then
                                                admin_vehicle_flip()
                                            end
                                        end)  
                                       
                                        RageUI.Button("Repair Vehicle", nil, {RightLabel = "🔧"}, true, function(Hovered, Active, Selected)
                                            if (Selected) then
                                                local ped = GetPlayerPed(-1)
                                                local car = GetVehiclePedIsUsing(ped)
                                                
                                                    SetVehicleFixed(car)
                                                    SetVehicleDirtLevel(car, 0.0)
                                            end
                                        end)     
                                        RageUI.Button("Delete Vehicle", nil, {RightLabel = "✂️"}, true, function(Hovered, Active, Selected)
                                            if (Selected) then
                                              ExecuteCommand("dv")
                                            end
                                        end)   

                                        RageUI.List('Color Vehicle', Menu.action, Menu.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)
                                            if (Selected) then 
                                                if Index == 1 then
                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                    SetVehicleCustomPrimaryColour(vehicle, 255, 0, 0)
                                                    SetVehicleCustomSecondaryColour(vehicle, 255, 0, 0)	
                                                    elseif Index == 2 then
                                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                        SetVehicleCustomPrimaryColour(vehicle, 0, 255, 0)
                                                        SetVehicleCustomSecondaryColour(vehicle, 0, 255, 0)	
                                                            elseif Index == 3 then
                                                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                                SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
                                                                SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)	
                                                                    elseif Index == 4 then
                                                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                                        SetVehicleCustomPrimaryColour(vehicle, 120, 0, 109)
                                                                        SetVehicleCustomSecondaryColour(vehicle, 120, 0, 109)
                                                    
                                                                            elseif Index == 5 then
                                                                                local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)				
                                                                                SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
                                                                                SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)	
                                                                                elseif Index == 6 then
                                                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)				
                                                                                    SetVehicleCustomPrimaryColour(vehicle, 255, 255, 0)
                                                                                    SetVehicleCustomSecondaryColour(vehicle, 255, 255, 0)
                                                                                    elseif Index == 7 then
                                                                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)	
                                                                                        SetVehicleCustomPrimaryColour(vehicle, 0, 73, 255)
                                                                                        SetVehicleCustomSecondaryColour(vehicle, 0, 73, 255)
                                                        
                                    
                                    
                                                    end
                                                end
                                                   Menu.list = Index;              
                                                end)

                                            RageUI.Checkbox("Neon : ", description, Frigox,{},function(Hovered,Ative,Selected,Checked)
                                                    if Selected then
                                                        Frigox = Checked
                                                        if Checked then
                                                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                            SetVehicleNeonLightEnabled(vehicle, 0, true)
                                                            SetVehicleNeonLightEnabled(vehicle, 1, true)
                                                            SetVehicleNeonLightEnabled(vehicle, 2, true)
                                                            SetVehicleNeonLightEnabled(vehicle, 3, true)
                                                        else
                                                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                            SetVehicleNeonLightEnabled(vehicle, 0, false)
                                                            SetVehicleNeonLightEnabled(vehicle, 1, false)
                                                            SetVehicleNeonLightEnabled(vehicle, 2, false)
                                                            SetVehicleNeonLightEnabled(vehicle, 3, false)
                                                    end
                                                end
                                            end)

                                            RageUI.List('Color Neon', Menu2.action, Menu2.list, nil, {RightLabel = ""}, true, function(Hovered, Active, Selected, Index)
                                                if (Selected) then 
                                                    if Index == 1 then
                                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                        SetVehicleNeonLightsColour(vehicle, 255, 0, 0)
                                              
                                                        elseif Index == 2 then
                                                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                            SetVehicleNeonLightsColour(vehicle, 0, 255, 0)
                                                    
                                                                elseif Index == 3 then
                                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                                    SetVehicleNeonLightsColour(vehicle, 0, 0, 0)
                                                             	
                                                                        elseif Index == 4 then
                                                                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
                                                                            SetVehicleNeonLightsColour(vehicle, 120, 0, 109)
                                                                      
                                                        
                                                                                elseif Index == 5 then
                                                                                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)				
                                                                                    SetVehicleNeonLightsColour(vehicle, 255, 255, 255)
                                                                                   
                                                                                    elseif Index == 6 then
                                                                                        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)				
                                                                                        SetVehicleNeonLightsColour(vehicle, 255, 255, 0)
                                                                                       
                                                                                        elseif Index == 7 then
                                                                                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)	
                                                                                            SetVehicleNeonLightsColour(vehicle, 0, 73, 255)
                                                                                            
                                                            
                                        
                                        
                                                        end
                                                    end
                                                       Menu2.list = Index;              
                                                    end)
                                        
                         
                                        
                                        end, function()
                                        end)    
                                        RageUI.IsVisible(RMenu:Get('admin', 'car2'), true, true, true, function()

                                            RageUI.Button("Choose a vehicule", nil, {RightLabel = ">>"}, true, function(Hovered, Active, Selected)
                                                if (Selected) then
                                                    carkeyspawn()	
                                                end
                                            end)  
                                            

                                            RageUI.Button("Super", nil, {RightLabel = "🚘"},true, function()
                                            end, RMenu:Get('admin', 'carsuper'))
    
                                            RageUI.Button("Sports / Classics", nil, {RightLabel = "🚘"},true, function()
                                            end, RMenu:Get('admin', 'carsport'))
                                    
                                            RageUI.Button("Off Road", nil, {RightLabel = "🚚"},true, function()
                                            end, RMenu:Get('admin', 'caroffroad'))

                                            RageUI.Button("Bike", nil, {RightLabel = "🏍️"},true, function()
                                            end, RMenu:Get('admin', 'bike'))
                                            
                                            
                                            end, function()
                                            end)  
                                                                            
                                            RageUI.IsVisible(RMenu:Get('admin', 'carsuper'), true, true, true, function()

                                                RageUI.Button("Adder", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                               
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car adder")
                                                    end
                                                end)    
                                                RageUI.Button("cheetah", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                    
                                                        Wait(20)                                                 
                                                        ExecuteCommand("car cheetah")
                                                    end
                                                end)        
                                                RageUI.Button("cyclone", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car cyclone")
                                                    end
                                                end)      
                                                RageUI.Button("t20", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                      
                                                        Wait(20)                                                    
                                                        ExecuteCommand("car t20")
                                                    end
                                                end)       
                                                RageUI.Button("osiris", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                  
                                                        Wait(20)                                                    
                                                        ExecuteCommand("car osiris")
                                                    end
                                                end)         
                                                RageUI.Button("fmj", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                      
                                                        Wait(20)                                                   
                                                        ExecuteCommand("car fmj")
                                                    end
                                                end)                                                                                                     
                                                RageUI.Button("entityxf", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                     
                                                        Wait(20)                                                    
                                                        ExecuteCommand("car entityxf")
                                                    end
                                                end)  
                                                RageUI.Button("turismor", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                 
                                                        Wait(20)                                                      
                                                        ExecuteCommand("car turismor")
                                                    end
                                                end)  
                                                RageUI.Button("infernus", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                  
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car infernus")
                                                    end
                                                end)  
                                            end, function()
                                            end) 

                                             RageUI.IsVisible(RMenu:Get('admin', 'carsport'), true, true, true, function()

                                                RageUI.Button("alpha", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                         
                                                        Wait(20)                                                   
                                                        ExecuteCommand("car alpha")
                                                    end
                                                end)    
                                                RageUI.Button("bestiagts", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car bestiagts")
                                                    end
                                                end)        
                                                RageUI.Button("coquette", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car coquette")
                                                    end
                                                end)      
                                                RageUI.Button("furoregt", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car furoregt")
                                                    end
                                                end)       
                                                RageUI.Button("jester", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car jester")
                                                    end
                                                end)         
                                                RageUI.Button("penumbra", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car penumbra")
                                                    end
                                                end)                                                                                                     
                                                RageUI.Button("pigalle", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car pigalle")
                                                    end
                                                end)  
                                                RageUI.Button("revolter", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car revolter")
                                                    end
                                                end)  
                                                RageUI.Button("gt500", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                    if (Selected) then
                                                        ExecuteCommand("dv")                                                      
                                                        Wait(20)                                                     
                                                        ExecuteCommand("car gt500")
                                                    end
                                                end)                                                 
                                                
                                                end, function()
                                                end)     
                                                RageUI.IsVisible(RMenu:Get('admin', 'caroffroad'), true, true, true, function()

                                                    RageUI.Button("bfinjection", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car bfinjection")
                                                        end
                                                    end)    
                                                    RageUI.Button("bifta", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car bifta")
                                                        end
                                                    end)        
                                                    RageUI.Button("brawler", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car brawler")
                                                        end
                                                    end)      
                                                    RageUI.Button("dubsta3", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car dubsta3")
                                                        end
                                                    end)       
                                                    RageUI.Button("guardian", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car guardian")
                                                        end
                                                    end)         
                                                    RageUI.Button("monster", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car monster")
                                                        end
                                                    end)                                                                                                     
                                                    RageUI.Button("riata", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car riata")
                                                        end
                                                    end)  
                                                    RageUI.Button("trophytruck", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car trophytruck")
                                                        end
                                                    end)  
                                                    RageUI.Button("rebel2", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                        if (Selected) then
                                                            ExecuteCommand("dv")                                                      
                                                            Wait(20)                                                     
                                                            ExecuteCommand("car rebel2")
                                                        end
                                                    end)                                                 
                                                    
                                                    end, function()
                                                    end)    
                                                    RageUI.IsVisible(RMenu:Get('admin', 'bike'), true, true, true, function()

                                                        RageUI.Button("sanchez", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                            if (Selected) then
                                                                ExecuteCommand("dv")                                                      
                                                                Wait(20)                                                    
                                                                ExecuteCommand("car sanchez")
                                                            end
                                                        end)    
                                                        RageUI.Button("manchez", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                            if (Selected) then
                                                                ExecuteCommand("dv")                                                      
                                                                Wait(20)                                                    
                                                                ExecuteCommand("car manchez")
                                                            end
                                                        end)        
                                                  
                                                        RageUI.Button("bati", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                            if (Selected) then
                                                                ExecuteCommand("dv")                                                      
                                                                Wait(20)                                                    
                                                                ExecuteCommand("car bati")
                                                            end
                                                        end)       
                                                        RageUI.Button("hakuchou", nil, {RightLabel = ">"}, true, function(Hovered, Active, Selected)
                                                            if (Selected) then
                                                                ExecuteCommand("dv")                                                      
                                                                Wait(20)                                                    
                                                                ExecuteCommand("car hakuchou")
                                                            end
                                                        end)                                               
                                                        
                                                        end, function()
                                                        end)                                                                                                                                                                                                                             
  
    	RageUI.IsVisible(RMenu:Get('admin', 'listej'), true, true, true, function()

            
              for k,v in ipairs(ServersIdSession) do
                if GetPlayerName(GetPlayerFromServerId(v)) == "**OFFLINE**" then table.remove(ServersIdSession, k) end
                RageUI.Button("[ID : "..v.."~s~] - ~r~"..GetPlayerName(GetPlayerFromServerId(v)), nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        IdSelected = v
                    end
                end, RMenu:Get('admin', 'gestj'))
            end


    	
       end, function()
        end)
  
        RageUI.IsVisible(RMenu:Get('admin', 'gestj'), true, true, true, function()	    
           
        RageUI.Button("Steam Name : ".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .." [ID : "..IdSelected.."]", nil, {}, true, function(Hovered, Active, Selected)
        end)

        RageUI.Button("Send Message", nil, {}, true, function(Hovered, Active, Selected, target)
            if (Selected) then
        local reponse = KeyboardInput('~c~Enter message here :', nil, 30)
        local reponseReport = GetOnscreenKeyboardResult(reponse)
        if reponseReport == "" then
            notification("~r~Admin ~r~ You did not provide a message")
        else
            if reponseReport then
                notification("The message : ~b~"..reponseReport.."~s~ was sent to ~r~"..GetPlayerName(GetPlayerFromServerId(IdSelected))) 
                TriggerServerEvent("spadmin:message", IdSelected, "~r~Staff~s~\n"..reponseReport)
            end
        end
    end
end)

RageUI.Button("Bring", nil, {}, true, function(Hovered, Active, Selected, target)
    if (Selected) then
        local playerId = GetPlayerFromServerId(IdSelected)
        ExecuteCommand("bring "..playerId.." "..IdSelected)
        print("bring "..playerId.." "..IdSelected)
        ESX.ShowNotification('~b~You have TP ~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..' to you')
    end
end)

        RageUI.Button("Get TP ", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(IdSelected))))
                ESX.ShowNotification('~b~You just TP to~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..'')
            end
        end)

        RageUI.Button("Kill", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local playerId = GetPlayerFromServerId(IdSelected)
                ExecuteCommand("slay admin ".. IdSelected)  
                print("slay admin ".. IdSelected)  
                ESX.ShowNotification('~b~You have Kill~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..'')
            end
        end)
 

        RageUI.Button("~g~Revive", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local playerId = GetPlayerFromServerId(IdSelected)
                ExecuteCommand("revive ".. IdSelected)
                Wait(100)
                SetEntityHealth(GetPlayerPed(playerId), 200)         
            end
        end)


        RageUI.Checkbox("Freeze / UnFreeze", description, Frigo,{},function(Hovered,Ative,Selected,Checked)
            if Selected then
                Frigo = Checked
                if Checked then
                    ESX.ShowNotification("~r~Player Freeze ("..GetPlayerName(GetPlayerFromServerId(IdSelected))..")")
                    ExecuteCommand("freeze admin ".. IdSelected)
                else
                    ESX.ShowNotification("~r~Player Unfreeze ("..GetPlayerName(GetPlayerFromServerId(IdSelected))..")")
                    ExecuteCommand("freeze admin ".. IdSelected)
                end
            end
        end)
   


    RageUI.Button("Give item", nil, {}, true, function(Hovered, Active, Selected)
        if (Selected) then
            local item = KeyboardInput("Item", "", 10)
            local amount = KeyboardInput("Amout", "", 10)
            if item and amount then
                ExecuteCommand("giveitem "..IdSelected.. " " ..item.. " " ..amount)            	
            else                  
                RageUI.CloseAll()	
            end			
        end
    end)   




    RageUI.Button("Give Weapon", nil, {}, true, function(Hovered, Active, Selected)
        if (Selected) then           
   local weapon = KeyboardInput("weapon", "weapon_", 100)
    local ammo = KeyboardInput("clip", "", 100)
    if weapon and ammo then
        ExecuteCommand("giveweapon "..IdSelected.. " " ..weapon.. " " ..ammo)        	
            else                  
                RageUI.CloseAll()	
            end			
        end
    end)      

        RageUI.Button("Jail", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then           
       local time = KeyboardInput("time", "", 100)
        local reason = KeyboardInput("reason", "", 100)
        if time and reason then
            ExecuteCommand("jail "..IdSelected.. " " ..time.. " " ..reason)        	
                else                  
                    RageUI.CloseAll()	
                end			
            end
        end)   
        RageUI.Button("UnJail", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local playerId = GetPlayerFromServerId(IdSelected)
                ExecuteCommand("unjail ".. IdSelected)
            end
        end)
        RageUI.Button("Clear Inventory", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local playerId = GetPlayerFromServerId(IdSelected)
                ExecuteCommand("clearinventory ".. IdSelected)
                print("clearinventory ".. IdSelected)
            end
        end)

        RageUI.Button("Clear Weapon", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local playerId = GetPlayerFromServerId(IdSelected)
                ExecuteCommand("clearloadout "..IdSelected)
            end
        end)
  
        RageUI.Button("Setjob Player", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local job = KeyboardInput("Job", "", 10)
                local grade = KeyboardInput("Grade ", "", 10)
                if job and grade then
                    ExecuteCommand("setjob "..IdSelected.. " " ..job.. " " ..grade)                  
                else           
                    RageUI.CloseAll()	
                end	
            end
        end)
        RageUI.Button("Setjob2 Player", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local job = KeyboardInput("Job", "", 10)
                local grade = KeyboardInput("Grade ", "", 10)
                if job and grade then
                    ExecuteCommand("setjob2 "..IdSelected.. " " ..job.. " " ..grade)                  
                else           
                    RageUI.CloseAll()	
                end	
            end
        end)       
        RageUI.Button("Setjob3 Player", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local job = KeyboardInput("Job", "", 10)
                local grade = KeyboardInput("Grade ", "", 10)
                if job and grade then
                    ExecuteCommand("setjob3 "..IdSelected.. " " ..job.. " " ..grade)                  
                else           
                    RageUI.CloseAll()	
                end	
            end
        end)   
        RageUI.Button("Setorg Player", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local job = KeyboardInput("org", "", 10)
                local grade = KeyboardInput("Grade ", "", 10)
                if job and grade then
                    ExecuteCommand("setorg "..IdSelected.. " " ..job.. " " ..grade)                  
                else           
                    RageUI.CloseAll()	
                end	
            end
        end)            
        RageUI.Button("Spectate ~s~", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
				local playerId = GetPlayerFromServerId(IdSelected)
                    SpectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
                end
            end)
        RageUI.Button("~y~Crash", nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local playerId = GetPlayerFromServerId(IdSelected)
                ExecuteCommand("crash admin ".. IdSelected)
            end
        end) 
        RageUI.Button("~o~Kick", nil, {}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    ESX.ShowNotification('~b~You just kick ~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..'! No return possible .')
                Citizen.Wait(3500) 
                    TriggerServerEvent('haciadmin:kickjoueur', IdSelected)
                end
            end)
               			
       end, function()
        end)
            Citizen.Wait(0)
        end
    end)

    function fam1()
        local j1 = PlayerId()
            local p1 = GetHashKey('g_m_y_famca_01')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end
function fam2()
    local j1 = PlayerId()
        local p1 = GetHashKey('g_f_y_families_01')
        RequestModel(p1)
        while not HasModelLoaded(p1) do
            Wait(100)
            end
            SetPlayerModel(j1, p1)
            SetModelAsNoLongerNeeded(p1)
end
function ped16()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_cat_01')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end

function ped18()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_cormorant')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end

function ped19()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_cow')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end

function ped20()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_coyote')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end

function ped21()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_crow')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end
function ped26()
    local j1 = PlayerId()
        local p1 = GetHashKey('a_c_hen')
        RequestModel(p1)
        while not HasModelLoaded(p1) do
            Wait(100)
            end
            SetPlayerModel(j1, p1)
            SetModelAsNoLongerNeeded(p1)
end

function ped25()
    local j1 = PlayerId()
        local p1 = GetHashKey('a_c_humpback')
        RequestModel(p1)
        while not HasModelLoaded(p1) do
            Wait(100)
            end
            SetPlayerModel(j1, p1)
            SetModelAsNoLongerNeeded(p1)
end
function ped22()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_pigeon')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end

function ped23()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_dolphin')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end

function ped24()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_fish')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end

	function ped15()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_boar')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end
    function monkeyped()
        local j1 = PlayerId()
            local p1 = GetHashKey('a_c_chimp')
            RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
                end
                SetPlayerModel(j1, p1)
                SetModelAsNoLongerNeeded(p1)
end

    local fastSwim = false
    local fastSprint = false
    local superJump = false
 --------------------------------------------
 function openMenuPlayerZero()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0


        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
        end)
        end)
        end)
end
 function keyped()
    local j1 = PlayerId()
    local newped = KeyboardInput('u_m_y_proldriver_01 / u_m_y_staggrm_01 / u_m_m_streetart_01', '', 45)
    local p1 = GetHashKey(newped)
    RequestModel(p1)
    while not HasModelLoaded(p1) do
      Wait(100)
     end
     SetPlayerModel(j1, p1)
     SetModelAsNoLongerNeeded(p1)	
     end
function carkeyspawn()
    local car = KeyboardInput('Name', '', 45)
    ExecuteCommand("car ".. car)

end    



 RegisterNetEvent("sp_admin:toggleInvisibility2")
AddEventHandler("sp_admin:toggleInvisibility2", function()
  invisibility = not invisibility
  SetEntityVisible(GetPlayerPed(-1), not invisibility, 0)
  SetForcePedFootstepsTracks(invisibility) -- TODO: all players ?!
  if invisibility then
    
  else
    
  end
end) 
 RegisterNetEvent("sp_admin:toggleInfStamina2")
 AddEventHandler("sp_admin:toggleInfStamina2", function()
   infStamina = not infStamina
   if infStamina then
    notification(Config.Text[Language].SPAdmin, "Administration", "Infinite Stamina: ~g~ON") 
   else
    notification(Config.Text[Language].SPAdmin, "Administration", "Infinite Stamina : ~r~OFF") 
   end
 end)
 RegisterNetEvent("sp_admin:toggleFastSwim2")
AddEventHandler("sp_admin:toggleFastSwim2", function()
  fastSwim = not fastSwim
  if fastSwim then
    notification(Config.Text[Language].SPAdmin, "Administration", "Fast Swim : ~g~ON") 
    SetSwimMultiplierForPlayer(PlayerId(), 1.49)
  else
    notification(Config.Text[Language].SPAdmin, "Administration", "Fast Swim : ~r~OFF") 
    SetSwimMultiplierForPlayer(PlayerId(), 1.0)
  end
end)
 RegisterNetEvent("sp_admin:toggleSuperJump2")
 AddEventHandler("sp_admin:toggleSuperJump2", function()
   superJump = not superJump
   if superJump then
    notification(Config.Text[Language].SPAdmin, "Administration", "Super Jump : ~g~ON") 
   else
    notification(Config.Text[Language].SPAdmin, "Administration", "Super Jump : ~r~OFF") 
   end
 end)
 Citizen.CreateThread(function()

    while true do
      Citizen.Wait(0)
  
      if infStamina then
        RestorePlayerStamina(source, 1.0)
      end
  
      if neverWanted then
          SetPlayerWantedLevel(PlayerId(), 0, false)
          SetPlayerWantedLevelNow(PlayerId(), false)
      end
  
      if superJump then
        SetSuperJumpThisFrame(PlayerId())
      end
    end
  
  end)
 RegisterNetEvent("sp_admin:toggleFastSprint2")
AddEventHandler("sp_admin:toggleFastSprint2", function()
  fastSprint = not fastSprint
  if fastSprint then
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    notification(Config.Text[Language].SPAdmin, "Administration", "Fast Sprint : ~g~ON") 
  else
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    notification(Config.Text[Language].SPAdmin, "Administration", "Fast Sprint : ~r~OFF") 
  end
end)
 local noclip = false
 local noclip_speed = 1.0
 function admin_no_clip()
    noclip = not noclip
    local ped = GetPlayerPed(-1)
    if noclip then -- activé
      SetEntityInvincible(ped, true)
      SetEntityVisible(ped, false, false)
    else -- désactivé
      SetEntityInvincible(ped, false)
      SetEntityVisible(ped, true, false)
    end
  end
  function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
    return x,y,z
  end
  function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
    local pitch = GetGameplayCamRelativePitch()
  
    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)
  
    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
      x = x/len
      y = y/len
      z = z/len
    end
  
    return x,y,z
  end
  function isNoclip()
    return noclip
  end
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if noclip then
        local ped = GetPlayerPed(-1)
        local x,y,z = getPosition()
        local dx,dy,dz = getCamDirection()
        local speed = noclip_speed
  
        -- reset du velocity
        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
  
        -- aller vers le haut
        if IsControlPressed(0,32) then -- MOVE UP
          x = x+speed*dx
          y = y+speed*dy
          z = z+speed*dz
        end
  
        -- aller vers le bas
        if IsControlPressed(0,269) then -- MOVE DOWN
          x = x-speed*dx
          y = y-speed*dy
          z = z-speed*dz
        end
  
        SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
      end
    end
  end)
  RegisterNetEvent('sp_admin:godmod')
  AddEventHandler('sp_admin:godmod', function()
    godmode()
  end)
 function godmode()
 Admin.godmode = not Admin.godmode
 if Admin.godmode then
 SetEntityInvincible(PlayerPedId(), true)
     notification(Config.Text[Language].SPAdmin, "Administration", "GodMod : ~g~ON")  
 else
 SetEntityInvincible(PlayerPedId(), false)
 notification(Config.Text[Language].SPAdmin, "Administration", "GodMod : ~r~OFF")
 end
end

 function noclipv2()
    noclipActive = not noclipActive

    if IsPedInAnyVehicle(PlayerPedId(), false) then
        noclipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
    else
        noclipEntity = PlayerPedId()
        
    end
    SetEntityCollision(noclipEntity, not noclipActive, not noclipActive)
    SetVehicleRadioEnabled(noclipEntity, not noclipActive) 
end


function FullVehicleBoost()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		SetVehicleModKit(vehicle, 0)
		SetVehicleMod(vehicle, 14, 0, true)
		SetVehicleNumberPlateTextIndex(vehicle, 5)
		ToggleVehicleMod(vehicle, 18, true)
		SetVehicleModColor_2(vehicle, 5, 0)
		SetVehicleExtraColours(vehicle, 111, 111)
		SetVehicleWindowTint(vehicle, 2)
		ToggleVehicleMod(vehicle, 22, true)
		SetVehicleMod(vehicle, 23, 11, false)
		SetVehicleMod(vehicle, 24, 11, false)
		SetVehicleWheelType(vehicle, 120)
		SetVehicleWindowTint(vehicle, 3)
		ToggleVehicleMod(vehicle, 20, true)
		SetVehicleTyreSmokeColor(vehicle, 0, 0, 0)
		LowerConvertibleRoof(vehicle, true)
		SetVehicleIsStolen(vehicle, false)
		SetVehicleIsWanted(vehicle, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetCanResprayVehicle(vehicle, true)
		SetPlayersLastVehicle(vehicle)
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleTyresCanBurst(vehicle, false)
		SetVehicleWheelsCanBreak(vehicle, false)
		SetVehicleCanBeTargetted(vehicle, false)
		SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
		SetVehicleHasStrongAxles(vehicle, true)
		SetVehicleDirtLevel(vehicle, 0)
		SetVehicleCanBeVisiblyDamaged(vehicle, false)
		IsVehicleDriveable(vehicle, true)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleStrong(vehicle, true)
		RollDownWindow(vehicle, 0)
		RollDownWindow(vehicle, 1)
		
		SetPedCanBeDraggedOut(PlayerPedId(), false)
		SetPedStayInVehicleWhenJacked(PlayerPedId(), true)
		SetPedRagdollOnCollision(PlayerPedId(), false)
		ResetPedVisibleDamage(PlayerPedId())
		ClearPedDecorations(PlayerPedId())
		SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
	end
end

function admin_give_money()
	money = KeyboardInput('CASH', '', 120)
	TriggerServerEvent('sp_admin:giveCash', money)
end

function admin_give_bank2()
	KeyboardInput('BANK', '', 120)
	inputmoneybank = 1
end
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputmoneybank == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputmoneybank = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoneybank = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoneybank = 0
			end
		end
		if inputmoneybank == 2 then
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('sp_admin:giveBank', money)
			inputmoneybank = 0
		end
	end
end)
RegisterNetEvent("admin:Freeze")
AddEventHandler("admin:Freeze",function()

    FreezeEntityPosition(GetPlayerPed(-1), not Freeze)
    Freeze = not Freeze
end)

function admin_give_dirty2()
	KeyboardInput('DIRTY', '', 120)
	inputmoneydirty = 1
end
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if inputmoneydirty == 1 then
			if UpdateOnscreenKeyboard() == 3 then
				inputmoneydirty = 0
			elseif UpdateOnscreenKeyboard() == 1 then
					inputmoneydirty = 2
			elseif UpdateOnscreenKeyboard() == 2 then
				inputmoneydirty = 0
			end
		end
		if inputmoneydirty == 2 then
			local repMoney = GetOnscreenKeyboardResult()
			local money = tonumber(repMoney)
			
			TriggerServerEvent('sp_admin:giveDirtyMoney', money)
			inputmoneydirty = 0
		end
	end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

function admin_vehicle_flip()

    local player = GetPlayerPed(-1)
    posdepmenu = GetEntityCoords(player)
    carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
    if carTargetDep ~= nil then
            platecarTargetDep = GetVehicleNumberPlateText(carTargetDep)
    end
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    playerCoords = playerCoords + vector3(0, 2, 0)
  
    SetEntityCoords(carTargetDep, playerCoords)
    

end
function changer_skin()
	TriggerEvent('esx_skin:openSaveableMenu', source)
   notification(Config.Text[Language].SPAdmin, "Administration", "Change Appearance")
end
RegisterNetEvent("admin:admin_tp_marker")
AddEventHandler("admin:admin_tp_marker",function()
    admin_tp_marker()
end)
function admin_tp_marker()
    local WaypointHandle = GetFirstBlipInfoId(8)
  
    if DoesBlipExist(WaypointHandle) then
      local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
  
      for height = 1, 1000 do
        SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
  
        local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
  
        if foundGround then
          SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
  
          break
        end
  
        Citizen.Wait(0)
      end
  
      notification("Téléportation", "Administration", "Téléportation ~g~Effectuée")
    else
      notification("Téléportation", "Administration", "Aucun ~r~Marqueur")
    end
  end

  function notification(title, subject, msg)

    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(-1))
    
    ESX.ShowAdvancedNotification(title, subject, msg, mugshotStr, 1)
    
    UnregisterPedheadshot(mugshot)
    
  end
  local radarEsteso = false
local mostrablip = false
local mostranomi = false

RegisterNetEvent('mostraBlipsonn')
AddEventHandler('mostraBlipsonn', function()
    mostrablip = not mostrablip
    if mostrablip then
        mostrablip = true
        -- notifica blips abilitati
    end
end)
RegisterNetEvent('sp_admin:CheckAdminOnline')
AddEventHandler('sp_admin:CheckAdminOnline', function()
	RageUI.Visible(RMenu:Get('admin', 'main'), not RageUI.Visible(RMenu:Get('admin', 'main')))
end)
RegisterNetEvent('mostraBlipsofff')
AddEventHandler('mostraBlipsofff', function()
    mostrablip = not mostrablip
    if mostrablip then
        mostrablip = false
        -- notifica blips disabilitati
    end
end)

Citizen.CreateThread(function()
    while true do
    Wait(1)
    -- controllo del giocatore, se esiste e ha un id.
    for i = 0, 255 do
        if NetworkIsPlayerActive(i) and GetPlayerPed(i) ~= GetPlayerPed(-1) then
            ped = GetPlayerPed(i)
            blip = GetBlipFromEntity(ped)
            -- Crea il nome sulla testa del giocatore
            idTesta = Citizen.InvokeNative(0xBFEFE3321A3F5015, ped, GetPlayerName(i), false, false, "", false)

            if mostranomi then
                Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 0, true) -- Aggiunge il nome de giocatore sulla testa
                -- Mostra se il giocatore sta parlando.
                if NetworkIsPlayerTalking(i) then
                    Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, true)
                else
                    Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, false)
                end
            else -- Rimuove tutti i blip se mostranomi = false
                Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, false)
                Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 0, false)
            end

            if mostrablip then
                if not DoesBlipExist(blip) then -- Con questo aggiungo i blip sulla testa dei giocatori.
                    blip = AddBlipForEntity(ped)
                    SetBlipSprite(blip, 1) -- imposto il blip sulla posizione "blip" con l'id 1
                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) -- Aggiunge effettivamente il blip
                else -- se il blip esiste, allora lo aggiorno
                    veh = GetVehiclePedIsIn(ped, false) -- questo lo uso per aggiornare ogni volta il veicolo su cui il ped è salito
                    blipSprite = GetBlipSprite(blip)
                    if not GetEntityHealth(ped) then -- controllo se il giocatore è morto o no
                        if blipSprite ~= 274 then
                            SetBlipSprite(blip, 274)
                            Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                        end
                    elseif veh then -- controllo se il giocatore è su un veicolo.
                        calsseVeicolo = GetVehicleClass(veh)
                        modelloVeicolo = GetEntityModel(veh)
                        if calsseVeicolo == 15 then -- La classe 15 indica un veicolo volante
                            if blipSprite ~= 422 then -- controllo se il blip non è il 422, ovvero l'aereo
                                SetBlipSprite(blip, 422) -- se true lo imposto.
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                            end
                        elseif calsseVeicolo == 16 then -- controllo se il ped sta su un aereo
                            if modelloVeicolo == GetHashKey("besra") or modelloVeicolo == GetHashKey("hydra") or modelloVeicolo == GetHashKey("lazer") then -- controllo se il modello è un jet militare
                                if blipSprite ~= 424 then
                                    SetBlipSprite(blip, 424)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                                end
                            elseif blipSprite ~= 423 then
                                SetBlipSprite(blip, 423)
                                Citizen.InvokeNative (0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                            end
                        elseif calsseVeicolo == 14 then -- boat
                            if blipSprite ~= 427 then
                                SetBlipSprite(blip, 427)
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                            end
                        elseif modelloVeicolo == GetHashKey("insurgent") or modelloVeicolo == GetHashKey("insurgent2") or modelloVeicolo == GetHashKey("limo2") then
                                if blipSprite ~= 426 then
                                    SetBlipSprite(blip, 426)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                                end
                            elseif modelloVeicolo == GetHashKey("rhino") then -- tank
                                if blipSprite ~= 421 then
                                    SetBlipSprite(blip, 421)
                                    Citizen.InvokeNative(0x5FBCA48327B914DF, blip, false) -- Aggiunge effettivamente il blip
                                end
                            elseif blipSprite ~= 1 then -- default blip
                                SetBlipSprite(blip, 1)
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) -- Aggiunge effettivamente il blip
                            end
                            -- Show number in case of passangers
                            passengers = GetVehicleNumberOfPassengers(veh)
                            if passengers then
                                if not IsVehicleSeatFree(veh, -1) then
                                    passengers = passengers + 1
                                end
                                ShowNumberOnBlip(blip, passengers)
                            else
                                HideNumberOnBlip(blip)
                            end
                        else
                            -- Se nessuno degli else per le auto viene verificato, allora setto il blip normale.
                            HideNumberOnBlip(blip)
                            if blipSprite ~= 1 then -- il blip default è 1
                                SetBlipSprite(blip, 1)
                                Citizen.InvokeNative(0x5FBCA48327B914DF, blip, true) -- Aggiunge effettivamente il blip
                            end
                        end
                        SetBlipRotation(blip, math.ceil(GetEntityHeading(veh))) -- con questo aggiorno la rotazione a seconda del veicolo
                        SetBlipNameToPlayerName(blip, i) -- aggirono il blip del giocatore
                        SetBlipScale(blip, 0.85) -- dimensione
                        -- se il menù con la mappa grande è aperto, allora setto il blip con un alpha massimo
                        -- con questo poi controllo la distanza dal giocatore per il nome sulla testa
                        if IsPauseMenuActive() then
                            SetBlipAlpha(blip, 255)
                        else -- se la prima non è confermata
                            x1, y1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true)) -- non ho messo la z perché non mi serve
                            x2, y2 = table.unpack(GetEntityCoords(GetPlayerPed(i), true)) -- uguale qua sotto
                            distanza = (math.floor(math.abs(math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))) / -1)) + 900
                            -- lo ho fatto così perché si....
                            if distanza < 0 then
                                distanza = 0
                            elseif distanza > 255 then
                                distanza = 255
                            end
                            SetBlipAlpha(blip, distanza)
                        end
                    end
                else
                    RemoveBlip(blip)
                end
            end
        end
    end
end)

local ServersIdSession = {}

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(ServersIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(ServersIdSession, GetPlayerServerId(v))
            end
        end
    end
end)
RegisterNetEvent('sp_admin:openlistjoueur')
AddEventHandler('sp_admin:openlistjoueur', function()
	RageUI.Visible(RMenu:Get('admin', 'main'), not RageUI.Visible(RMenu:Get('admin', 'main')))
end)

RegisterNetEvent("sp_admin:openreport")
AddEventHandler("sp_admin:openreport",function()
    RageUI.Visible(RMenu:Get('admin', 'report'), not RageUI.Visible(RMenu:Get('admin', 'report')))
end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                if group == true then 
                    if IsControlJustPressed(1,57) then
                        TriggerEvent('sp_admin:menuv')
                    end
                end
       		 end
    end)   
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(1,Config.KeyOpenMenuAdmin) then
                    ESX.TriggerServerCallback('sp_admin:getUsergroup', function(group)
                        playergroup = group
                        if playergroup == Config.Group then
                            superadmin = true
                            RageUI.Visible(RMenu:Get('admin', 'main'), not RageUI.Visible(RMenu:Get('admin', 'main')))
                        else
                            superadmin = false
                        end
                    end)
                end 
            end
        end)    
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
        if IsControlJustPressed(1,Config.KeyNoClip) then
                ESX.TriggerServerCallback('sp_admin:getUsergroup', function(group)
                    playergroup = group
                    if playergroup == Config.Group then
                        superadmin = true
                        if Config.KeyNoClipV1 then
                            admin_no_clip()
                            notification(Config.Text[Language].SPAdmin, "Administration", "NoClipV1 : ~r~OFF")
                        end 
                        if Config.KeyNoClipV2 then
                            noclipv2()
                            TriggerEvent('sp_admin:toggleInvisibility2')
                            notification(Config.Text[Language].SPAdmin, "Administration", "NoClipV2 : ~g~ON/~r~OFF")
                        end 
                    
                    else
                        superadmin = false
                    end
                end)
            end 
        end
    end)        
         
Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                if group == true then 
                    if IsControlPressed(1, 19) and IsControlJustPressed(1, 26) then
                        TeleportToWaypoint() 
                    end
                end
       		 end
    end)
    Citizen.CreateThread(function()
        while true do
          Citizen.Wait(0)
          if noclip then
            local ped = GetPlayerPed(-1)
            local x,y,z = getPosition()
            local dx,dy,dz = getCamDirection()
            local speed = noclip_speed
      
            -- reset du velocity
            SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
      
            -- aller vers le haut
            if IsControlPressed(0,32) then -- MOVE UP
              x = x+speed*dx
              y = y+speed*dy
              z = z+speed*dz
            end
      
            -- aller vers le bas
            if IsControlPressed(0,269) then -- MOVE DOWN
              x = x-speed*dx
              y = y-speed*dy
              z = z-speed*dz
            end
      
            SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
          end
        end
      end)
          Citizen.CreateThread(function()
          while true do
              if Admin.showcoords then
                  x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
                  roundx=tonumber(string.format("%.2f",x))
                  roundy=tonumber(string.format("%.2f",y))
                  roundz=tonumber(string.format("%.2f",z))
                  DrawTxt("~b~X:~s~ "..roundx,0.05,0.00)
                  DrawTxt("     ~r~Y:~s~ "..roundy,0.11,0.00)
                  DrawTxt("        ~g~Z:~s~ "..roundz,0.17,0.00)
                  DrawTxt("              ~p~Heading:~s~ "..GetEntityHeading(PlayerPedId()),0.21,0.00)
              end
              if Admin.showcrosshair then
                  DrawTxt('+', 0.495, 0.484, 1.0, 0.3, MainColor)
              end
              Citizen.Wait(0)
          end
      end)

function bulletCoords()
    local result, coord = GetPedLastWeaponImpactCoord(GetPlayerPed(-1))
    return coord
end
      
function getEntity(player)
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

function getGroundZ(x, y, z)
    local result, groundZ = GetGroundZFor_3dCoord(x + 0.0, y + 0.0, z + 0.0, Citizen.ReturnResultAnyway())
    return groundZ
end

      RegisterNetEvent("sp_admin:toggleExplosiveAmmo")
      AddEventHandler("sp_admin:toggleExplosiveAmmo", function()
        infiniteAmmo = not infiniteAmmo
        if infiniteAmmo then
            notification(Config.Text[Language].SPAdmin, "Administration", "Infinite Ammo : ~g~ON") 
        else
          notification(Config.Text[Language].SPAdmin, "Administration", "Infinite Ammo : ~r~OFF") 
        end
      end) 
      

      Citizen.CreateThread(function() -- Teleport Gun
        while true do
          Citizen.Wait(0)
      
          if teleportGun then
            local x,y,z = table.unpack(bulletCoords())
            if x ~= 0 and y ~= 0 and z ~= 0 then
              SetEntityCoords(GetPlayerPed(-1), x,y,z)
            end
          end
        end
      end)

      RegisterNetEvent("sp_admin:teleportGun")
      AddEventHandler("sp_admin:teleportGun", function()
        teleportGun = not teleportGun
        if teleportGun then
            notification(Config.Text[Language].SPAdmin, "Administration", "Teleport Gun : ~g~ON") 
        else
          notification(Config.Text[Language].SPAdmin, "Administration", "Teleport Gun : ~r~OFF") 
        end
      end) 

      Citizen.CreateThread(function() -- Explosive Ammo
        while true do
          Citizen.Wait(0)
      
          if explossiveAmmo then
            SetExplosiveAmmoThisFrame(PlayerId())
            local x,y,z = table.unpack(bulletCoords())
            if x ~= 0 and y ~= 0 and z ~= 0 then
              AddOwnedExplosion(GetPlayerPed(-1), x, y, z, explosionType, 20.0, true, false, 0.0)
            end
          end
        end
      end)

      RegisterNetEvent("sp_admin:explossiveAmmo")
      AddEventHandler("sp_admin:explossiveAmmo", function()
        explossiveAmmo = not explossiveAmmo
        if explossiveAmmo then
            notification(Config.Text[Language].SPAdmin, "Administration", "Explossive Ammo : ~g~ON") 
        else
          notification(Config.Text[Language].SPAdmin, "Administration", "Explossive Ammo : ~r~OFF") 
        end
      end) 

      Citizen.CreateThread(function() -- Delete Gun
        while true do
          Citizen.Wait(0)
      
          if deleteGun then
            if IsPlayerFreeAiming(PlayerId()) then
              local entity = getEntity(PlayerId())
              if IsPedShooting(GetPlayerPed(-1)) then
                SetEntityAsMissionEntity(entity, true, true)
                DeleteEntity(entity)
              end
            end
          end
        end
      end)

     

      Citizen.CreateThread(function() -- Vehicle Gun
        while true do
          Citizen.Wait(0)
      
          if vehicleGun then
            if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
              if IsPedShooting(GetPlayerPed(-1)) then
                while not HasModelLoaded(GetHashKey(Config.vehicleGunVehicle)) do
                              Citizen.Wait(0)
                              RequestModel(GetHashKey(Config.vehicleGunVehicle))
                end
                local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
                local veh =  CreateVehicle(GetHashKey(Config.vehicleGunVehicle), playerPos.x + (10 * GetEntityForwardX(GetPlayerPed(-1))), playerPos.y + (10 * GetEntityForwardY(GetPlayerPed(-1))), getGroundZ(playerPos.x + (10 * GetEntityForwardX(GetPlayerPed(-1))), playerPos.y + (10 * GetEntityForwardY(GetPlayerPed(-1))), playerPos.z + 5), GetEntityHeading(GetPlayerPed(-1)), true, true)
                SetEntityAsNoLongerNeeded(veh)
                SetVehicleForwardSpeed(veh, 150.0)
              end
            end
          end
        end
      end)  


      RegisterNetEvent("sp_admin:vehicleGun")
      AddEventHandler("sp_admin:vehicleGun", function()
        vehicleGun = not vehicleGun
        if vehicleGun then
            notification(Config.Text[Language].SPAdmin, "Administration", "Vehicle Gun : ~g~ON") 
        else
          notification(Config.Text[Language].SPAdmin, "Administration", "Vehicle Gun : ~r~OFF") 
        end
    
      end)

      RegisterNetEvent("spadmin:envoyer")
AddEventHandler("spadmin:envoyer", function(msg)
	PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
	local head = RegisterPedheadshot(PlayerPedId())
	while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
		Wait(1)
	end
	headshot = GetPedheadshotTxdString(head)
	ESX.ShowAdvancedNotification('Staff Message', '~r~Information', '~r~ ' ..msg, headshot, 3)
end)

RegisterNetEvent("wld:delallveh")
AddEventHandler("wld:delallveh", function ()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
end)

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end
  
--##################################--
--####    SP Leaks License ©    ####--
--##################################--



