-- require('keyboard') -- Load Hammerspoon bits from https://github.com/jasonrudolph/keyboard

hs.hotkey.bind({'ctrl'}, '`', nil, function()
  hs.reload()
end)

-- hs.loadSpoon('ControlEscape'):start()
-- hs.loadSpoon('Markdown'):start()
hs.loadSpoon('PushToTalk'):start()
hs.loadSpoon('WindowLayout'):start()

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()
