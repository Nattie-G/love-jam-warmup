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
    lg.rectangle('fill', t.x, t.y, t.w, t.h)
    lg.setColor(0, 0, 0)
    lg.rectangle('line', t.x, t.y, t.w, t.h)
  end

  for _, e in ipairs(level.entitiesList) do
    lg.setColor(e.color)
    lg.rectangle('fill', e.x, e.y, e.w, e.h)
    lg.setColor(0, 0, 0)
    lg.rectangle('line', e.x, e.y, e.w, e.h)
  end
end

return Game
