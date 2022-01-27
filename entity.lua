local EntityMT = {
  x = 0,
  y = 0,
  gx = 0,
  gy = 0,
  w = 50,
  h = 35,
  color = {1, 0, 1},
}

EntityMT.__index = EntityMT

function EntityMT:new(options)
  return setmetatable(options, self)
end

function EntityMT:update(dt)
end

return EntityMT
