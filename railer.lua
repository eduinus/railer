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
	itemArray[1] = {} itemArray[1][1] = 6 itemArray[1][2] = 2 itemArray[1][3] = 9 itemArray[1][4] = "stoneBrick" -- stone tesseract
	itemArray[2] = {} itemArray[2][1] = 17 itemArray[2][2] = 3 itemArray[2][3] = 9 itemArray[2][4] = "stoneSlab" -- misc tesseract 1
	itemArray[3] = {} itemArray[3][1] = 18 itemArray[3][2] = 3 itemArray[3][3] = 10 itemArray[3][4] = "torch" -- misc tesseract 2
	itemArray[4] = {} itemArray[4][1] = 19 itemArray[4][2] = 3 itemArray[4][3] = 11 itemArray[4][4] = "plank" -- misc tesseract 3
	itemArray[5] = {} itemArray[5][1] = 20 itemArray[5][2] = 3 itemArray[5][3] = 12 itemArray[5][4] = "plankSlab" -- misc tesseract 4
	itemArray[6] = {} itemArray[6][1] = 21 itemArray[6][2] = 3 itemArray[6][3] = 13 itemArray[6][4] = "ironDoor" -- misc tesseract 5
	itemArray[7] = {} itemArray[7][1] = 22 itemArray[7][2] = 3 itemArray[7][3] = 14 itemArray[7][4] = "ironWindow" -- misc tesseract 6 -frameless
	itemArray[8] = {} itemArray[8][1] = 23 itemArray[8][2] = 3 itemArray[8][3] = 15 itemArray[8][4] = "button" -- misc tesseract 7
	itemArray[9] = {} itemArray[9][1] = 24 itemArray[9][2] = 3 itemArray[9][3] = 16 itemArray[9][4] = "ladder" -- misc tesseract 8
	-- NB SLOT 4 FOR COAL COKE OR OTHER FUEL TELE
	itemArray[10] = {} itemArray[10][1] = 25 itemArray[10][2] = 5 itemArray[10][3] = 9 itemArray[10][4] = "log" -- misc 2 tesseract 1
	itemArray[11] = {} itemArray[11][1] = 26 itemArray[11][2] = 5 itemArray[11][3] = 10 itemArray[11][4] = "sprucePlank" -- misc 2 tesseract 2
	itemArray[12] = {} itemArray[12][1] = 27 itemArray[12][2] = 5 itemArray[12][3] = 11 itemArray[12][4] = "spruceFence" -- misc 2 tesseract 3
	itemArray[13] = {} itemArray[13][1] = 28 itemArray[13][2] = 5 itemArray[13][3] = 12 itemArray[13][4] = "trapDoor" -- misc 2 tesseract 4

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

-- Begin
term.clear()
print("Press space to confirm that robot is pointed to the right, facing where the right wall will go.")
while not keyboard.isKeyDown(keyboard.keys.space) do os.sleep(0.1) end
term.clear()

print("How many blocks do you want to build for?")
tunnelLength = io.read()

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

for i=1, tunnelLength do
	
end

computer.shutdown()
