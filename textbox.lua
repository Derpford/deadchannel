-- Textbox library by Chris Scott
function newTextbox(x,y,w,h,text,time)
  tempBox = {}
  tempBox.x,tempBox.y=x,y
  tempBox.w,tempBox.h=w,h
  tempBox.text=text
  tempBox.time=time or nil
  tempBox.pointer=1
  table.insert(textBoxes, tempBox)
end

function queueTextbox(x,y,w,h,text,time,simul)
  tempBox = {}
  tempBox.x,tempBox.y=x,y
  tempBox.w,tempBox.h=w,h
  tempBox.text=text
  tempBox.time=time
  tempBox.pointer=1
  tempBox.simul=simul or false
  table.insert(textBoxQ, tempBox)
end

function drawTextbox(box)
  love.graphics.setColor(textboxcolor)
  love.graphics.rectangle('fill',box.x,box.y,box.w,box.h)
  love.graphics.setColor(textboxoutlinecolor)
  love.graphics.rectangle('line',box.x,box.y,box.w,box.h)
  love.graphics.setColor(WHITE)
  if type(box.text) == 'table' and type(box.text[box.pointer]) ~= 'function' then -- Check for the table of texts
    if box.text[box.pointer] ~= nil then
      love.graphics.printf(box.text[box.pointer],
      box.x+padding,box.y+padding,box.w)
    end
  elseif type(box.text) == 'string' then -- Make sure it's actually a string
    love.graphics.printf(box.text,box.x+2,box.y+2,box.w)
  end
end

function updateTextbox(box,tab,i,dt)
  if box.time ~= nil then
    box.time = box.time - dt
    if box.time <= 0 or box.pointer >= #box.text then
      table.remove(tab,i)
    end
  end
end  

function updateTextQ(box,tab,i,dt)
  if #textBoxes < 1 or box.simul then	
    if box.time ~= nil then
      box.time = box.time - dt
    end
  end
  if box.time <= 0 or box.time == nil then
    if #textBoxes < 1 or box.simul then	
      newTextbox(box.x,box.y,box.w,box.h,box.text)   
      table.remove(tab,i)
    end
  end
  if debug == true then --Debug code.
    if type(box.text) == "string" then
      print("Box queue updating: '" .. box.text .. "' in " .. box.time .. ", simul="..tostring(box.simul))
    else
      print("Box queue updating: 'TABLE ' in " .. box.time .. ", simul="..tostring(box.simul))
    end
  end
end  

function keypressTextbox(box,tab,i,key)
  if type(box.text) == 'table' then
    if box.pointer < #box.text and key=='z' then
      box.pointer = box.pointer + 1
      if type(box.text[box.pointer]) == 'function' then
	box.text[box.pointer]()
	box.pointer = box.pointer + 1
      end
    elseif key=='z' then
      table.remove(tab,i)
    end
  elseif key=='z' then
    table.remove(tab,i)
  end
end


