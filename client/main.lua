-- true seems sensible? neons are on by default
local neonlightsOn = true

RegisterNetEvent('neonlights:toggle')
AddEventHandler('neonlights:toggle', function()
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false)
  local driverPed = GetPedInVehicleSeat(vehicle, -1)

  -- vehicle has neons and player is the driver
  if IsVehicleNeonLightEnabled(vehicle, 1) and driverPed == playerPed then
    -- are the lights on already?
    if neonlightsOn then
      DisableVehicleNeonLights(vehicle, false)
      neonlightsOn = false
    else
      DisableVehicleNeonLights(vehicle, true)
      neonlightsOn = true
    end
  else
    -- no neonlight installed. do nothing
  end
end)

-- main thread to bind keys
Citizen.CreateThread(
  function()
    while true do
      -- player pressed CTRL+G
      if IsControlPressed(0, 132) and IsControlJustReleased(0, 47) then
        TriggerEvent('neonlights:toggle')
      end

      Citizen.Wait(0)
    end
  end
)