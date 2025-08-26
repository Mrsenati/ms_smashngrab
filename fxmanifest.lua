fx_version 'cerulean'
game 'gta5' 
lua54 'yes'
use_experimental_fxv2_oal 'yes'

description 'Smash an grab script'
version '0.1.0'


shared_script {
    '@ox_lib/init.lua',
    -- '@qbx_core/modules/playerdata.lua',
    'config/shared.lua'
}

client_scripts {
    '@sleepless_interact/init.lua',
    'config/client.lua',
    'client/*.lua'
}
server_scripts {
    'config/server.lua',
    'server/*.lua'
}

dependencies {'ox_lib'}


