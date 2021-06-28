-- true seems sensible? neons are on by default
local neonlightsOn = true

RegisterNetEvent('neonlights:toggle')
AddEventHandler('neonlights:toggle', function()
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false)
  local driverPed = GetPedInVehicleSeat(vehicle, -1)
  local neonlightsShould = (not neonlightsOn and true or false)

  -- vehicle has neons and player is the driver
  if IsVehicleNeonLightEnabled(vehicle, 1) and driverPed == playerPed then
    DisableVehicleNeonLights(vehicle, neonlightsShould)
    neonlightsOn = neonlightsShould
  end
end)

-- main thread to bind keys
Citizen.CreateThread(
  function()
    while true do
      -- player pressed CTRL+H ... this will also toggle normal headlights
      -- if IsControlPressed(0, 132) and IsControlJustReleased(0, 74) then

      -- CTRL+G
      if IsControlPressed(0, 132) and IsControlJustReleased(0, 47) then
        TriggerEvent('neonlights:toggle')
      end

      Citizen.Wait(0)
    end
  end
)