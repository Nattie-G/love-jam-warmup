local EntityMT = {
  x = 0,
  y = 0,
  w = 60,
  h = 60,
  color = {1, 0, 1},
}

EntityMT.__index = EntityMT

function EntityMT:new(options)
  return setmetatable(options, self)
end

function EntityMT:update(dt)
end

return EntityMT
