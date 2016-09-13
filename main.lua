-- LOVE2D game inspired by Ennuigi
hc = require "HC"
require "textbox"
-- First, variables. Make some here.

textboxcolor = {112,128,100}
textboxoutlinecolor = {56,64,50}
textredcolor = {255,64,64}
WHITE = {255,255,255}
padding = 2

textBoxes = {} -- The table for textboxes.
textBoxQ = {} -- The table for queued textboxes.

-- custom functions
 
-- callbacks

function love.load()
  newTextbox(4,4,200,32,{"This is a test","Nothing to see here",
  {WHITE,"I'm not gonna do anything ",textredcolor,"special",WHITE," or anything"}})
  queueTextbox(4,36,100,32,"For reals",1) 
  queueTextbox(132,48,100,32,"Really?",2)
  queueTextbox(4,60,100,32,{"Really.","Goodbye."},0.5)
  queueTextbox(132,72,50,32,"But--",1)
  queueTextbox(4,70,50,32,"No.",0.2,true)
  queueTextbox(4,80,55,32,"Sheesh.",0.5,false,1.5)
  table.insert(textBoxes,newBox)
end

function love.update(dt)
  for i in ipairs(textBoxes) do
    updateTextbox(textBoxes[i],textBoxes,i,dt)
  end
  if textBoxQ[1] ~= nil then
    updateTextQ(textBoxQ[1],textBoxQ,1,dt)
  end
end

function love.keypressed(key,scan,rep)
  if key == 'q' then
    love.event.quit()
  end
  if not rep then
    for i in ipairs(textBoxes) do
      keypressTextbox(textBoxes[i],textBoxes,i,key)
    end
  end 
end

function love.draw()
  for i in ipairs(textBoxes) do
    drawTextbox(textBoxes[i])
  end
end
