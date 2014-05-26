--- first index with 1 not 0
days = {"Sunday", "Monday", "Tuesday", "Wednesday"}
print(days[4])              --> Wednesday

--- we can always add and remove fields to table
print()
w = {x=0, y=0, label="console"}
x = {math.sin(0), math.sin(1), math.sin(2)}
print(w[1]);                --> nil
w[1] = "another field"      -- add field
x.f = w                     -- add field
print(w[1])                 --> "another field"
print(x.f[1])               --> "another field"
w.x = nil                   -- remove field

--- linked list
print()
i = 0
list = nil
for line in io.lines() do
    list = {next=list, value=line}
    l = list
    i = i + 1
    -- print list
    while l do
        print(":" .. tostring(l.value))
        l = l.next
    end
    if i == 3 then
        break
    end
end

--- mix record-style and list-style initializations
print()
polyline = {
    color="blue", thickness=2, npoints=3;
    {x=0,   y=0},
    {x=-10, y=0},
    {x=0,   y=1},
    pending="pd"
}
print(polyline[2].x)        --> -10
print(polyline.pending)     --> pd
