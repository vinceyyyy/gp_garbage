fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'G Pochico'
description 'Simple script for persistent dumpster inventories'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua',
    'server/functions.lua',
    '@oxmysql/lib/MySQL.lua'
}

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua',
    '@ox_lib/init.lua'
}

dependencies {
    'ox_inventory'
}