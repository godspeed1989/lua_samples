-- use table to make library
Lib = {
    foo = function (x,y) return x + y end,
    goo = function (x,y) return x - y end,
}
function Lib.loo (x, y)
    return x * y
end

Lib.foo(1, 1)
Lib.loo(1, 2)

-- local function is restricted to a given scope
local f = function ()
    print("f");
end
local g = function ()
    f();
end
g()             --> f

-- for recursive local functions
-- first define variable then function
local fact
fact = function (n)
    if n == 0 then return 1
    else return n*fact(n-1)
    end
end
print("3! = ", fact(3))

-- indirect recursive functions
local f, g
local f = function ()
    g();
end
local g = function ()
    f();
end
