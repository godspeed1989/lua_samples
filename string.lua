--- You cannot change a character inside a string
--- You just can create a new with desired modification

a = "one string"
b = string.gsub(a, "one", "another")  -- change string parts
print(a)       --> one string
print(b)       --> another string

page = [[
    <HTML>
    <HEAD>
    <TITLE>An HTML Page</TITLE>
    </HEAD>
    <BODY>
     <A HREF="http://www.lua.org">Lua</A>
     [a text between double brackets]
    </BODY>
    </HTML>
]]

print(page)
print("10" + 1)         --> 11
print("10 + 1")         --> 10+1
print("-5.3e-10"*"2")   --> -1.06e-09
--[[
print("hello" + 1)      --> ERROR
]]

-- .. is the string concatenation operator
print(10 .. 20)         --> 1020

print(tostring(10) == "10")     --> true
print(10 .. "" == "10")         --> true
print("" .. 10 == 10)           --> false

-- gfind was replaced by gmatch in Lua 5.2
for s in string.gmatch("a=b c=d", "[^%s+]=[^%s+]") do
    print(s)                    --> a=b --> c=d
end

line = io.read()    -- read a line
n = tonumber(line)
if n == nil then
    error(line .. " is not a valid number")
else
    print(n*2)
end
