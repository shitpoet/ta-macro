-- simple macro recordig module for Textadept 7.9
-- written by: shitpoet@gmail.com

local M = {}

local recording_macro = false
local macro = {}

function M.record()
  macro = {}
  recording_macro = true
  ui.statusbar_text = 'recording macro'
end

function M.finish() 
  if recording_macro then
    recording_macro = false
    ui.statusbar_text = 'macro recorded'
  end
end

function M.replay()
  --ui.statusbar_text = 'replay macro'
  events.emit(events.KEYPRESS, 27, nil, nil, nil, nil)
  for k,cmd in pairs(macro) do
    cmd[1](table.unpack(cmd[2]))
  end
end

--function M.print()
--  for _,v in pairs(macro) do
--    print(unpack(vv))
--  end
--end

events.connect(events.KEYPRESS, function(code, shift, control, alt, meta)
  --print('MACRO - KEYPRESS')
  if recording_macro then
    table.insert(macro, {events.emit, {events.KEYPRESS, code, shift, control, alt, meta}})
  end  
end, 1)

-- special case for navigation keys needed
-- if they dont have commands associated (default)
-- (i commented this out and just forcely associate commands
-- to nav keys below)
--events.connect(events.KEYPRESS, function(code, shift, control, alt, meta)
--  --print('MACRO - AFTER KEYPRESS')
--  if recording_macro then
--    sym = keys.KEYSYMS[code]
--    if sym == 'left' then
--      table.insert(macro, {buffer.char_left, {}}) 
--    elseif sym == 'right' then
--      table.insert(macro, {buffer.char_right, {}})     
--    elseif sym == 'up' then
--      table.insert(macro, {buffer.line_up, {}})     
--    elseif sym == 'down' then   
--      table.insert(macro, {buffer.line_down, {}})         
--    end  
--  end  
--end)

-- record chars
events.connect(events.CHAR_ADDED, function(byte)
  --print('MACRO - CHAR_ADDED',byte)
  if recording_macro then
    table.insert(macro, {buffer.add_text, {string.char(byte)}})
  end
end) 
  
-- assign navigation keys to commands for proper recording
keys.left = buffer.char_left
keys.left = buffer.char_left
keys.sleft = buffer.char_left_extend
keys.cleft = buffer.word_left
keys.csleft = buffer.word_left_extend
keys.right = buffer.char_right
keys.sright = buffer.char_right_extend
keys.cright = buffer.word_right
keys.csright = buffer.word_right_extend
keys.up = buffer.line_up  
keys.sup = buffer.line_up_extend  
keys.down = buffer.line_down
keys.sdown = buffer.line_down_extend
keys.home = buffer.home
keys.shome = buffer.home_extend
keys['end'] = buffer.line_end
keys.send = buffer.line_end_extend
keys['\b'] = buffer.delete_back
keys['c\b'] = buffer.del_word_left
keys.del = buffer.clear
keys.cdel = buffer.del_word_right

return M