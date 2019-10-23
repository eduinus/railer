local robot = require("robot")
local term = require("term")
local os = require("os")
local component = require("component")
local sides = require("sides")
local keyboard = require("keyboard")
local computer = require("computer")

function tableLength(table)
  count = 1
  while table[count] ~= nil do
    count=count+1
  end
  return count-1
end

function move()
	swung = false
	while robot.detect() do
		robot.select(1) robot.swing()
    swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      robot.select(1)
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.place()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.drop() == false do end
  	        end
  	      robot.select(3) robot.swing()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(3) robot.place() robot.select(1)
			while component.generator.count() < 64 do robot.suck(64-component.generator.count()) component.generator.insert() end
			robot.select(3) robot.swing()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end

	while robot.forward() ~= true do end
  return swung
end

function moveUp()
	swung = false
	while robot.detectUp() do
		robot.select(1) robot.swingUp()
    swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      robot.select(1)
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.placeUp()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropUp() == false do end
  	        end
  	      robot.select(3) robot.swingUp()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(3) robot.placeUp() robot.select(1)
			while component.generator.count() < 64 do robot.suckUp(64-component.generator.count()) component.generator.insert() end
			robot.select(3) robot.swingUp()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end

	while robot.up() ~= true do end
  return swung
end

function moveDown()
	swung = false
	while robot.detectDown() do
		robot.select(1) robot.swingDown()
    swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      robot.select(1)
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.placeDown()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropDown() == false do end
  	        end
  	      robot.select(3) robot.swingDown()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(3) robot.placeDown() robot.select(1)
			while component.generator.count() < 64 do robot.suckDown(64-component.generator.count()) component.generator.insert() end
			robot.select(3) robot.swingDown()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end

	while robot.down() ~= true do end
  return swung
end

function moveBack()
	swung = false
	if robot.back() ~= true then
		robot.turnAround()
		swung = true
		robot.select(1)
		while robot.detect() do
			robot.swing()
			os.sleep(0.2)
    	invCount = robot.inventorySize() -- check if need to dump garbage
    	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
    		robot.select(1)
    		while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
    			if invCount == itemArray[tableLength(itemArray)][1]+1 then
    				robot.select(3) robot.place()
    				for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
    					robot.select(x)
    					while robot.drop() == false do end
    				end
    				robot.select(3) robot.swing()
    				invCount = robot.inventorySize()
    			else
    				invCount = invCount - 1
    			end
    		end
    		robot.select(1)
    		robot.transferTo(invCount)
    	end
		end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(3) robot.place() robot.select(1)
			while component.generator.count() < 64 do robot.suck(64-component.generator.count()) component.generator.insert() end
			robot.select(3) robot.swing()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end

	if swung == true then
		robot.turnAround()
	    while robot.back() ~= true do end
    end
	return swung
end

function dig()
  while robot.detect() do
		robot.select(1) robot.swing()
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.place()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.drop() == false do end
  	        end
  	      robot.select(3) robot.swing()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(3) robot.place() robot.select(1)
			while component.generator.count() < 64 do robot.suck(64-component.generator.count()) component.generator.insert() end
			robot.select(3) robot.swing()
			end
			term.clearLine()
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
end

function digDown()
	while robot.detectDown() do
		robot.select(1) robot.swingDown()
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.placeDown()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropDown() == false do end
  	        end
  	      robot.select(3) robot.swingDown()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(3) robot.placeDown() robot.select(1)
			while component.generator.count() < 64 do robot.suckDown(64-component.generator.count()) component.generator.insert() end
			robot.select(3) robot.swingDown()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
end

function digUp()
	while robot.detectUp() do
		robot.select(1) robot.swingUp()
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.placeUp()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropUp() == false do end
  	        end
  	      robot.select(3) robot.swingUp()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	if computer.energy() / computer.maxEnergy() <= 0.025 then
		while computer.energy() / computer.maxEnergy() <= 0.975 do
			if component.generator.count() < 1 then -- refuel
				print("Refueling!")
				robot.select(3) robot.placeUp() robot.select(1)
			while component.generator.count() < 64 do robot.suckUp(64-component.generator.count()) component.generator.insert() end
			robot.select(3) robot.swingUp()
			end
			print("Charging... "..computer.energy())
			os.sleep(10)
		end
		print("Charged: "..computer.energy())
	end
end

