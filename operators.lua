--- ~= is the negation of equality
a = "x"
b = 1
if a ~= b then
    print("a not equals b")
end

--- Compares tables, userdata, and functions by reference
a = {}; a.x = 1; a.y = 0
b = {}; b.x = 1; b.y = 0
c = a
print(a == c)
print(a == b)

--- Logical operators consider false and nil as FALSE
print()
--- 'and' return first FALSE one, else return second
print(true and 5)     --> 5
print(5 and true)     --> true
print(false and 5)    --> false
print(5 and false)    --> false
print()
--- 'or' return first TRUE one, else return second
print(4 or 5)         --> 4
print(false or 5)     --> 5
print(false or nil)   --> nil
print(nil or false)   --> false
