fx_version "cerulean"

game "gta5"

author 'BatOP / Ghost'

description "Jail RageUI V2"

server_scripts {
	'@mysql-async/lib/mysql.lua',
	'server/*.lua',
}

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
	'client/*.lua',
}