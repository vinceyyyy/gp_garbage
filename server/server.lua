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

RegisterNetEvent('gp_garbage:openStashServer', function(stashName, coords)
    local src = source
    
    MySQL.query('SELECT * FROM garbage_bins WHERE xCoord = ? AND yCoord = ? AND zCoord = ?', 
        {coords.x, coords.y, coords.z}, 
        function(result)
            if #result > 0 then
                print("does already exist")
                local existingStashName = result[1].stash
                print("existing stash name: ", existingStashName)
                TriggerClientEvent('gp_garbage:openStashClient', src, existingStashName)
            else
                print("making new stash")

                oxRegisterStash(stashName)

                MySQL.query('INSERT INTO garbage_bins (stash, xCoord, yCoord, zCoord) VALUES (?, ?, ?, ?)', {
                    stashName,
                    coords.x,
                    coords.y,
                    coords.z
                })
                
                TriggerClientEvent('gp_garbage:openStashClient', src, stashName)
            end  
        end)
end)

RegisterNetEvent('gp_garbage:lazyRegisterStash', function(stash)
    local src = source

    oxRegisterStash(stash)
    print("lazy registered stash:", stash)
    TriggerClientEvent('gp_garbage:openStashClient', src, stash)
end)