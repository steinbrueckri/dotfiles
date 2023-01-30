local log = hs.logger.new('init.lua', 'debug')

mash = {"ctrl"}

require "grid"

-- Use Control+` to reload Hammerspoon config
hs.hotkey.bind(mash, '+', nil, function()
  hs.reload()
end)

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()
