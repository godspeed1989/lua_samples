a = {}              -- create a table
i = "x"
a[i] = 10           -- new entry key="x" and value=10
print(a["x"])       --> 10

a[20] = "great"     -- new entry key=20 and value="great"
k = 20
print(a[k])         --> "great"

a["x"] = a["x"] + 1 -- increments entry "x"
print(a["x"])       --> 11

b = a
b["x"] = 20
print(a["x"])       --> 20
a = nil
b = nil

--- table may store values with different types
a = {}              -- empty table
-- create 1000 new entries
print()
for i=1,1000 do
    a[i] = i*2
end
a["x"] = "a\[x\]"
print(a[9])         --> 18
print(a["x"])       --> a[x]

--- a.x is 'a' table indexed by the string "x"
print()
a = {}
x = "y"
a[x] = 10
print(a[x])         --> 10  value of field "y"
print(a.x)          --> nil value of field "x" (undefined)
print(a.y)          --> 10  value of field "y"

--- the first non-initialized index will result in nil
print()
a = {}
for i=1,3 do
    a[i] = io.read()
end
for i,line in ipairs(a) do
    print(i .. "\t" .. line)
end
