
count = 0
function incCount(n)
    n = n or 1
    count = count + n
end
incCount()          -- argument n is nil
print(count)        --> 1
incCount(false)
print(count)        --> 2

-- multiple assignment allows 
ss, ee = string.find("hello Lua users", "Lua")
print(ss, ee)       --> 7   9

function maximum (a)
    local mi = 1
    local  m = a[mi]
    for i,val in ipairs(a) do
        if val > m then
            mi = i
             m = val
        end
    end
    return m, mi
end
print(maximum({8,10,23,12,5}))

function foo0 () end
function foo2 () return 'a','b' end
x, y, z = 10,foo2()     --> x=10, y='a', z='b'

-- adjust number of results to one
print(foo2(), 1)        --> a   1
a = {foo0()}            -- a = {} (an empty table)
print(table.getn(a))    --> 0
b = {foo0(), foo2(), 4}
print("b[1]", b[1])     --> b[1]    nil
print("b[2]", b[2])     --> b[2]    a
print("b[3]", b[3])     --> b[3]    4

-- unpack the array
print()
function foo() return foo2() end
print(foo())            --> a   b
print(foo2())           --> a   b
print((foo2()))         --> a
print(foo2(), 1)        --> a   1
c = {10, 20, 30}
print(c)                --> table: 0053bda8
print(unpack(c))        --> 10   20   30
-- unpack array to call a function with variable arguments
args = {"hello", "ll"}
print(string.find(unpack(args)))    --> 3   4
