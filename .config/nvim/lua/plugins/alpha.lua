local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
local banner_list = {
    {

        [[=================     ===============     ===============   ========  ========]],
        [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
        [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
        [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
        [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
        [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
        [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
        [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
        [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
        [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
        [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
        [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
        [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
        [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
        [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
        [[||.=='    _-'                                                     `' |  /==.||]],
        [[=='    _-'                        N E O V I M                         \/   `==]],
        [[\   _-'                                                                `-_   /]],
        [[ `''                                                                      ``' ]]
    }, {
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣴⣶⣤⣤⠀⠀⠀⢀⣠⣤⣴⣤⣤⣀⠀⠀⠀⠀⠀⠀⣠⣦⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⣄⠀⠀⠀⠀⠀⢠⣠⣠⣠⣠⣠⣠⣠⣠⣠⣠⣠⣠⣠⣠⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⣤⣿⣿⣿⣿⣶⣀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡷⠀⠀⠙⢿⣿⣿⣿⣿⣿⣶⣤⣾⣿⣿⣿⣿⣿⡿⠉⠀⠀⠀⠀⢸⣿⣿⠛⠉⠙⣿⣿⣿⣿⣿⠛⠉⠙⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠉⠀⠀⠀⠀⠀⠀⢸⣿⣿⣀⠀⢀⣼⣿⣿⣿⣿⡀⠀⢀⣾⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣤⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⢀⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⠛⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⣿⣿⣿⠋⠀⠙⣿⣿⣿⣿⣿⣿⣶⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⠿⠉⠀⠀⠀⠀⠀⠙⢿⣿⣿⠛⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]
    }, {
        [[                               ]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣤⣴⣦⣤⣤⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⣠⣾⣿⣿⡿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⢿⣿⣿⣶⡀⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⣴⣿⣿⠟⠁⠀⠀⠀⣶⣶⣶⣶⡆⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣦⠀⠀⠀ ]],
        [[⠀⠀⣼⣿⣿⠋⠀⠀⠀⠀⠀⠛⠛⢻⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣧⠀⠀ ]],
        [[⠀⢸⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⡇⠀ ]],
        [[⠀⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⠀ ]],
        [[⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡟⢹⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⣹⣿⣿⠀ ]],
        [[⠀⣿⣿⣷⠀⠀⠀⠀⠀⠀⣰⣿⣿⠏⠀⠀⢻⣿⣿⡄⠀⠀⠀⠀⠀⠀⣿⣿⡿⠀ ]],
        [[⠀⢸⣿⣿⡆⠀⠀⠀⠀⣴⣿⡿⠃⠀⠀⠀⠈⢿⣿⣷⣤⣤⡆⠀⠀⣰⣿⣿⠇⠀ ]],
        [[⠀⠀⢻⣿⣿⣄⠀⠀⠾⠿⠿⠁⠀⠀⠀⠀⠀⠘⣿⣿⡿⠿⠛⠀⣰⣿⣿⡟⠀⠀ ]],
        [[⠀⠀⠀⠻⣿⣿⣧⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⠏⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠈⠻⣿⣿⣷⣤⣄⡀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⠟⠁⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀ ]],
        [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠛⠛⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
        [[                               ]]
    },{
        [[                                       ]],
        [[                        ██████████     ]],
        [[                      ██░░▓▓░░▓▓██     ]],
        [[                    ██░░    ▓▓▓▓██     ]],
        [[                ████░░░░██░░  ▓▓██     ]],
        [[              ██░░░░  ██░░██░░░░██     ]],
        [[    ██████████░░      ░░██░░░░██       ]],
        [[      ██▓▓██░░      ░░░░░░░░██         ]],
        [[        ██░░░░██████░░░░░░██           ]],
        [[        ██░░░░██████░░░░░░██           ]],
        [[          ████▓▓████░░░░██             ]],
        [[      ░░░░  ████  ░░░░██               ]],
        [[      ░░      ██▓▓▓▓████               ]],
        [[      ░░    ░░  ████▓▓██               ]],
        [[    ░░  ░░░░░░      ████               ]],
        [[    ░░░░              ██               ]],
    },{
      [[                                                                                    ]],
			[[                                   .-.   :+-   .-.                                  ]],
			[[                              :.   =++- :+++- :++=   .:                             ]],
			[[                             .++=::+++++++++++++++-.=++:                            ]],
			[[                        .-:  -+++++++++++++++++++++++++-  .-.                       ]],
			[[                        :+++=+++++++++++++++++++++++++++=+++-                       ]],
			[[      .                 :+++++++++++++++++++++++++++++++++++-              :=-   .  ]],
			[[      :+-.          ++===++++++++++++++++++++++++++++++++++++-=++.       :+++:   -- ]],
			[[  -+   +++-         =++++++++++++++++++++++++++++++++++++++++++++       =++++.  .++ ]],
			[[ -++-  =+++=        -+++++++++++++++++++++++++++++++++++++++++++=      :+++++. .+++ ]],
			[[ ++++: -++++:   =++++++++++++++++++++++++++++++++++++++++++++++++++++  -+++++:-+++= ]],
			[[ =++++-:++++-   :+++++++++++++++++++++++++++++++++++++++++++++++++++-  :+++++++++=. ]],
			[[ .++++++++++:    =++++++++++++++++++++++++++++++++++++++++++++++++++    =+++++++=.  ]],
			[[   -+++++++= :-==+++++++++++++++++++++++++++++++++++++++++++++++++++==-: =++++=:    ]],
			[[     :=+++=  -+++++++++++++++++++++=-+%#*+++++++-=%#*++++++++++++++++++- =++=:      ]],
			[[       :+++-. :++++++++++++++++++++:  %@@*++++++  +@@+++++++++++++++++-:=++:        ]],
			[[        .=+++=-+++++++++++++++++++#+ :@@@%++++#%..#@@#++++++++++++++++=++=.         ]],
			[[          .-++++++++++++++++++++++#@@@@@@%++++#@@@@@@#+++++++++++++++++++.          ]],
			[[           -+++++++++++++++++++++++%@@@@%*+++++#@@@@%+++++++++++++++++++++-.        ]],
			[[         .=++++=***+++++++++++++++++*##*++++++++***++++++++++++++*****++++++        ]],
			[[         .+++++ -*#=+***++++++++++++++++++###%%++++++++++++++****=:.**.=+++:        ]],
			[[           -+++= :*+  :-=*****++++++++++++*%%%*+++++++++*****=-.   +*..+++:         ]],
			[[            :+++- .++      .:-==++*******************++=-:.       =+. =++:          ]],
			[[              -++-  ==               .............               :+  :++.           ]],
			[[               .=+-  ::                                          =  .+=.            ]],
			[[                 :+=  .                                         .   ==.             ]],
			[[                   --                                              :=               ]],
			[[                    :.                                             :                ]],
			[[                                                                                    ]],
    },{
      [[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓]],
      [[ ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒]],
      [[▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░]],
      [[▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ]],
      [[▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒]],
      [[░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░]],
      [[░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░]],
      [[   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ]],
      [[         ░    ░  ░    ░ ░        ░   ░         ░   ]],
      [[                                ░                  ]],
    }
}

local function banner()
    -- selects an entry from banner_list randomly
    math.randomseed(os.time())
    local ind = math.random(1, #banner_list)
    return banner_list[ind]
end

dashboard.section.header.val = banner()

-- Set footer
local function footer()
  local plugins_count = vim.fn.len(vim.fn.globpath("~/.local/share/nvim/lazy/", "*", 0, 1))
  local datetime = os.date("  %d-%m-%Y   %H:%M:%S")
  local version = vim.version()
  local prerelease = ""
  if version.prerelease then
      prerelease = "-DEV"
  end
  local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch .. prerelease
  return datetime .. "   Plugins " .. plugins_count .. nvim_version_info
end
dashboard.section.footer.val = footer()

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("e", " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", " Recent files", ":Telescope oldfiles<CR>"),
    dashboard.button("p", " Projects", ":Telescope projects<CR>"),
    dashboard.button("s", " Settings", ":e $MYVIMRC <CR>"),
    dashboard.button("u", " Update plugins", ":Lazy update<CR>"),
    dashboard.button('h', " Check Health", ":checkhealth <CR>"),
    dashboard.button('q', " Quit", ":q <CR>"),
}

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
