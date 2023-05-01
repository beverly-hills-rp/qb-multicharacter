fx_version 'cerulean'
game 'gta5'

description 'QB-Multicharacter'
version '1.2.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'shared/messages.lua',
    'shared/config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts  {
    '@oxmysql/lib/MySQL.lua',
    '@qb-apartments/config.lua',
    'server/main.lua'
}

-- ui_page 'html/index.html'

-- files {
--     'html/index.html',
--     'html/style.css',
--     'html/reset.css',
--     'html/vue.js',
--     'html/swal2.js',
--     'html/profanity.js'
-- }

ui_page 'nui/dist/index.html'

files {
    'nui/dist/index.html',
    'nui/dist/assets/*.js',
    'nui/dist/assets/*.css'
}

dependencies {
    'qb-core',
    'qb-spawn'
}

lua54 'yes'