itemArray = {}
	-- SLOT 1 FOR PICK (ideally infinipick)
	itemArray[1] = {} itemArray[1][1] = 4 itemArray[1][2] = 2 itemArray[1][3] = 9 itemArray[1][4] = "bricks" -- misc tesseract 1
	itemArray[2] = {} itemArray[2][1] = 5 itemArray[2][2] = 2 itemArray[2][3] = 10 itemArray[2][4] = "smoothBricks" -- misc tesseract 2
	itemArray[3] = {} itemArray[3][1] = 6 itemArray[3][2] = 2 itemArray[3][3] = 11 itemArray[3][4] = "lantern" -- misc tesseract 3
	itemArray[4] = {} itemArray[4][1] = 7 itemArray[4][2] = 2 itemArray[4][3] = 12 itemArray[4][4] = "glass" -- misc tesseract 4
	itemArray[5] = {} itemArray[5][1] = 8 itemArray[5][2] = 2 itemArray[5][3] = 13 itemArray[5][4] = "fence" -- misc tesseract 5
	-- NB SLOT 3 FOR FUEL AND TRASH TELE

function place(blockName)
	swung = false
	while robot.detect() do -- check for blockage
		robot.select(1) robot.swing()
		swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.place()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.drop() == false do end
  	        end
  	      robot.select(3) robot.swing()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	for blocki=1, tableLength(itemArray) do -- need to restock?
		if itemArray[blocki][4] == blockName then
			if component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil then
				if blockName ~= "stoneBrick" then
					robot.select(itemArray[blocki][2])
					robot.place()
					print("Restocking "..itemArray[blocki][4]..".")
					robot.select(itemArray[blocki][1])
					component.inventory_controller.suckFromSlot(3,itemArray[blocki][3],(component.inventory_controller.getSlotMaxStackSize(3,itemArray[blocki][3])-1))
					robot.select(itemArray[blocki][2]) robot.swing() os.sleep(0.2)
				else
					if itemArray[blocki][1]<16 then
						while component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil and itemArray[blocki][1]<16 do
							itemArray[blocki][1] = itemArray[blocki][1] + 1
						end
					else
						itemArray[blocki][1] = 6
						robot.select(itemArray[blocki][2])
						robot.place()
						print("Restocking "..itemArray[blocki][4]..".")
						for stonei=itemArray[blocki][1], 16 do
							robot.select(stonei)
							component.inventory_controller.suckFromSlot(3,9,64)
							while component.inventory_controller.getSlotStackSize(3,9)<component.inventory_controller.getSlotMaxStackSize(3,9) do os.sleep(1) end
						end
						robot.select(itemArray[blocki][2]) robot.swing() os.sleep(0.2)
					end
				end
			end
			robot.select(itemArray[blocki][1])
		end
	end

	if blockName == "ladder" then
		if robot.place(3) == false then robot.place() end
	else
		if robot.place(0) == false then robot.place() end
	end

	return swung
end

function placeUp(blockName)
	swung = false
	while robot.detectUp() do -- check for blockage
		robot.select(1) robot.swingUp()
		swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.placeUp()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropUp() == false do end
  	        end
  	      robot.select(3) robot.swingUp()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	for blocki=1, tableLength(itemArray) do -- need to restock?
	  if itemArray[blocki][4] == blockName then
	    if component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil then
	      if blockName ~= "stoneBrick" then
  	      robot.select(itemArray[blocki][2])
  	      robot.placeUp()
  	      print("Restocking "..itemArray[blocki][4]..".")
  	      robot.select(itemArray[blocki][1])
  	      component.inventory_controller.suckFromSlot(1,itemArray[blocki][3],(component.inventory_controller.getSlotMaxStackSize(1,itemArray[blocki][3])-1))
  	      robot.select(itemArray[blocki][2]) robot.swingUp() os.sleep(0.2)
  	    else
  	      if itemArray[blocki][1]<16 then
            while component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil and itemArray[blocki][1]<16 do
              itemArray[blocki][1] = itemArray[blocki][1] + 1
            end
  	      else
  	        itemArray[blocki][1] = 6
  	        robot.select(itemArray[blocki][2])
  	        robot.placeUp()
  	        print("Restocking "..itemArray[blocki][4]..".")
  	        for stonei=itemArray[blocki][1], 16 do
  	          robot.select(stonei)
  	          while component.inventory_controller.getSlotStackSize(1,9)<component.inventory_controller.getSlotMaxStackSize(1,9) do os.sleep(1) end
  	          component.inventory_controller.suckFromSlot(1,9,64)
  	        end
  	      robot.select(itemArray[blocki][2]) robot.swingUp() os.sleep(0.2)
  	      end
  	    end
	    end
	  robot.select(itemArray[blocki][1])
	  end
	end
	if robot.placeUp(1) == false then robot.placeUp() end
	return swung
