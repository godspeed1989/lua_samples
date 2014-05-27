a = 1; b = 1
op = "-"
if op == "+" then
    r = a + b
elseif op == "-" then
    r = a - b
elseif op == "*" then
    r = a * b
elseif op == "/" then
    r = a / b
else
    error("invalid operation")
end

-- while
local i = 1
arr = {11, 22, 33}
while arr[i] do
    print(arr[i])
    i = i + 1
end

-- print the first non-empty line
print()
repeat
    line = io.read()
until line ~= ""
print(line .. "\n")

-- Numeric for
from = 0
to = 3
step = 1    -- default 1
for var=from, to, step do
    print(var)
    if var == 2 then
        break
    end
end
v = var  -- Wrong! `var` here is local
print(v)

-- Generic for
print()
--- pairs() used for table
revDays = { ["Sunday"] = 1, ["Monday"] = 2, ["Tuesday"] = 3,
            ["Wednesday"] = 4, ["Thursday"] = 5, ["Friday"] = 6,
            ["Saturday"] = 7 }
for key,val in pairs(revDays) do
    print(key .. "-->" .. val)
end
print()
--- ipairs used for sequential indexed array
arr = { [0]=0, 1, 2, 3, [5]=5}
for idx,val in ipairs(arr) do
    print("[" .. idx .. "]\t" .. val)
    --> [1]     1
    --> [2]     2
    --> [3]     3
end

-- break/return only appear as the last statement of a block
function foo()
    return          --<< SYNTAX ERROR
end
foo()
