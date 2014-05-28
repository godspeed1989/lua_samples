-- Closure with iterator
function list_iter (t)
    local i = 0
    local n = table.getn(t)
    return function ()
        i = i + 1
        if i <= n then return t[i]
        else return nil end
    end
end

t = {10, 20, 30}

for element in list_iter(t) do
    print(element)
end

-- Closure with iterator
function allwords()
    local line = io.read()
    local pos = 1
    return function ()
        while line do
            local s, e = string.find(line, "%w+", pos)
            if s then
                pos = e + 1
                return string.sub(line, s, e)
            else
                line = io.read()
                pos = 1
            end
        end
        return nil
    end
end
--[[
for word in allwords() do
    print(" " .. word)
end
--]]

function prefix (w1, w2)
    return w1 .. ' ' .. w2
end

local statetab = {}

function insert (index, value)
    if not statetab[index] then
       statetab[index] = {n=0}
    end
    table.insert(statetab[index], value)
end

local N = 2
local MAXGEN = 10000
local NOWORD = "\n"

-- build table
local w1, w2 = NOWORD, NOWORD
for w in allwords() do
    insert(prefix(w1, w2), w)
    w1 = w2; w2 = w;
end
insert(prefix(w1, w2), NOWORD)

-- generate text
w1 = NOWORD; w2 = NOWORD -- reinitialize
for i=1, MAXGEN do
    local list = statetab[prefix(w1, w2)]
    -- choose a random item from list
    math.randomseed(os.time())
    local r = math.random(table.getn(list))
    local nextword = list[r]
    if nextword == NOWORD then return end
    io.write(nextword, " ")
    w1 = w2; w2 = nextword
end