end

function placeDown(blockName)
	swung = false
	while robot.detectDown() do -- check for blockage
		robot.select(1) robot.swingDown()
		swung = true
  	invCount = robot.inventorySize() -- check if need to dump garbage
  	if component.inventory_controller.getStackInInternalSlot(1) ~= nil then
      while component.inventory_controller.getStackInInternalSlot(invCount) ~= nil and (robot.compareTo(invCount) == false or component.inventory_controller.getStackInInternalSlot(invCount).size == component.inventory_controller.getStackInInternalSlot(invCount).maxSize) do
  	    if invCount == itemArray[tableLength(itemArray)][1]+1 then
  	      robot.select(3) robot.placeDown()
  	        for x=itemArray[tableLength(itemArray)][1]+1, robot.inventorySize() do
  	          robot.select(x)
  	          while robot.dropDown() == false do end
  	        end
  	      robot.select(3) robot.swingDown()
  	      invCount = robot.inventorySize()
  	    else invCount = invCount - 1
  	    end
  	  end
      robot.select(1)
      robot.transferTo(invCount)
  	end
	end

	for blocki=1, tableLength(itemArray) do -- need to restock?
	  if itemArray[blocki][4] == blockName then
	    if component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil then
	      if blockName ~= "stoneBrick" then
  	      robot.select(itemArray[blocki][2])
  	      robot.placeDown()
  	      print("Restocking "..itemArray[blocki][4]..".")
  	      robot.select(itemArray[blocki][1])
  	      component.inventory_controller.suckFromSlot(0,itemArray[blocki][3],(component.inventory_controller.getSlotMaxStackSize(0,itemArray[blocki][3])-1))
  	      robot.select(itemArray[blocki][2]) robot.swingDown() os.sleep(0.2)
  	    else
  	      if itemArray[blocki][1]<16 then
            while component.inventory_controller.getStackInInternalSlot(itemArray[blocki][1]) == nil and itemArray[blocki][1]<16 do
              itemArray[blocki][1] = itemArray[blocki][1] + 1
            end
  	      else
  	        itemArray[blocki][1] = 6
  	        robot.select(itemArray[blocki][2])
  	        robot.placeDown()
  	        print("Restocking "..itemArray[blocki][4]..".")
  	        for stonei=itemArray[blocki][1], 16 do
  	          robot.select(stonei)
  	          while component.inventory_controller.getSlotStackSize(0,9)<component.inventory_controller.getSlotMaxStackSize(0,9) do os.sleep(1) end
  	          component.inventory_controller.suckFromSlot(0,9,64)
  	        end
  	      robot.select(itemArray[blocki][2]) robot.swingDown() os.sleep(0.2)
  	      end
  	    end
	    end
	  robot.select(itemArray[blocki][1])
	  end
	end
	if blockName == "log" then
		if robot.placeDown(3) == false then
			if robot.placeDown(2) == false then
				robot.placeDown()
			end
		end
	elseif blockName == "torch" then
		torchI = 2
		while torchI <=5 and robot.placeDown(torchI) == false do
			torchI = torchI + 1
		end
		if torchI == 6 then
			robot.placeDown()
		end
	else
		if robot.placeDown(0) == false then
			robot.placeDown()
		end
	end
	return swung
end

