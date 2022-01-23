local lg = love.graphics
local GAME_WIDTH  = CONFIG_OPTIONS.window.width
local GAME_HEIGHT = CONFIG_OPTIONS.window.height
local window_width, window_height = GAME_WIDTH, GAME_HEIGHT
local canvas = lg.newCanvas(GAME_WIDTH,GAME_HEIGHT)

function love.load()
end

function love.update()
end

function love.draw()
  lg.setCanvas(canvas)
  lg.setColor(0.15, 0.20, 0.85)
  lg.rectangle('fill', 0, 0, 1600, 900)
  lg.setColor(0.90, 1.00, 0.90)
  lg.print('Welcome to the warmup weekend!', 400, 400, 0, 4)
  local fps = love.timer.getFPS()
  lg.print('FPS: ' .. fps, 50, 40, 0, 3)
  lg.setCanvas()
  local stretchX = window_width / GAME_WIDTH
  local stretchY = window_height / GAME_HEIGHT
  lg.draw(canvas, 0, 0, 0, stretchX, stretchY)
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
