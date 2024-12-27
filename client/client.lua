exports.ox_target:addModel(Config.DumpsterModels, {
    name = targetName,
    label = "Throw something away",
    event = "gp_garbage:openTrashInventory",
    icon = 'fa-solid fa-trash-can',
    distance = 2.0,
    onSelect = function(data)
        local binEntity = data.entity
        local coords = GetEntityCoords(binEntity)
        coords = vector3(math.floor(coords.x), math.floor(coords.y), math.floor(coords.z))
        local stashName = "trash_" .. tostring(binEntity)
        
        TriggerServerEvent('gp_garbage:openStashServer', stashName, coords)
    end
})

RegisterNetEvent('gp_garbage:openStashClient', function(stash)
    if exports.ox_inventory:openInventory('stash', stash) == false then
        TriggerServerEvent('gp_garbage:lazyRegisterStash', stash)
    end
end)