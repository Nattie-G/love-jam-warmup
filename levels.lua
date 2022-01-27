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

local featureDict = {
  WALL    = 'Wall',
  BOX     = 'Box',
  GOAL    = 'Goal',
  PLAYER  = 'Player',
}

local asciiDict = {
  ['#'] = featureDict.WALL,
  ['.'] = nil,
  ['G'] = featureDict.GOAL,
  ['B'] = featureDict.BOX,
  ['@'] = featureDict.PLAYER,
}

function loadLevel(path)
  local level = {}
  level.tilesList = {}
  level.entitiesList = {}

  local lines = io.lines(path) --TODO protect this call

  local row = 0
  for l in lines do
    row = row + 1
    print("row, l", row, l)
    for col = 1, #l do
      local char = l:sub(col, col)
      local feature = asciiDict[char]
      if feature == featureDict.BOX then -- entities branch
        local entity
        table.insert(level.entitiesList, entity)

      else -- tiles branch
        local tile
        if feature == featureDict.WALL then
          tile = Tile:new({gx = col, gy = row})
        elseif feature == featureDict.GOAL then
          tile = Tile:new({gx = col, gy = row, color = {0.7, 0.2, 0.0}})
        elseif feature == featureDict.PLAYER then
          tile = Tile:new({gx = col, gy = row, color = {0.0, 0.7, 0.2}})
        end

        table.insert(level.tilesList, tile)
      end

    end
  end
  return level
end

Levels[1] = loadLevel('test-puzzle') 

return Levels
