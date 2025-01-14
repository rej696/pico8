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
   self.sprite = 8
   self.x = 128
   self.y = rnd(128)
   self.xvel = -rnd(6)
   self.yvel = rnd(6)-3
end

function render(self)
 spr(self.sprite, self.x, self.y)
end

function _init()
   cls()
   me.sprite = 0
   me.x = 64
   me.y = 64
   me.speed = 0
   me.xvel = 0
   me.yvel = 0
   apply(init_asteroid, asteroids)
   music(0)
end

function move(self)
   -- if (btnp(0)) self.xvel -= 1
   -- if (btnp(1)) self.xvel += 1
   -- if (btnp(2)) self.yvel -= 1
   -- if (btnp(3)) self.yvel += 1
   
   -- manage speed
   self.speed = 0
   if (btnp(2)) self.speed = 0.5
   if (btnp(3)) self.speed = 0
   --if (self.speed > 6) self.speed = 6
   --if (self.speed <= 0) self.speed = 0
   
   -- manage sprite
   if (btnp(0)) self.sprite -= 1
   if (btnp(1)) self.sprite += 1
   if (self.sprite > 7) self.sprite = 0
   if (self.sprite < 0) self.sprite = 7
 
   if (self.sprite == 0) self.yvel += self.speed
   if (self.sprite == 2) self.xvel -= self.speed
   if (self.sprite == 4) self.yvel -= self.speed
   if (self.sprite == 6) self.xvel += self.speed
   
   if self.sprite == 1 then self.yvel += self.speed; self.xvel -= self.speed; end
   if self.sprite == 3 then self.yvel -= self.speed; self.xvel -= self.speed; end
   if self.sprite == 5 then self.yvel -= self.speed; self.xvel += self.speed; end
   if self.sprite == 7 then self.yvel += self.speed; self.xvel += self.speed; end

   update_vel(self)
end

function update_vel(self, not_bounce)
   local lim = 5
   if (self.xvel > lim) self.xvel = lim
   if (self.xvel < -lim) self.xvel = -lim
   if (self.yvel > lim) self.yvel = lim
   if (self.yvel < -lim) self.yvel = -lim
   
   self.x += self.xvel
   self.y += self.yvel
   
   if not_bounce then return end

   -- bounce   
   if self.x > 120 then
     self.x = 120
     --self.xvel = -1
     self.xvel = -self.xvel
     if (self.xvel < -1) self.xvel+=1
   elseif self.x < 0 then
     self.x = 0
     --self.xvel = 1
     self.xvel = -self.xvel
     if (self.xvel > 1) self.xvel-=1
   end

   if self.y > 120 then
     self.y = 120
     --self.yvel = -1
     self.yvel = -self.yvel
     if (self.yvel < -1) self.yvel+=1
   elseif self.y < 0 then
     self.y = 0
     --self.yvel = 1
     self.yvel = -self.yvel
     if (self.yvel > 1) self.yvel-=1
   end
end

function rand_move(self)
   switch = ceil(rnd(4))
   if (switch == 1) self.xvel -= 1
   if (switch == 2) self.xvel += 1
   if (switch == 3) self.yvel -= 1
   if (switch == 4) self.yvel += 1
   update_vel(self,true)
end

function ast_move(self)
   update_vel(self, true)
   if self.x > 148 or self.x < -28 or self.y > 148 or self.y < -28 then
       init_asteroid(self)
   end
end

function apply(func, tbl)
   for _,x in pairs(tbl) do
     func(x)
   end
end   

function _update()
   move(me)
   
   apply(ast_move, asteroids)
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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0008200000b008000003b000007003000006700000a006000009a000002009000066600000000000000000000000000000000000000000000000000000000000
005555000335582000555500066553b0005555000995567000555500088559a00666660000000000000000000000000000000000000000000000000000000000
0b5665900056650007566580005765000a5765300057750002567560005675000666060000000000000000000000000000000000000000000000000000000000
035675a0005775000657652000576500095665b00056650008566570005675000666660000000000000000000000000000000000000000000000000000000000
0055550007655990005555000a9558800055550002855330005555000b3556600066600000000000000000000000000000000000000000000000000000000000
0007600000600a00000a9000009002000002800000800b000003b000003007000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000170501705017050170501705017050170500d0500d050170500d0500d0501705017050170501705017050150501405016050160501405016050140501605000000000000000000000000000000000000
000f00000c0500c0500c05015050170500c0500c05015050170500f0500f351150500c0510c3561d05612056120500000013350000001b0500f0500f050000001005010050000000f0530c0500c0502005320050
__music__
02 01424344

