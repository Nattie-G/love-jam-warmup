local TileMT = {
  gx = 0,
  gy = 0,
  x = 0,
  y = 0,
  w = 60,
  h = 45,
  color = {0, 1, 1},
}

TileMT.__index = TileMT

function TileMT:new(options)
  return setmetatable(options, self)
end

function TileMT:update(dt)
end

return TileMT
