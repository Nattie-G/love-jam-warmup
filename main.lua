local intro = require "intro"
local Game = require 'game'

lg = love.graphics -- global shorhand for use in all modules
local GAME_WIDTH  = CONFIG_OPTIONS.window.width
local GAME_HEIGHT = CONFIG_OPTIONS.window.height

-- init'd in love.load
local window_width, window_height
local interface = {}
local zoom = 1

love.graphics.setBackgroundColor(0.49, 0.31, 0.25)

function love.load()
  window_width, window_height = GAME_WIDTH, GAME_HEIGHT
  interface.menuFont = love.graphics.newFont('fonts/Noto_Sans/NotoSans-Bold.ttf', 40)
  interface.introFont = love.graphics.newFont('fonts/Anton-Regular.ttf', 60)

  intro:init()
end

function love.update(dt)
  intro:update(dt)
  Game:update(dt)
end

function love.draw()
  -- love.graphics.push()
  -- love.graphics.translate(love.graphics.getWidth()/2 - GAME_WIDTH*zoom/2, love.graphics.getHeight()/2 - GAME_HEIGHT*zoom/2)
  -- love.graphics.scale(zoom)

  lg.setFont(interface.menuFont)
  local fps = love.timer.getFPS()
  lg.print('FPS: ' .. fps, 50, 40, 0, 0.75)
  Game:draw()

  -- love.graphics.pop()
  lg.setColor(1, 1, 1)
  local stretchX = window_width / GAME_WIDTH
  local stretchY = window_height / GAME_HEIGHT

  intro:draw()
end

function love.resize(w, h)
  -- zoom = math.min(w/GAME_WIDTH, h/GAME_HEIGHT)
  Game.resize(w, h)
end

function love.mousepressed(x, y, button, isTouch)
end

function love.mousereleased(x, y, button, isTouch)
end

function love.keypressed(key)
  if key == 'p' then
    Game.printGrid()
  end
  Game:keypressed(key)
end

function love.keyreleased(key)
  Game:keyreleased()
end

function love.focus(f)
end

function love.quit()
end
