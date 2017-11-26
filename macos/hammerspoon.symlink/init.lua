-- require('keyboard') -- Load Hammerspoon bits from https://github.com/jasonrudolph/keyboard

hs.hotkey.bind({'ctrl'}, '`', nil, function()
  hs.reload()
end)

hs.loadSpoon('ControlEscape')
hs.loadSpoon('Markdown')
hs.loadSpoon('PushToTalk')
hs.loadSpoon('WindowLayout')

hs.notify.new({title='Hammerspoon', informativeText='Ready to rock 🤘'}):send()
