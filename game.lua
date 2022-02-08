local levelsList = require 'levels'
local lvlIdx = 1

-- to be set in init()
local size = 60
local level = levelsList[lvlIdx]
--local level = loadLevel(1)
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

local function loadLevel(idx)
  local lv = levelsList[idx]
  return lv
end

local function autoTile()
  for _, t in ipairs(level.tilesList) do
    local n = 0
    local G = level.grid
    local tileN = G[t.gy-1] and G[t.gy-1][t.gx]
    if tileN and tileN.type == t.type then
      n = n +1
    end
    local tileE = G[t.gy][t.gx+1]
    if tileE and tileE.type == t.type then
      n = n +2
    end
    local tileS = G[t.gy+1] and G[t.gy+1][t.gx]
    if tileS and tileS.type == t.type then
      n = n +4
    end
    local tileW = G[t.gy][t.gx-1]
    if tileW and tileW.type == t.type then
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
  lg.push()
  lg.translate(lg.getWidth()/2 - GAME_WIDTH*zoom/2, lg.getHeight()/2 - GAME_HEIGHT*zoom/2)
  lg.scale(zoom)

  lg.setColour(0.7, 0.55, 0.41)
  lg.rectangle("fill", 0,0, GAME_WIDTH, GAME_HEIGHT)

  for _, t in ipairs(level.tilesList) do
    if t.type == "Wall" then
      lg.setColour(1,1,1) 
      lg.draw(images[t.tile+1], (t.gx-1) * size, (t.gy-1) * size, nil, size/images[16]:getWidth())
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

  local P = level.player
  lg.setColor(P.color)
  lg.rectangle('fill', 5 + (P.gx-1) * size, 5 + (P.gy-1) * size, size -10, size-10)
  lg.setColor(0, 0, 0)
  lg.setLineWidth(2)
  lg.rectangle('line', 5 + (P.gx-1) * size, 5 + (P.gy-1) * size, size-10, size-10)

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

local inputActions = {}
do
  local actions = {'left', 'right', 'up', 'down'}
  for k, v in ipairs(actions) do
    inputActions[v] = k
  end
end

local keyMap = {}
do
  local IA = inputActions
  keyMap = {
    ['left']  = IA.left,
    ['right'] = IA.right,
    ['up']    = IA.up,
    ['down']  = IA.down,
  }
end

function Game:keypressed(key)
  local IA = inputActions
  local P = level.player
  --print("key = ", key)
  --print("keyMap[key] = ", keyMap[key])
  if keyMap[key] == IA.left then
    P.gx = P.gx - 1
  elseif keyMap[key] == IA.right then
    P.gx = P.gx + 1
  elseif keyMap[key] == IA.up then
    P.gy = P.gy - 1
  elseif keyMap[key] == IA.down then
    P.gy = P.gy + 1
  else
  end
end

function Game:keyreleased(key)
end

-- function love.resize(w, h)
--   zoom = math.min(w/GAME_WIDTH, h/GAME_HEIGHT)
-- end
function Game.resize(w,h)
  zoom = math.min(w/GAME_WIDTH, h/GAME_HEIGHT)
end

return Game
