fx_version 'adamant'
game 'gta5'

this_is_a_map "yes"

description 'Eindopdracht resource'
version '0.0.1'

studentinfo {
    'Marc Hooftman - 1064802 - INF1H'
}

lua54 'yes'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/main.lua',
    'client/npcs.lua',
    'client/blips.lua',
    'client/commands.lua',
    'client/functions.lua',
    'client/keymapping.lua',
    'client/zones.lua',
    'client/nui.lua',
    'client/markers.lua'
}

server_scripts {
    'server/*.lua'
}

files {
    'stream/*.ymap',
    'html/index.html',
    'html/main.js',
    'html/style.css',
    'html/reset.css',
    'html/captcha.js'
}

ui_page "html/index.html"
