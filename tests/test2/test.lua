
function circ_render(self)
    circfill(self.x, self.y, self.r, self.col)
end

circ = {
    col = 7,
    x = 64,
    y = 64,
    r = 32,
    render = circ_render,
}

circ2 = {
    col = 7,
    x = 64,
    y = 64,
    r = 32,
    render = circ_render,
}


function _init()
    -- always start on white
    -- circ.col = 7
    --     x = 64,
    --     y = 64,
    -- }
end

function _update()
    if btnp(5) then circ.col = 8 + rnd(8) end

    if btnp(0) then circ.x = circ.x - 2 end
    if btnp(1) then circ.x = circ.x + 2 end
    if btnp(2) then circ.y = circ.y - 2 end
    if btnp(3) then circ.y = circ.y + 2 end


    local operations = {
        function (c) c.col = 8 + rnd(8) end,
        function (c) if c.x > 32 then c.x = c.x - 2 end end,
        function (c) if c.x < 96 then c.x = c.x + 2 end end,
        function (c) if c.y > 32 then c.y = c.y - 2 end end,
        function (c) if c.y < 96 then c.y = c.y + 2 end end,
        function (c) if c.r > 4 then c.y = c.y - 2 end end,
        function (c) if c.r < 96 then c.y = c.y + 2 end end,
        function (c) c.r = 12 + rnd(40) end,
        function (c) c.x = 32 + rnd(64); c.y = 32 + rnd(64) end
    }

    operations[ceil(rnd(9))](circ)
    operations[ceil(rnd(9))](circ2)
end


function _draw()
    cls(1)
    circ:render()
    circ2:render()
end


