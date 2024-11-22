local isNearTrash = false
local inv = {}

-- Citizen.CreateThread(function()
--     while true do
--         local playerPed = PlayerPedId()
--         local playerCoords = GetEntityCoords(playerPed)
--         local radius = 1.0

--         --Check if player is near dumpster
--         for _, currentModel in ipairs(Config.DumpsterModels) do
--             local dumpster = GetClosestObjectOfType(playerCoords.x, playerCoords.y, playerCoords.z, radius, currentModel, false, false, false)
--             if DoesEntityExist(dumpster) then
--                 isNearTrash = true
--                 break;
--             else
--                 isNearTrash = false
--             end
--         end
         
--         if isNearTrash then
--             ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to throw something away')
--             if IsControlJustReleased(0, 51) then
--                 openInventory()
--             end
--             Citizen.Wait(5)
--         else
--             ESX.UI.Menu.CloseAll()
--             Citizen.Wait(1000)
--         end
--     end
-- end)

