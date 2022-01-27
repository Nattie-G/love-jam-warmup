local Entity = require 'entity'
local Tile = require 'tile'

local Levels = {}

local dummyLevel = {}
dummyLevel.entitiesList = {
  Entity:new({x = 500, y = 300}),
  Entity:new({x = 550, y = 400}),
}

function newTile(x, y)
  local T = {x = x, y = y, w = 60, h = 45, color = {1, 1, 0}}
  return T
end

dummyLevel.tilesList = {
  Tile:new({x = 0,   y = 0  }),
  Tile:new({x = 60,  y = 45 }),
  Tile:new({x = 120, y = 90 }),
  Tile:new({x = 180, y = 90 }),
  Tile:new({x = 60,  y = 90 }),
  Tile:new({x = 240, y = 135}),
}

Levels[1] = dummyLevel

return Levels