function checkGlass() -- moves robot into chunk, checks if it should be glassed
	for i=1, 2 do move() end
	moveUp()
	robot.turnRight()
	move()
	rwGlass = true
	for checker=1, 7 do -- right window
		if robot.detect() then rwGlass = false end
		moveUp()
		if robot.detect() then rWGlass = false end
		robot.turnLeft()
		move()
		robot.turnRight()
		if robot.detect() then rwGlass = false end
		moveDown()
		if robot.detect() then rwGlass = false end
		if checker < 7 then
			robot.turnLeft()
			move()
			robot.turnRight()
		end
	end
	for i=1, 3 do moveBack() end
	for i=1, 2 do moveDown() end
	robot.turnAround()
	bwGlass = true
	for checker=1, 7 do -- bottom window
		if robot.detectDown() then bwGlass = false end
		move()
		if robot.detectDown() then bwGlass = false end
		robot.turnLeft()
		move()
		robot.turnRight()
		if robot.detectDown() then bwGlass = false end
		moveBack()
		if robot.detectDown() then bwGlass = false end
		if checker < 7 then
			robot.turnLeft()
			move()
			robot.turnRight()
		end
	end
	for i=1, 2 do moveUp() end
	for i=1, 4 do move() end
	lwGlass = true
	for checker=1, 7 do -- left window
		if robot.detect() then lwGlass = false end
		moveUp()
		if robot.detect() then lwGlass = false end
		robot.turnRight()
		move()
		robot.turnLeft()
		if robot.detect() then lwGlass = false end
		moveDown()
		if robot.detect() then lwGlass = false end
		if checker < 7 then
			robot.turnRight()
			move()
			robot.turnLeft()
		end
	end
	robot.turnAround()
	for i=1, 3 do move() end
	for i=1, 4 do moveUp() end
	twGlass = true
	for checker=1, 7 do -- top window
		if robot.detectUp() then twGlass = false end
		move()
		if robot.detectUp() then twGlass = false end
		robot.turnRight()
		move()
		robot.turnRight()
		if robot.detectUp() then twGlass = false end
		move()
		if robot.detectUp() then twGlass = false end
		if checker < 7 then
			robot.turnLeft()
			move()
			robot.turnLeft()
		end
	end
	robot.turnAround()
	for i=1, 5 do moveDown() end
	for i=1, 3 do move() end
	robot.turnRight()
	move()
	robot.turnAround()
	return rwGlass,	bwGlass, lwGlass, twGlass
end

function endBitUp()
	placeDown("smoothBricks")
	place("smoothBricks")
	for i=1, 3 do
		moveUp()
		place("smoothBricks")
	end
	placeUp("smoothBricks")
end

function endBitDown()
	placeUp("smoothBricks")
	for i=1, 3 do
		place("smoothBricks")
		moveDown()
	end
	place("smoothBricks")
	placeDown("smoothBricks")
end

function wallBitUp(win)
	placeDown("bricks")
	place("smoothBricks")
	for i=1, 2 do
		moveUp()
		if win then
			place("glass")
		else
			place("bricks")
		end
	end
	moveUp()
	place("smoothBricks")
	placeUp("smoothBricks")
end

function wallBitDown(win)
	placeUp("smoothBricks")
	place("smoothBricks")
	moveDown()
	for i=1, 2 do
		if win then
			place("glass")
		else
			place("bricks")
		end
		moveDown()
	end
	place("smoothBricks")
	placeDown("bricks")
end

function midBitUp(topWin, botWin, lamp)
	if botWin then
		placeDown("glass")
	else
		placeDown("bricks")
	end
	move()
	if lamp then
		placeDown("lantern")
	else
		placeDown("smoothBricks")
	end
	robot.turnAround()
	for i=1, 4 do
		moveUp()
		if robot.detect() then
			dig()
		end
	end
	if lamp then
		placeUp("lantern")
	else
		placeUp("smoothBricks")
	end
	move()
	if topWin then
		placeUp("glass")
	else
		placeUp("bricks")
	end
	robot.turnAround()
end

function midBitDown(topWin, botWin, lamp)
	if topWin then
		placeUp("glass")
	else
		placeUp("bricks")
	end
	move()
	if lamp then
		placeUp("lantern")
	else
		placeUp("smoothBricks")
	end
	robot.turnAround()
	for i=1, 4 do
		moveDown()
		if robot.detect() then
			dig()
		end
	end
	if lamp then
		placeDown("lantern")
	else
		placeDown("smoothBricks")
	end
	move()
	if botWin then
		placeDown("glass")
	else
		placeDown("bricks")
	end
	robot.turnAround()
end

function endMidBitUp()
	placeDown("smoothBricks")
	move()
	placeDown("smoothBricks")
	robot.turnAround()
	for i=1, 4 do
		moveUp()
		if robot.detect() then
			dig()
		end
	end
	placeUp("smoothBricks")
	move()
	placeUp("smoothBricks")
	robot.turnAround()
end

function endMidBitDown()
	placeUp("smoothBricks")
	move()
	placeUp("smoothBricks")
	robot.turnAround()
	for i=1, 4 do
		moveDown()
		if robot.detect() then
			dig()
		end
	end
	placeDown("smoothBricks")
	move()
	placeDown("smoothBricks")
	robot.turnAround()
end

