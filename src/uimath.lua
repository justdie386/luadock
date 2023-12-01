local uimath = {} --its called uimath because math can't really be used

function uimath.getCircleCoordinates(width, height, totalItems) --this function will return the coordinates of the circle for each icons
    local radius = 9 * math.sqrt(height / math.pi)
    local angle = 360 / #totalItems
    for i = 1, #totalItems do
        angle = angle + 360 / #totalItems
        local x = radius * math.cos(math.rad(angle))
        local y = radius * math.sin(math.rad(angle))
        table.insert(totalItems[i], { x = x + 72, y = y + 72 })
    end
    return totalItems
end


return uimath