local player = {dir = 0, x = 0, y = 0, z = 0}

local function p3d(p, rotation)
  rotation = rotation or player.dir

  local x = math.sin(rotation)*p.x 	 + 0   +	math.sin(rotation+math.pi/2)*p.z
  local y = math.cos(rotation)*p.x/2 + p.y +	math.cos(rotation+math.pi/2)*p.z/2

  local f = math.cos(rotation)*p.x 	 + p.y +	math.cos(rotation+math.pi/2)*p.z

  return x,y,z
end

function player.draw()
	local x,y,f = p3d({x=0, y=0, z=0}) --creates the local variable, outputs dont get used
	love.graphics.translate(player.x, player.z/2-24+player.y)

	--[[ Legs ]]
  love.graphics.setColour(0.8*0.8,0.6*0.8,0.3*0.8)
  x,y,f = p3d({x=6, y=12, z=0}, player.dir+math.pi/2)
  love.graphics.rectangle("fill", x-4, y, 8, 12)
  x,y,f = p3d({x=6, y=12, z=0}, player.dir-math.pi/2)
  love.graphics.rectangle("fill", x-4, y, 8, 12)

  --[[ Back Arm ]]
  love.graphics.setColour(0.3*0.9,0.6*0.9,0.8*0.9)
  x,y,f = p3d({x=20, y=0, z=0}, (player.dir % math.pi)+math.pi/2)
  love.graphics.rectangle("fill", x-4, y, 8, 12)
 
  --[[ Body ]]
  love.graphics.setColour(0.3,0.6,0.8)
  love.graphics.ellipse("fill", 0, 0, 20, 19)

  --[[ Front Arm ]]
  love.graphics.setColour(0.3*0.9,0.6*0.9,0.8*0.9)
  x,y,f = p3d({x=20, y=0, z=0}, (player.dir % math.pi)-math.pi/2)
  love.graphics.rectangle("fill", x-4, y, 8, 12)
  --pprint(f,x,y)

  --[[ Back Eyes ]]
  love.graphics.setColour(0.13,0.13,0.13)
  x,y,f = p3d({x=16, y=-20, z=0}, (player.dir)-14/180*math.pi)
  love.graphics.ellipse("fill", x, y, 2.5, 5)
  x,y,f = p3d({x=16, y=-20, z=0}, (player.dir)+14/180*math.pi)
  love.graphics.ellipse("fill", x, y, 2.5, 5)

  --[[ Head ]]
  love.graphics.setColour(0.9,0.7,0.6)
  love.graphics.ellipse("fill", 0, 0-20, 20/1.2, 19/1.2)

  --[[ Front Eyes ]]
  love.graphics.setColour(0.13,0.13,0.13)
  if player.dir-14/180*math.pi < math.pi/2 and player.dir-14/180*math.pi > -math.pi/2 then
    x,y,f = p3d({x=16, y=-20, z=0}, (player.dir)-14/180*math.pi)
    love.graphics.ellipse("fill", x, y, 2.5, 5)
  end
  if player.dir+14/180*math.pi < math.pi/2 and player.dir+14/180*math.pi > -math.pi/2 then
    x,y,f = p3d({x=16, y=-20, z=0}, (player.dir)+14/180*math.pi)
    love.graphics.ellipse("fill", x, y, 2.5, 5)
  end
  
  love.graphics.translate(-player.x, -(player.z/2-24+player.y))
end

function player.update()
  if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
    player.x = player.x - 2
  end
  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
    player.x = player.x + 2
  end
  if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
    player.z = player.z - 2
  end
  if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
    player.z = player.z + 2
  end
end

return player