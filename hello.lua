
-- file 'lib1.lua'
function norm (x,y)
    local n2 = x^2 + y^2
    return math.sqrt(n2)
end

function twice (x)
    return 2*x
end

b = 10
print(b)
-- delete a global variable
b = nil
print(b)

--[[
    print(10)      -- no action comment
--]]

---[[
    print(11)      -- print 11   
--]]

print("arg[-99] =", arg[-1])
print("arg[-1] =", arg[-1])
print("arg[ 0] =", arg[ 0])
print("arg[ 1] =", arg[ 1])
