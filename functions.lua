function openInventory()
    Citizen.Wait(100)
    if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'openInventory') == false then
        fetchInventory()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'openInventory', {
            title = 'What would you like to throw away?',
            align = 'bottom-right',
            elements = inv
        }, function(data, menu)
            for k, v in pairs(inv) do
                if data.current.value == inv[k].value then
                    OpenQuantityMenu(inv[k].value , inv[k].label) 
                    inv = {}
                    break                    
                end    
            end

            menu.close()
            openInventory()
            
        end,
        function(data, menu)
            menu.close()
            inv = {}
        end)
    end 
end

function fetchInventory()
    inv = {}
    ESX.TriggerServerCallback('dv_garbage:getInventory', function(inventory)
        for k, v in pairs(inventory) do
            if v.count > 0 then
                table.insert(inv, { label = v.label .. ' | ' .. v.count .. 'x ', value = v.name })
            end
        end
    end)
    Citizen.Wait(100)
end

function OpenQuantityMenu(value, label)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'open_quantity_menu', {
        title = 'How many would you like to throw away?'
    }, function(data, menu) 
        local quantity = tonumber(data.value)

        if quantity == nil then
            ESX.ShowNotification('Please enter a number!')
        else
            TriggerServerEvent('dv_garbage:removeItem', value, quantity)
            label = string.match(label, "^(.-) |")
            local msg = "You threw away: <span style='color:red;'>" .. quantity .. "x of " .. label .. "</span>"
            ESX.ShowNotification(msg)
            ESX.UI.Menu.CloseAll()
        end
        
        openInventory()
    end, function(data, menu)
        menu.close()
    end)

end