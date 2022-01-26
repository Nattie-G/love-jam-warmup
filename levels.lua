local Entity = require 'entity'

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
  newTile(0, 0),
  newTile(60, 45),
  newTile(120, 90),
  newTile(180, 90),
  newTile(60, 90),
  newTile(240, 135),
}

Levels[1] = dummyLevel

return Levels
