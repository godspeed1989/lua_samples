---[[ os library

--> 05/29/14
print(os.date("%x"))
--> today is Thursday, in May
print(os.date("Today is %A, in %B"))
--> hour:minute:second
print(os.date("%H : %M : %S"))

local x = os.clock()
local s = 0
for i = 1,0xfffff,1 do s = s + i end
print(string.format("elapsed time: %.2f\n", os.clock() - x))

print("[" .. os.getenv("PATH") .. "]")
function createDir (dirname)
    os.execute("mkdir " .. "")
end
--]]

---[[ string library
print()
pair = " =  Anna"
-- %a+ : non-empty char sequence
-- %s* : 0 or more space
_, _, key, value = string.find(pair, "(%a+)%s*=%s*(%a+)")
print(key, value)   --> name    Anna

-- %d+ : 1 or more 1-9 number
Date = "17/7/1990"
_, _, d, m, y = string.find(Date, "(%d+)/(%d+)/(%d+)")
print(d, m, y)      --> 17  7   1990

s = [[then he said: "it's all right"!]]
a, b, c, quotedPart = string.find(s, "([\"'])(.-)%1")
print(quotedPart)   --> it's all right
print(a, b, c)      --> 15  30   "

-- string replace
s = "\\command{some text}"
s = string.gsub(s, "\\(%a+){(.-)}", "<%1>%2</%1>")
print(s)

s = "sin(3) = $[math.sin(3)]; 2^5 = $[2^5]"
print((string.gsub(s, "$(%b[])", function (x)
    x = "return " .. string.sub(x, 2, -2)
    local f = loadstring(x)
    return f()
end)))

--]]

---[[ io library
print()
print(io.open("non-exist file", "r"))
    --> nil    No such file or directory       2

local f = assert(io.open("libs.lua", "r"))
local t = f:read("*all")
-- print(t)
f:close()

local count = 0
while true do
    local line = io.read()
    if line == nil then break end
    io.write(string.format("%6d   ", count), line, "\n")
    count = count + 1
end

local num = io.read("*number")
print(type(num), num)
local all = io.read("*all")
print(type(all), all)
local char3 = io.read(3)
print(type(char3), char3)

--]]
