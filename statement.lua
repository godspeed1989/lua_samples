-- allows multiple assignment
a, b = 10, 2*1
x, y = y, x             -- swap `x` and `y`

a, b, c = 0, 1
print(a, b, c)          --> 0   1   nil
a, b = a+1, b+1, b+2    -- b+2 is ignored
print(a, b)             --> 1   2
-- provide a value for each one to initialize
a, b, c = 0, 0, 0
print(a, b, c)          --> 0   0   0

--[[ a function call can return multiple values
a, b = f()
--]]

print()
x = 3
local i = 1             -- local to the chunk
while i<=x do
    local x = i*2       -- local to the while body
    print(x)            --> 2 4 6
    i = i + 1
end
print(x)                --> 3 (the global one)

--- delimit a block explicitly
do
    local a2 = 2*a
    local d = math.sqrt(b^2 - 4*a*c)
    x1 = (-b + d)/a2
    x2 = (-b - d)/a2
end     -- scope of `a2` and `d` ends here

print()
foo = 43
do
    -- save global to local
    local foo = foo
    foo = 1
end
print(foo)
