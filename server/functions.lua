function oxRegisterStash(stashName)
    local stash = {
        id = stashName,
        label = "Garbage",
        slots = Config.DumpsterAttributes.slots,
        weight = Config.DumpsterAttributes.maxWeight
    }  

    exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, false)
end