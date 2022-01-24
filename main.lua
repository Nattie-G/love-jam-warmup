local intro = require "intro"
local intro2 = require "intro2"

local lg = love.graphics
local GAME_WIDTH  = CONFIG_OPTIONS.window.width
local GAME_HEIGHT = CONFIG_OPTIONS.window.height

-- init'd in love.load
local window_width, window_height
local interface = {}

function love.load()
  window_width, window_height = GAME_WIDTH, GAME_HEIGHT
  canvas = lg.newCanvas(GAME_WIDTH,GAME_HEIGHT)
  interface.menuFont = love.graphics.newFont('fonts/Noto_Sans/NotoSans-Bold.ttf', 40)
  interface.introFont = love.graphics.newFont('fonts/Anton-Regular.ttf', 60)

  intro:init()
  intro2:init()
end

function love.update(dt)
  intro:update(dt)
  intro2:update(dt)
end

function love.draw()
  lg.setCanvas(canvas)
  lg.setColor(0.15, 0.20, 0.85)
  lg.rectangle('fill', 0, 0, 1600, 900)
  lg.setColor(0.90, 1.00, 0.90)
  lg.setFont(interface.menuFont)
  lg.print('Welcome to the warmup weekend!', 450, 400, 0, 1)
  local fps = love.timer.getFPS()
  lg.print('FPS: ' .. fps, 50, 40, 0, 0.75)
  lg.setCanvas()
  local stretchX = window_width / GAME_WIDTH
  local stretchY = window_height / GAME_HEIGHT
  lg.draw(canvas, 0, 0, 0, stretchX, stretchY)

  intro:draw()
  intro2:draw()
end

function love.resize(w, h)
  window_width  = w
  window_height = h
  --love.window.setMode(w, h)

end

function love.mousepressed(x, y, button, isTouch)
end

function love.mousereleased(x, y, button, isTouch)
end

function love.keypressed(key)
end

function love.focus(f)
end

function love.quit()
end
