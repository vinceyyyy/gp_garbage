AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end

    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `garbage_bins` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `stash` VARCHAR(100) NOT NULL,
            `xCoord` INT(50) NOT NULL,
            `yCoord` INT(50) NOT NULL,
            `zCoord` INT(50) NOT NULL
        );
    ]], {}, function(affectedRows)
        print("Dumpster database ready")
    end)
end)

RegisterNetEvent('gp_garbage:openStash', function(stashName, coords)
    local src = source
    local stash = {
        id = stashName,
        label = "Garbage",
        slots = Config.DumpsterAttributes.slots,
        weight = Config.DumpsterAttributes.maxWeight
    }  
    
    MySQL.query('SELECT * FROM garbage_bins WHERE xCoord = ? AND yCoord = ? AND zCoord = ?', 
        {coords.x, coords.y, coords.z}, 
        function(result)
            if #result > 0 then
                local existingStashName = result[1].stash
                
                TriggerClientEvent('gp_garbage:openStash', src, existingStashName)
            else
                exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, false)

                MySQL.query('INSERT INTO garbage_bins (stash, xCoord, yCoord, zCoord) VALUES (?, ?, ?, ?)', {
                    stash.id,
                    coords.x,
                    coords.y,
                    coords.z
                })
                
                TriggerClientEvent('gp_garbage:openStash', src, stash.id)
            end  
        end)
end)