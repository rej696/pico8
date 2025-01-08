pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
#include sat.lua

me = {}

asteroids = {
   asteroid_1 = {},
   asteroid_2 = {},
   asteroid_3 = {},
   asteroid_4 = {},
}

function init_asteroid(self)
   self.sprite = 1
   self.x = rnd(128)
   self.y = rnd(128)
   self.xvel = 0
   self.yvel = 0
end

function render(self)
 spr(self.sprite, self.x, self.y)
end

function _init()
   cls()
   me.sprite = 2
   me.x = 64
   me.y = 64
   me.xvel = 0
   me.yvel = 0
   apply(init_asteroid, asteroids)
end

function move(self)
   if (btn(0)) self.xvel -= 1
   if (btn(1)) self.xvel += 1
   if (btn(2)) self.yvel -= 1
   if (btn(3)) self.yvel += 1
   update_vel(self)
end

function update_vel(self)
   local lim = 5
   if (self.xvel > lim) self.xvel = lim
   if (self.xvel < -lim) self.xvel = -lim
   if (self.yvel > lim) self.yvel = lim
   if (self.yvel < -lim) self.yvel = -lim

   self.x += self.xvel
   if self.x > 120 then
     self.x = 120
     self.xvel = -1
   elseif self.x <= 0 then
     self.x = 0
     self.xvel = 1
   end
   self.y += self.yvel
   if self.y > 120 then
     self.y = 120
     self.yvel = -1
   elseif self.y <= 0 then
     self.y = 0
     self.yvel = 1
   end
end

function rand_move(self)
   switch = ceil(rnd(4))
   if (switch == 1) self.xvel -= 1
   if (switch == 2) self.xvel += 1
   if (switch == 3) self.yvel -= 1
   if (switch == 4) self.yvel += 1
   update_vel(self)
end

function apply(func, tbl)
   for _,x in pairs(tbl) do
     func(x)
   end
end   

function _update()
   move(me)
   
   apply(rand_move, asteroids)
end

function _draw()
   cls()
   render(me)
   apply(render, asteroids)
--   render(asteroids.asteroid_1)
   
--   for a in ipairs(asteroids) do
--     render(a)
--   end 
end
-->8


function rotate(x, y, rot, mx, my, w, flip, scale)
  scale = scale or 1
  local halfw, cx = scale * -w/2, mx + 0.5
  local cy, cs, ss = my - halfw/scale, cos(rot)/scale, sin(rot)/scale
  local sx = cx + cs * halfw
  local sy = cy + ss * halfw
  local hx = w * (flip and -4 or 4) * scale
  local hy = w * 4 * scale
  for py = y - hy, y + hy do
   tline(x - hx, py, x + hx, py, sx - ss * halfw, sy + cs * halfw, cs/8, ss/8)
   halfw += 0.125
  end
end
   
__gfx__
00000000000000000008200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006660000005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700066666000055550a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000066606000056655a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700006666600d256650a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700006660000056755a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000055550a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000dd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
