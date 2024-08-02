fx_version 'cerulean'

game 'gta5'

name "mVehicle"

description "Vehicle API - https://discord.gg/Vk7eY8xYV2"

author "aka_mono & .rawpaper"

version "1.1.0"

lua54 'yes'

shared_scripts { 'shared/*.lua', '@ox_lib/init.lua','@qbx_core/modules/lib.lua' }

client_script {'@qbx_core/modules/playerdata.lua','client/*.lua'}

server_scripts { '@oxmysql/lib/MySQL.lua', 'server/*.lua' }

files { 'locales/*.json' }

ox_libs { 'locale' }

file 'import.lua'