function light(test)
  if test == 1 or test == 4 or test == 7 or test == 8 or test == 11 or test == 14 then
    return true
  else
    return false
  end
end

function fence(glassBottom)
	for fenceI=1, 15 do
		moveBack()
		if fenceI == 1,3,4,6,7,10,11,13,14 then
			place("fence")	
		end
	end
		robot.turnRight()
		moveBack()
		place("fence")
		moveBack()
		if glassBottom then
			moveBack()
			place("fence")
			moveBack()
			place("fence")
			moveBack()
		else
			robot.turnRight()
			for i=1, 15 do
				moveBack()
				if fenceI == 1,3,4,6,7,10,11,13,14 then
					place("fence")	
				end
			end
			robot.turnLeft()
			moveBack()
			robot.turnLeft()
			for i=1, 15 do
				moveBack()
				if fenceI == 1,3,4,6,7,10,11,13,14 then
					place("fence")	
				end
			end
			robot.turnRight()
			moveBack()
			place("fence")
			moveBack()
		end
	robot.turnRight()
	for fenceI=1, 15 do
		moveBack()
		if fenceI == 1,3,4,6,7,10,11,13,14 then
			place("fence")	
		end
	end
	robot.turnRight()
	moveBack()
	place("fence")
	moveBack()
	moveBack()
	place("fence")
	moveBack()
	place("fence")
	moveBack()
	robot.turnRight()
end

-- Begin
term.clear()
print("Press space to confirm that robot is facing in the direction of the wall, on the block before the first iteration, on the rightmost side.")
while not keyboard.isKeyDown(keyboard.keys.space) do os.sleep(0.1) end
term.clear()

print("How many chunks do you want to build for?")
tunnelLengthChunks = io.read()

os.sleep(1)
term.clear()

print("Robot Inventory Instructions:")
print("1 - Pickaxe (Preferably w/o Durability)")
print("2 - Item Transceiver")
print("3 - Trash/Fuel Transceiver")
print("4+ - No need to load!")

print(" ")
print("--- Press Enter When Ready to Begin ---")
while not keyboard.isKeyDown(keyboard.keys.enter) do os.sleep(0.1) end
term.clear()
robot.select(1)
component.inventory_controller.equip()
print("Building...")

-- Begin walling sequence

for iterate=1, tunnelLengthChunks do
  rWindow, bWindow, lWindow, tWindow = checkGlass()
  print("Chunk 1: ".."rWindow: "..tostring(rWindow).." ".."bWindow: "..tostring(bWindow).." ".."lWindow: "..tostring(lWindow).." ".."tWindow: "..tostring(tWindow))
  robot.turnRight()

  endBitUp()
  robot.turnLeft()
  move()
  robot.turnRight()
  for i=1, 7 do
    wallBitDown(rWindow)
    robot.turnLeft()
    move()
    robot.turnRight()
    wallBitUp(rWindow)
    robot.turnLeft()
    move()
    robot.turnRight()
  end
  endBitDown()

  for i=1, 2 do moveBack() end
  endMidBitUp()
  robot.turnRight()
  move()
  robot.turnLeft()
  for aye=1, 14 do
    if aye % 2 ~= 0 then
      midBitDown(tWindow,bWindow,light(aye))
      robot.turnRight()
      move()
      robot.turnLeft()
    else
      midBitUp(tWindow,bWindow,light(aye))
      robot.turnRight()
      move()
      robot.turnLeft()
    end
  end
  endMidBitDown()

  robot.turnAround()
  move()
  endMidBitUp()
  robot.turnRight()
  move()
  robot.turnLeft()
  for aye=1, 14 do
    if aye % 2 ~= 0 then
      midBitDown(tWindow,bWindow,light(aye))
      robot.turnRight()
      move()
      robot.turnLeft()
    else
      midBitUp(tWindow,bWindow,light(aye))
      robot.turnRight()
      move()
      robot.turnLeft()
    end
  end
  endMidBitDown()

  for i=1, 2 do move() end
  endBitUp()
  robot.turnLeft()
  move()
  robot.turnRight()
  for i=1, 7 do
    wallBitDown(lWindow)
    robot.turnLeft()
    move()
    robot.turnRight()
    wallBitUp(lWindow)
    robot.turnLeft()
    move()
    robot.turnRight()
  end
  endBitDown()

  robot.turnAround()
  for i=1, 5 do move() end
  robot.turnLeft()
  for i=1, 15 do move() end
  fence(bWindow)
end

computer.shutdown()
