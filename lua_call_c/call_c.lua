mylib = require "mylib"

print("l", mylib.add2(1.2, 2.3))

arr = {}
for i = 2, 6 do
   table.insert(arr, i)
end

function inc (v)
    return v + 2
end

mylib.inc_array(arr, inc)

for i = 1, #arr do
   print("l", arr[i])
end
