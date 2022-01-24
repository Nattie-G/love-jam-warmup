local intro = {length = 1.5, sustain = 0.2}
local lg = love.graphics

intro.cursor = love.mouse.getSystemCursor("hand")

function intro.easeOutElastic(x)
  local c4 = (2 * math.pi) / 2.3 -- edit "2.3" for effect
  return math.pow(2, -18 * x) * math.sin((x * 10 - 0.75) * c4) + 1 -- edit "-18" for effect
end

function intro.easeInSine(x)
  return 1 - math.cos((x * math.pi) / 2);
end

function intro:init(h2text)
  self.h1 = {}
  self.h1.font = love.graphics.newFont("fonts/Anton-Regular.ttf", 140)
  self.h1.x = love.graphics.getWidth()/2.0
  self.h1.y = 0

  self.h2 = {}
  self.h2.font = love.graphics.newFont("fonts/Anton-Regular.ttf", 90)
  self.h2.text = h2text or "Presents"
  self.h2.x = lg.getWidth()/2 - self.h2.font:getWidth(self.h2.text)/2.0
  self.h2.y = lg.getHeight()/1.58

  self.timer = 0
  self.phase = 0
  self.ghost = 1

  --[[Creates Australian-English translations of the colour functions]]
  love.graphics.getBackgroundColour = love.graphics.getBackgroundColor
  love.graphics.getColour           = love.graphics.getColor
  love.graphics.getColourMask       = love.graphics.getColorMask
  love.graphics.getColourMode       = love.graphics.getColorMode
  love.graphics.setBackgroundColour = love.graphics.setBackgroundColor
  love.graphics.setColour           = love.graphics.setColor
  love.graphics.setColourMask       = love.graphics.setColorMask
  love.graphics.setColourMode       = love.graphics.setColorMode
end

function intro:update(dt)
  if not dt then
    error("dt is required for intro.update(dt)")
  end

  self.timer = self.timer + dt

  self.h1.x = love.graphics.getWidth()/2.0
  self.h1.y = 0
  self.h2.x = lg.getWidth()/2 - self.h2.font:getWidth(self.h2.text)/2.0
  self.h2.y = lg.getHeight()/1.58
  
  if self.timer > self.length then
    self.phase = 2
  end
  if self.phase == 2 then
    self.ghost = self.ghost -dt/self.sustain
  end
  if self.timer > self.length + self.sustain then
    self.phase = 3
  end
end

function intro:draw()
  if self.phase < 3 then
    local r,g,b,a = love.graphics.getColour()
    local font = love.graphics.getFont()

    love.graphics.setColor(0.17, 0.17, 0.17, self.ghost)
    lg.setColor(love.math.colorFromBytes(232, 170, 55))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(1, 1, 1, 1 - math.pow(1 - self.timer, 5))
    love.graphics.setFont(self.h1.font)
    love.graphics.print(
        "Nattie-G",
        self.h1.x - self.h1.font:getWidth("Nattie-G")/2,
            0.85 * love.graphics.getHeight()/2 - self.h1.font:getHeight()/2
    )
    love.graphics.setFont(self.h2.font)
    love.graphics.print(
        self.h2.text,
        self.h2.x,
        0.90 * --self.easeOutElastic(self.timer)*
        self.h2.y - self.h2.font:getHeight()/2
    )

    love.graphics.setColor(0.2, 0.2, 0.2, self.ghost)
    love.graphics.setColour(r,g,b,a)
    love.graphics.setFont(font)
    love.graphics.rectangle(
        "fill",
        0,
        love.graphics.getHeight()-5,
        ((love.graphics.getWidth())/self.length*self.timer),
        5
    )
    
    love.graphics.setColour(0, 0, 0, intro.easeInSine(self.timer))
    love.graphics.rectangle(
      'fill',
      0,
      0,
      lg.getWidth(),
      lg.getHeight()
    )

  end
end

function intro.distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2-y1)^2 + (x2-x1)^2)
end


return intro
