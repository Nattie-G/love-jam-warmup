local levelsList = require 'levels'
local lvlIdx = 1

-- to be set in init()
local size = 60
local level = levelsList[lvlIdx]
local GAME_WIDTH = size*level.gridWidth
local GAME_HEIGHT = size*level.gridHeight
local zoom = math.min(love.graphics.getWidth()/GAME_WIDTH, love.graphics.getHeight()/GAME_HEIGHT)

local Game = {}

local images = {
  love.graphics.newImage("auto tiling/0.png"),
  love.graphics.newImage("auto tiling/1.png"),
  love.graphics.newImage("auto tiling/2.png"),
  love.graphics.newImage("auto tiling/3.png"),
  love.graphics.newImage("auto tiling/4.png"),
  love.graphics.newImage("auto tiling/5.png"),
  love.graphics.newImage("auto tiling/6.png"),
  love.graphics.newImage("auto tiling/7.png"),
  love.graphics.newImage("auto tiling/8.png"),
  love.graphics.newImage("auto tiling/9.png"),
  love.graphics.newImage("auto tiling/10.png"),
  love.graphics.newImage("auto tiling/11.png"),
  love.graphics.newImage("auto tiling/12.png"),
  love.graphics.newImage("auto tiling/13.png"),
  love.graphics.newImage("auto tiling/14.png"),
  love.graphics.newImage("auto tiling/15.png")
}

local function autoTile()
  for _, t in ipairs(level.tilesList) do
    local n = 0
    if level.grid[t.gx][t.gy-1] and level.grid[t.gx][t.gy-1].type == t.type then
      n = n +1
    end
    if level.grid[t.gx+1] and level.grid[t.gx+1][t.gy] and level.grid[t.gx+1][t.gy].type == t.type then
      n = n +2
    end
    if level.grid[t.gx][t.gy+1] and level.grid[t.gx][t.gy+1].type == t.type then
      n = n +4
    end
    if level.grid[t.gx-1] and level.grid[t.gx-1][t.gy] and level.grid[t.gx-1][t.gy].type == t.type then
      n = n +8
    end

    t.tile = n
  end
end
autoTile()

function Game:update(dt)
  for _, e in ipairs(level.entitiesList) do
    e:update(dt)
  end
end

function Game:draw()
  GAME_WIDTH = size*level.gridWidth
  GAME_HEIGHT = size*level.gridHeight
  love.graphics.push()
  love.graphics.translate(love.graphics.getWidth()/2 - GAME_WIDTH*zoom/2, love.graphics.getHeight()/2 - GAME_HEIGHT*zoom/2)
  love.graphics.scale(zoom)

  love.graphics.setColour(0.7, 0.55, 0.41)
  love.graphics.rectangle("fill", 0,0, GAME_WIDTH, GAME_HEIGHT)

  for _, t in ipairs(level.tilesList) do
    if t.type == "Wall" then
      love.graphics.setColour(1,1,1) 
      love.graphics.draw(images[t.tile+1], (t.gx-1) * size, (t.gy-1) * size, nil, size/images[16]:getWidth())
      -- love.graphics.print(t.tile, (t.gx-1) * size, (t.gy-1) * size)
    else
      lg.setColor(t.color)
      lg.rectangle('fill', (t.gx-1) * size, (t.gy-1) * size, size, size)
      lg.setColor(0, 0, 0)
      lg.rectangle('line', (t.gx-1) * size, (t.gy-1) * size, size, size)
    end
  end

  for _, e in ipairs(level.entitiesList) do
    lg.setColor(e.color)
    lg.rectangle('fill', 5 + (e.gx-1) * size, 5 + (e.gy-1) * size, size -10, size-10)
    lg.setColor(0, 0, 0)
    lg.setLineWidth(2)
    lg.rectangle('line', 5 + (e.gx-1) * size, 5 + (e.gy-1) * size, size-10, size-10)
  end
  love.graphics.pop()
end

function Game.printGrid()
  for r = 1, level.gridHeight do
    local tbl = {}
      for c = 1, level.gridWidth do
        table.insert(tbl, level.grid[r][c] and 'X' or '0')
    end
    print(table.concat(tbl))
  end
end

-- function love.resize(w, h)
--   zoom = math.min(w/GAME_WIDTH, h/GAME_HEIGHT)
-- end
function Game.resize(w,h)
  zoom = math.min(w/GAME_WIDTH, h/GAME_HEIGHT)
end

return Game
