local laptopScreen = "Built-in Retina Display"

hs.window.animationDuration = 0

hs.hotkey.bind({"cmd", "alt"}, "F", function()
  local win = hs.window.focusedWindow()
  win:setFrame(win:screen():frame())
end)

hs.hotkey.bind({"cmd", "alt"}, "Left", function()
  local win = hs.window.focusedWindow()
  send("left", win)
end)

hs.hotkey.bind({"cmd", "alt"}, "Right", function()
  local win = hs.window.focusedWindow()
  send("right", win)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win = hs.window.focusedWindow()
  sendToStack("left", win)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  sendToStack("right", win)
end)

-- "left"|"right" -> index -> win
stacks = {left={}, right={}}

function renderStacks()
  for name, s in pairs(stacks) do
    renderStack(s, name)
  end
end

function send(name, win)
  local screen = win:screen()
  local max = screen:frame()

  -- if a window is in the other stack, remove it.
  _, other = selectStack(name)
  if contains(other, win) then
    table.remove(other, find(win, other))
    renderStacks()
  end

  local f = win:frame()

  local leftPad = 0
  if name == "right" then
    leftPad = (max.w / 2)
  end

  f.x = max.x + leftPad
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

function sendToStack(name, win)
  stack, other = selectStack(name)

  -- if a window is in the other stack, remove it.
  if contains(other, win) then
    table.remove(other, find(win, other))
  end
  -- if the window is already in this stack, cycle it.
  if contains(stack, win) then
    shift(stack)
  else
    -- otherwise, add it to the stack.
    table.insert(stack, win)
  end
  renderStacks()
end

function renderStack(stack, name)
  local count = #stack
  for i, win in pairs(stack) do
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()
    local leftPad = 0
    if name == "right" then
      leftPad = (max.w / 2)
    end
    local h = max.h / count
    f.x = max.x + leftPad
    f.y = max.y + (h * (i-1))
    f.w = max.w / 2
    f.h = h
    win:setFrame(f)
  end
end

-- returns stack, other
function selectStack(name)
  local stacks = shallowcopy(stacks)
  local stack = remove(stacks, name)
  local other = stacks[next(stacks)]
  return stack, other
end

function contains(stack, win)
  for i, v in pairs(stack) do
    if v == win then
      return true
    end
  end
  return false
end

function find(win, stack)
  for i, w in pairs(stack) do
    if w == win then
      return i
    end
  end
  return -1
end

function shift(stack)
  first = table.remove(stack, 1)
  table.insert(stack, first)
  return stack
end

function shallowcopy(table)
  local result = {}
  for k, v in pairs(table) do
    result[k] = v
  end
  return result
end

function remove(table, key)
  v = table[key]
  table[key] = nil
  return v
end
