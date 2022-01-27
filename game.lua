local levelsList = require 'levels'
local lvlIdx = 1

-- to be set in init()
local level

local Game = {}

function Game:init()
  level = levelsList[lvlIdx]
end

function Game:update(dt)
  for _, e in ipairs(level.entitiesList) do
    e:update(dt)
  end
end

function Game:draw()
  for _, t in ipairs(level.tilesList) do
    lg.setColor(t.color)
    lg.rectangle('fill', t.gx * 60, t.gy * 45, t.w, t.h)
    lg.setColor(0, 0, 0)
    lg.rectangle('line', t.gx * 60, t.gy * 45, t.w, t.h)
  end

  for _, e in ipairs(level.entitiesList) do
    lg.setColor(e.color)
    lg.rectangle('fill', 5 + e.gx * 60, 5 + e.gy * 45, e.w, e.h)
    lg.setColor(0, 0, 0)
    lg.setLineWidth(2)
    lg.rectangle('line', 5 + e.gx * 60, 5 + e.gy * 45, e.w, e.h)
  end
end

return Game
