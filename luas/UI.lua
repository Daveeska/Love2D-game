require("luas.UI.debugItem")

local UI = {
    debugVar = require("luas.UI.debugItem"),
    isDebugging=false
}

function UI:activateDebug(key)
    if key=="f3" then
        self.isDebugging = not self.isDebugging
    end
end

function UI:update()
    self.debugVar:update()
end

function UI:draw()
    if self.isDebugging then
        self.debugVar:draw()
    end
end

return UI
