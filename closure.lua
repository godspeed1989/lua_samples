-- Closures are useful as arguments to higher-order functions
names = {"Peter", "Paul", "Mary"}
grades = {Mary = 10, Paul = 7, Peter = 8}

-- Grades is neither a global variable nor a local variable
-- We call it an external local variable, or an upvalue
function sortbygrade (names, grades)
    table.sort(names, function (n1, n2)
        return grades[n1] > grades [n2] -- compare grades
    end)
end

-- what is a value in Lua is the closure, not the function
-- 闭包指值而不是指函数
function newCounter ()
    local i = 0
    return function ()
             i = i + 1
             return i
           end
end
c1 = newCounter()
c2 = newCounter()
print(c1())          --> 1
print(c1())          --> 2
print(c2())          --> 1
print(c1())          --> 3

-- redefine math.sin function
do
    local oldSin = math.sin
    local k = math.pi/180
    math.sin = function (x)
        return oldSin(x*k)
    end
end
-- redefine io.open function
do
    local oldOpen = io.open
    io.open = function (filename, mode)
        if access_OK(filename, mode) then
            return oldOpen(filename, mode)
        else
            return nil, "access denied"
        end
    end
end
