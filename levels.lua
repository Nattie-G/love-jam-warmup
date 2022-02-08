local Entity = require 'entity'
local Tile = require 'tile'

local Levels = {}

function newTile(x, y)
  local T = {x = x, y = y, w = 60, h = 60, color = {1, 1, 0}}
  return T
end

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

Levels.featureDict = featureDict

function loadLevel(path)
  local level = {}
  level.tilesList = {}
  level.entitiesList = {}

  --TODO protect io calls
  local file = io.open(path)
  io.input(file)
  local contents = io.read("*all")

  local _
  _, level.gridHeight = contents:gsub("\n", "\n") 
  level.gridWidth = contents:find("\n") - 1

  level.grid = {}
  for row = 1, level.gridHeight do
    level.grid[row] = {}
  end

  file:seek('cur', 0)
  local lines = io.lines(path)

  local row = 0
  for l in lines do
    row = row + 1
    for col = 1, #l do
      local char = l:sub(col, col)
      local feature = asciiDict[char]
      local entity, tile
      local opts = {gx = col, gy = row, type = feature}
      if feature == featureDict.BOX then -- entities branch
        entity = Entity:new(opts)
      elseif feature == featureDict.PLAYER then
        --opts.color = {0.0, 0.7, 0.2}
        --entity = Entity:new(opts)
        --level.player = entity
        opts.color = {0.0, 0.7, 0.2}
        level.player = Entity:new(opts)

      else -- tiles branch
        if feature == featureDict.WALL then
          tile = Tile:new(opts)
        elseif feature == featureDict.GOAL then
          opts.color = {0.7, 0.2, 0.0}
          tile = Tile:new(opts)
        end
      end

      table.insert(level.tilesList, tile)
      table.insert(level.entitiesList, entity)
      level.grid[row][col] = {tile or entity}
    end
  end
  return level
end

Levels[1] = loadLevel('test-puzzle') 

return Levels
