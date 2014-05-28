-- a function calls another as its last action
-- a tail call happens
-- a proper tail call never overflow the stack
function foo (n)
    if n > 0 then return foo(n - 1) end
end

-- This game is a typical state machine
-- We use tail calls to move from one room to another
-- 1  2   
-- 3  4
function room1 ()
    local move = io.read()
    if move == "south" then return room3()
    elseif move == "east" then return room2()
    else return room1() end -- stay in the same room
end
function room2 ()
    local move = io.read()
    if move == "south" then return room4()
    elseif move == "west" then return room1()
    else return room2() end -- stay in the same room
end
function room3 ()
    local move = io.read()
    if move == "north" then return room1()
    elseif move == "east" then return room4()
    else return room3() end -- stay in the same room
end
function room4 ()
    print("Congratulations!")
end

room1()
